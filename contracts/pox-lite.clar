(define-data-var deposit-id int 0)

(define-map deposits
{ height: uint }
{ deposit-id: int,
  address: principal,
  amount: uint,
  memo: (optional (string-ascii 80))
})

(define-private (deposit (amount uint) (address principal) (memo (string-ascii 80)))
  (var-set deposit-id (+ (var-get deposit-id) 1))
  (map-insert deposits {height: block-height } { deposit-id: (var-get deposit-id), address: address, amount: amount, memo: memo}))

(begin
  (deposit u100 'SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB "I am going to win"))