(define-fungible-token stinger)

(define-data-var last-height uint u0)

(define-map deposits { block-height: uint } (list 100 { address: principal, amount: uint, low: uint, high: uint, memo: (buff 70)}))

(define-read-only (get-deposit-last-high-by-height (height uint))
  (let ((d (unwrap! (map-get? deposits {block-height: height }) (err u1))))
    (ok (unwrap! (get high (element-at d (- (len d) u1))) (err u2)))))

(define-private (append-deposit (amount uint) (memo (buff 70)) (height uint))
  (match (get-deposits-by-height height)
      deps (if (map-set deposits { block-height: height}
                 (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, low: (unwrap! (get-deposit-last-high-by-height height) (err u2)), high: (+ amount (unwrap! (get-deposit-last-high-by-height height) (err u3))), memo: memo }) u100)
                   (err u4)))
                 (ok true)
                 (err u5))
      error (err u6)))

(define-read-only (get-deposits-by-height (height uint))
  (let ((deposits-at-height (unwrap! (map-get? deposits {block-height: height }) (err u7))))
    (ok deposits-at-height)))

(define-public (deposit (amount uint) (memo (buff 70)))
  (begin
    (try! (if (> block-height (var-get last-height))
      (award-stinger (var-get last-height))
      (ok false)))

    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps  (begin
              (var-set last-height block-height)
              (if (map-insert deposits { block-height: block-height } (list { address: tx-sender, amount: amount, low: u1, high: amount, memo: memo }))
                (ok true)
                (append-deposit amount memo block-height)))
      error (err u12))))

(define-private (randomize (seed uint) (max uint))
  (+ u1 (mod (+ u1013904223 (* u1664525 seed)) max)))

(define-private (get-winning-address (entry { address: principal, amount: uint, low: uint, high: uint, memo: (buff 80)})
  (context { random-value: uint, result: (optional principal)}))

  (let ((random-value (get random-value context)) (result (get result context)))
  (if (is-some result) 
    context
    (if (and (> random-value (get low entry)) (< random-value (get high entry)))
        {random-value: random-value, result: (some (get address entry))}
        context))))

(define-private (award-stinger (height uint))
    (if (> height u0)
      (let ((h (unwrap! (get-deposit-last-high-by-height height) (err u12))))
        (let ((d (unwrap! (get-deposits-by-height height) (err u8))))
          (if (> (len d) u0)
            (let ((a (unwrap! (get result (fold get-winning-address d {random-value: (randomize block-height h), result: none})) (err u14))))
              (ft-mint? stinger h a))
            (err u843))))
      (ok false)))

(define-public (redeem-stinger (amount uint))
  (let ((recipient tx-sender))
    (let ((b (ft-get-balance stinger recipient)))
      (if (>= b amount)
          (begin
            (try! (as-contract (ft-transfer? stinger amount recipient tx-sender)))
            (try! (as-contract (stx-transfer? amount tx-sender recipient)))
            (ok true)
          )
          (err u9)))))
