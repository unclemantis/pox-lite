(define-fungible-token boost)

(define-map deposits { height: uint } (list 100 { address: principal, amount: uint, memo: (buff 70)}))
(define-map boosts { height: uint } { address: principal, amount: uint })

(define-public (deposit (height uint) (address principal) (amount uint) (memo (buff 70)))
  (if (map-set deposits { height: height } (list { address: address, amount: amount, memo: memo }))
    (ok true)
    (err u1)
  ))

(define-read-only (get-deposits-by-height (height uint))
(let ((deposits-at-height (unwrap! (map-get? deposits {height: height }) (err 1))))
  (ok deposits-at-height)))

(define-private (mint-boost (height uint) (address principal) (amount uint))
  (begin
    (try! (ft-mint? boost amount address))
      (map-set boosts { height: height } { address: address, amount: amount })
      (stx-transfer? amount tx-sender address)))