(define-data-var deposit-id int 0)

(define-map deposits { deposit-id: int } { height: uint, address: principal, amount: uint, memo: (string-ascii 80) })

(define-public (deposit (amount uint) (address principal) (memo (string-ascii 80)))
  (begin
    (var-set deposit-id (+ 1 (var-get deposit-id)))
    (if (map-insert deposits { deposit-id: (var-get deposit-id) } { height: block-height, address: address, amount: amount, memo: memo })
      (ok true)
      (err u1)
    )
  )
)

(define-private (get-last-deposit-id)
  (var-get deposit-id))

(define-private (get-last-deposit-address)
  (get address (map-get? deposits { deposit-id: (get-last-deposit-id)})))
