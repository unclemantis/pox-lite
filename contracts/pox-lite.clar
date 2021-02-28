(define-fungible-token boost)

(define-map deposits { block-height: uint } (list 100 { address: principal, amount: uint, memo: (buff 70)}))
(define-map boosts { block-height: uint } { address: principal, amount: uint })

(define-public (append-deposit (amount uint) (memo (buff 70)) (height uint))
  (match (get-deposits-by-height height)
    deps (if (map-set deposits { block-height: height}
               (unwrap! (as-max-len? (append deps { address: tx-sender, amount: amount, memo: memo }) u100)
                 (err u2)))
               (ok true)
               (err u3))
    error (err error)))

(define-public (deposit (amount uint) (memo (buff 70)) (height uint))
  (begin
    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps (if (map-insert deposits { block-height: height } (list { address: tx-sender, amount: amount, memo: memo }))
        (ok true)
        (append-deposit amount memo height))
      error (err error))))

(define-read-only (get-deposits-by-height (height uint))
  (let ((deposits-at-height (unwrap! (map-get? deposits {block-height: height }) (err u4))))
    (ok deposits-at-height)))

(define-read-only (get-deposit-address-by-height-and-index (height uint) (index uint))
  (let ((d (unwrap! (get-deposits-by-height height) (err u5))))
    (ok (get address (element-at d index))))
)

(define-public (randomize (seed uint) (max uint))
  (ok (mod (+ u94827 (* u983354 seed)) max)))

(define-private (mint-boost (height uint) (address principal) (amount uint))
  (begin
    (try! (ft-mint? boost amount address))
      (map-set boosts { block-height: height } { address: address, amount: amount })
      (stx-transfer? amount tx-sender address)))