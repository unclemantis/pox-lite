(define-fungible-token boost)
(define-data-var last-height-deposit-total uint u0)

(define-map height-deposit-totals { height: uint } { amount: uint })
(define-map deposits { height: uint } (list 100 { address: principal, amount: uint, memo: (buff 70)}))
(define-map boosts { height: uint } { address: principal, amount: uint })

(define-public (append-deposit (amount uint) (memo (buff 70)))
  (match (get-deposits-by-height block-height)
    deps (if (map-set deposits { height: block-height}
               (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, memo: memo }) u100)
                 (err u2)))
               (increase-height-deposit-total block-height amount)
               (err u3))
    error (err error)))

(define-private (increase-height-deposit-total (height uint) (amount uint))
  (begin
    (var-set last-height-deposit-total u0)
    (if (> (get amount (map-get? height-deposit-totals { height: height })) u0)
      (var-get last-height-deposit-total (+ amount (var-get last-height-deposit-total)))
      (var-set last-height-deposit-total u0)
    )
    (map-set height-deposit-totals { height: height } { amount: (var-get last-height-deposit-total) })
    (ok true)
  )
)

(define-public (deposit (amount uint) (memo (buff 70)))
  (begin
    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps (if (map-insert deposits { height: block-height } (list { address: tx-sender, amount: amount, memo: memo }))
        (increase-height-deposit-total block-height amount)
        (append-deposit amount memo))
      error (err error))
  )
)

(define-read-only (get-deposits-by-height (height uint))
(let ((deposits-at-height (unwrap! (map-get? deposits {height: height }) (err u1))))
  (ok deposits-at-height)))

(define-private (mint-boost (height uint) (address principal) (amount uint))
  (begin
    (try! (ft-mint? boost amount address))
      (map-set boosts { height: height } { address: address, amount: amount })
      (stx-transfer? amount tx-sender address)))