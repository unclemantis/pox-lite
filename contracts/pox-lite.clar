(define-fungible-token boost)

(define-data-var last-height uint u0)

(define-map deposits { block-height: uint } (list 100 { address: principal, amount: uint, low: uint, high: uint, memo: (buff 70)}))

(define-read-only (get-deposit-last-high-by-height (height uint))
  (let ((d (unwrap! (map-get? deposits {block-height: height }) (err u100))))
    (ok (unwrap-panic (get high (element-at d (- u1 (len d))))))))

(define-public (append-deposit (amount uint) (memo (buff 70)) (height uint))
  (match (get-deposits-by-height height)
      deps (if (map-set deposits { block-height: height}
                 (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, low: (unwrap! (get-deposit-last-high-by-height height) (err u838)), high: (+ u1 (unwrap! (get-deposit-last-high-by-height height) (err u838))), memo: memo }) u100)
                   (err u2)))
                 (ok true)
                 (err u3))
      error (err error)))

(define-read-only (get-deposits-by-height (height uint))
  (let ((deposits-at-height (unwrap! (map-get? deposits {block-height: height }) (err u4))))
    (ok deposits-at-height)))

(define-public (deposit (amount uint) (memo (buff 70)))
  (begin
    (try! (if (> block-height (var-get last-height))
      (award-boost (var-get last-height))
      (ok false)))

    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps (if (map-insert deposits { block-height: block-height } (list { address: tx-sender, amount: amount, low: u1, high: amount, memo: memo }))
        (ok true)
        (append-deposit amount memo block-height))
      error (err error))
    
;;    (let ((h block-height)
;;      if( (> h u0)
;;        (var-set last-height h)
;;        (ok false))))
))

(define-read-only (randomize (seed uint) (max uint))
  (mod (+ u1013904223 (* u1664525 seed)) max))

(define-private (get-winning-address (entry { address: principal, amount: uint, low: uint, high: uint, memo: (buff 70)})
  (context { random-value: uint, result: (optional principal)}))

  (let ((random-value (get random-value context)) (result (get result context)))
  (if (is-some result) 
    context
    (if (and (> random-value (get low entry)) (< random-value (get high entry)))
        {random-value: random-value, result: (some (get address entry))}
        context))))

(define-private (award-boost (height uint))
  (begin
  (if (> height u0)
    (ft-mint? boost (unwrap! (get-deposit-last-high-by-height height) (err u838)) (unwrap! (get result (fold get-winning-address (unwrap! (get-deposits-by-height height) (err u09324)) {random-value: (randomize block-height (unwrap! (get-deposit-last-high-by-height height) (err u838))), result: none})) (err u847)))
    (ok false)
  )))

(define-public (redeem-boost-stx (amount uint))
  (begin
    (if (>= amount (ft-get-balance boost tx-sender))
      (match (ft-burn? boost amount tx-sender)
        transfer (stx-transfer? amount (as-contract tx-sender) tx-sender)
        error (err error))
      (err u823))))