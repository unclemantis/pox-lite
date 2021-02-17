(define-data-var deposit-id int 0)
(define-map deposits { height: uint } { deposit-id: int, address: principal, amount: uint})
(define-private (deposit (amount uint) (address principal))
  (begin
    (var-set deposit-id (+ (var-get deposit-id) 1))
    (map-set deposits { height: block-height } { deposit-id: (var-get deposit-id), address: address, amount: amount})))
