(define-fungible-token boost)

(define-data-var last-height uint u0)

(define-map deposits { block-height: uint } (list 100 { address: principal, amount: uint, low: uint, high: uint, memo: (buff 70)}))

(define-read-only (get-deposit-last-high-by-height (height uint))
  (let ((d (unwrap! (map-get? deposits {block-height: height }) (err u1))))
    (ok (unwrap! (get high (element-at d (- u1 (len d)))) (err u2)))))

(define-private (append-deposit (amount uint) (memo (buff 70)) (height uint))
  (match (get-deposits-by-height height)
      deps (if (map-set deposits { block-height: height}
                 (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, low: (unwrap! (get-deposit-last-high-by-height height) (err u2)), high: (+ u1 (unwrap! (get-deposit-last-high-by-height height) (err u3))), memo: memo }) u100)
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
      (award-boost (var-get last-height))
      (ok false)))

    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps  (begin
        (var-set last-height block-height)
        (if (map-insert deposits { block-height: block-height } (list { address: tx-sender, amount: amount, low: u1, high: amount, memo: memo }))
        (ok true)
        (append-deposit amount memo block-height)))
      error (err u12))
))

(define-read-only (randomize (seed uint) (max uint))
  (+ u1 (mod (+ u1013904223 (* u1664525 seed)) max)))

(define-private (get-winning-address (entry { address: principal, amount: uint, low: uint, high: uint, memo: (buff 70)})
  (context { random-value: uint, result: (optional principal)}))

  (let ((random-value (get random-value context)) (result (get result context)))
  (if (is-some result) 
    context
    (if (and (> random-value (get low entry)) (< random-value (get high entry)))
        {random-value: random-value, result: (some (get address entry))}
        context))))

(define-private (award-boost (height uint))
    (if (> (var-get last-height) u0)
      (let ((d (unwrap! (get-deposit-last-high-by-height height) (err u12))))
        (ft-mint? boost d (unwrap! (get result (fold get-winning-address (unwrap! (get-deposits-by-height height) (err u8)) {random-value: (randomize block-height d), result: none})) (err u14))))
        (ok false)
     )
  )

(define-public (redeem-boost (amount uint))
  (let ((recipient tx-sender))
    (if (>= amount (ft-get-balance boost tx-sender))
      (as-contract (stx-transfer? amount tx-sender recipient))
      (err u9))))

(define-public (transfer-boost (address principal) (amount uint))
  (begin
    (if (>= amount (ft-get-balance boost tx-sender))
      (match (ft-transfer? boost amount tx-sender address)
        transfer (stx-transfer? amount tx-sender address)
        error (err u10))
      (err u11))))