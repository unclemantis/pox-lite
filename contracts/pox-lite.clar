(define-fungible-token boost)

(define-map deposits { height: uint } { address: principal, amount: uint, memo: (buff 70) })
(define-map boosts { height: uint } { address: principal, amount: uint })

(define-public (deposit (height uint) (address principal) (amount uint) (memo (buff 70)))
  (if (map-insert deposits { height: height } { address: address, amount: amount, memo: memo })
    (ok true)
    (err u1)
  ))

(define-private (mint-boost (height uint) (address principal) (amount uint))
  (begin
    (try! (ft-mint? boost amount address))
      (map-insert boosts { height: height } { address: address, amount: amount })
      (stx-transfer? amount tx-sender address)))