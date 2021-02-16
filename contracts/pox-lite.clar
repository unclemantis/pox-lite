(define-data-var deposit-id int 0)

(define-map deposits
{ height: uint }
{ deposit-id: int,
  address: principal,
  amount: uint,
  memo: (string-ascii 80)})

(define-private (deposit (amount uint) (address principal) (memo (string-ascii 80)))
  (begin
    (var-set deposit-id (+ (var-get deposit-id) 1))
    (map-insert deposits
    { height: block-height }
    { deposit-id: (var-get deposit-id),
      address: address,
      amount: amount,
      memo: memo})
  )
)