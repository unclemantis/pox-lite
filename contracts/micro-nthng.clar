
(define-fungible-token micro-nothing)

(define-data-var total-supply uint u0)

(define-read-only (get-total-supply)
  (var-get total-supply))

(define-private (mint! (account principal) (amount uint))
  (if (<= amount u0)
      (err u0)
      (begin
        (var-set total-supply (+ (var-get total-supply) amount))
        (ft-mint? micro-nothing amount account))))


(define-public (transfer (to principal) (amount uint)) 
  (if 
    (> (ft-get-balance micro-nothing tx-sender) u0)
    (ft-transfer? micro-nothing amount tx-sender to)
    (err u0)))

;;

(define-private (send-nothing (to principal))
  (try! (contract-call? .micro-nthng transfer to u100000)))

(define-public (airdrop (recipients (list 750 principal)) (amount uint))
  (begin
    (map send-nothing recipients)
    (ok u0)))

;;

(mint! 'SP1AWFMSB3AGMFZY9JBWR9GRWR6EHBTMVA9JW4M20 u20000000000000)
(mint! 'SP1K1A1PMGW2ZJCNF46NWZWHG8TS1D23EGH1KNK60 u20000000000000)
(mint! 'SP2F2NYNDDJTAXFB62PJX351DCM4ZNEVRYJSC92CT u20000000000000)
(mint! 'SP32AEEF6WW5Y0NMJ1S8SBSZDAY8R5J32NBZFPKKZ u20000000000000)
(mint! 'SPT9JHCME25ZBZM9WCGP7ZN38YA82F77YM5HM08B  u20000000000000)