(define-fungible-token boost)
(define-data-var last-deposit-id int 0)
(define-data-var last-boost-id int 0)

(define-map deposits { height: uint } { deposit-id: int, address: principal, amount: uint, memo: (string-utf8 80) })
(define-map boosts { boost-id: int } { height: uint, address: principal, amount: uint })

(define-public (deposit (amount uint) (address principal) (memo (string-utf8 80)))
  (begin
    (var-set last-deposit-id (+ 1 (var-get last-deposit-id)))
    (if (map-insert deposits { height: block-height } { deposit-id: (var-get last-deposit-id), address: address, amount: amount, memo: memo })
      (ok true)
      (err u1)
    )
  )
)

(define-private (mint-boost (height uint) (address principal) (amount uint))
  (begin
    (try! (ft-mint? boost amount address))
    (var-set last-boost-id (+ 1 (var-get last-boost-id)))
    (if (map-insert boosts { boost-id: (var-get last-boost-id) } { height: height, address: address, amount: amount })
      (stx-transfer? amount tx-sender address)
      (err u1)
    )
  )
)

(define-public (get-deposit-amounts-by-height (height uint))
  (ok (get amount (map-get? deposits { height: height }))))

(define-private (get-last-deposit-id)
  (var-get last-deposit-id))
