(define-fungible-token boost)

(define-map deposits { height: uint } (list 100 { address: principal, amount: uint, memo: (buff 70)}))
(define-map boosts { height: uint } { address: principal, amount: uint })

(define-public (append-deposit (amount uint) (memo (buff 70)))
  (match (get-deposits-by-height block-height)
    deps (if (map-set deposits { height: block-height}
               (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, memo: memo }) u100)
                 (err u2)))
               (ok true)
               (err u3))
    error (err error)))

(define-public (deposit (amount uint) (memo (buff 70)))
  (begin
    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps (if (map-insert deposits { height: block-height } (list { address: tx-sender, amount: amount, memo: memo }))
        (ok true)
        (append-deposit amount memo))
      error (err error))))

(define-read-only (get-deposits-by-height (height uint))
(let ((deposits-at-height (unwrap! (map-get? deposits {height: height }) (err u1))))
  (ok deposits-at-height)))

(define-private (mint-boost (height uint) (address principal) (amount uint))
  (begin
    (try! (ft-mint? boost amount address))
      (map-set boosts { height: height } { address: address, amount: amount })
      (stx-transfer? amount tx-sender address)))