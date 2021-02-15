(define-data-var deposit-id int 0)

(define-map deposits { height: uint } { deposit-id: int, address: principal, amount: uint, memo: (optional (string-ascii 80))})

(define-private (deposit (amount uint) (address principal) (memo (string-ascii 80)))
    (var-set deposit-id (+ (var-get deposit-id) 1))
    (map-insert deposits {height: block-height } { deposit-id: (var-get deposit-id), address: address, amount: amount, memo: memo}))

(define-private (get-block-deposits (height uint))
                  (let ((deposits (unwrap! (map-get? deposits { height: height }) (err 1))))
                    (ok deposits))))

(begin
  (deposit u100 tx-sender "I am going to win")
  (deposit u150 tx-sender "NO! I am going to win!")
  (get-block-deposits block-height))
