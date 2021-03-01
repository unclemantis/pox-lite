(define-fungible-token boost)

(define-data-var last-height uint u0)

(define-map deposits { block-height: uint } (list 100 { address: principal, amount: uint, memo: (buff 70)}))

(define-public (append-deposit (amount uint) (memo (buff 70)) (height uint))
  (match (get-deposits-by-height height)
    deps (if (map-set deposits { block-height: height}
               (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, memo: memo }) u100)
                 (err u2)))
               (ok true)
               (err u3))
    error (err error)))

(define-public (deposit (amount uint) (memo (buff 70)) (height uint))
  (begin
    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps (if (map-insert deposits { block-height: height } (list { address: tx-sender, amount: amount, memo: memo }))
        (ok true)
        (append-deposit amount memo height))
      error (err error))))

(define-read-only (get-deposits-by-height (height uint))
  (let ((deposits-at-height (unwrap! (map-get? deposits {block-height: height }) (err u4))))
    (ok deposits-at-height)))

(define-read-only (get-deposit-address-by-height-and-index (height uint) (index uint))
  (let ((d (unwrap! (get-deposits-by-height height) (err u5))))
    (ok (unwrap! (get address (element-at d index)) (err u6)))))

(define-read-only (randomize (seed uint) (max uint))
  (mod (+ u1013904223 (* u1664525 seed)) max))

(define-public (enter (amount uint) (memo (buff 70)))
  (begin
    (try! (deposit amount memo block-height))
    (if (> block-height (var-get last-height))
      (if (> (var-get last-height) u0)
        (mint-boost)
        (ok true)
      )
      (ok true))))

(define-public (get-mint-address)
  (get-deposit-address-by-height-and-index (var-get last-height) (randomize (var-get last-height) (len (unwrap! (get-deposits-by-height (var-get last-height)) (err u7))))))

(define-private (mint-boost)
  (ft-mint? boost u1 (unwrap! (get-mint-address) (err u8))))
