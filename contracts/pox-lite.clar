(define-data-var deposit-id int 0)

(define-map deposits { deposit-id: int } { height: uint, address: principal, amount: uint, memo: (string-ascii 80) })

(define-read-only (get-deposit-id)
  (var-get deposit-id))

(define-private (increment-deposit-id)
  (var-set deposit-id (+ 1 (get-deposit-id))))

(define-private (deposit (amount uint) (address principal) (memo (string-ascii 80)))
  (begin
    (increment-deposit-id)
    (map-insert deposits { deposit-id: (var-get deposit-id) } { height: block-height, address: address, amount: amount, memo: memo })))