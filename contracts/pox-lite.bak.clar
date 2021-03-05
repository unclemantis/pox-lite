(define-fungible-token boost)

(define-data-var last-height uint block-height)
(define-data-var last-amount uint u0)

(define-map deposits { block-height: uint } (list 100 { address: principal, amount: uint, memo: (buff 70)}))
(define-map amounts { block-height: uint } { amount: uint })

(define-private (update-block-amount (height uint) (amount uint))
  (match (get-amount-by-height height)
    amnt (if (map-insert amounts { block-height: height } {amount: (+ amnt amount) })
               (ok true)
               (err u10))
    error (err error)))


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
;;    (try! (update-block-amount height amount))
    (match (stx-transfer? amount tx-sender (as-contract tx-sender))
      deps (if (map-insert deposits { block-height: height } (list { address: tx-sender, amount: amount, memo: memo }))
        (ok true)
        (append-deposit amount memo height))
      error (err error)
    )
  )
)

(define-read-only (get-amount-by-height (height uint))
  (let ((amount-at-height (get amount (unwrap! (map-get? amounts {block-height: height }) (err u4)))))
    (ok amount-at-height)))

(define-read-only (get-deposits-by-height (height uint))
  (let ((deposits-at-height (unwrap! (map-get? deposits {block-height: height }) (err u4))))
    (ok deposits-at-height)))

(define-read-only (get-deposit-address-by-height-and-index (height uint) (index uint))
  (let ((d (unwrap! (get-deposits-by-height height) (err u5))))
    (ok (unwrap! (get address (element-at d index)) (err u6)))))

(define-read-only (randomize (seed uint) (max uint))
  (mod (+ u1013904223 (* u1664525 seed)) max))

(define-public (enter (amount uint) (memo (buff 70)))
;;  (begin
    (try! (deposit amount memo block-height))
;;    (if (> block-height (var-get last-height))
;;        (mint-boost)
;;        (ok true)
;;      ))
)

(define-public (get-mint-address)
  (get-deposit-address-by-height-and-index (var-get last-height) (randomize (var-get last-height) (len (unwrap! (get-deposits-by-height (var-get last-height)) (err u7))))))

(define-private (mint-boost)
  (ft-mint? boost u1 (unwrap! (get-mint-address) (err u8))))
