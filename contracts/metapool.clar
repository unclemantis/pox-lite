;; created by @pxydn

;; metapool token and functions

(define-fungible-token metapool)

;; known addresses of the pool and control servers

(define-constant controlAddress "SP3HXQGX95WRVMQ3WESCMC4JCTJPJEBHGP7BEFRGE")
(define-constant poolAddress "SP1N6FAZTJZ360QAZGRDCJC2S38RZ1EZ62SPF93CC")

;; map for storing all contributions to the pool

(define-map contributions { address: principle } { satsContributed: uint, committedAtBlock: uint })

(define-private (mintMetapool (address principle) (amount int))
    (ft-mint? metapool amount address))

;; if contract caller is control address return true

(define-private (contractCallerIsControlAddress)
    (if (is-eq contract-caller controlAddress)
        true
        false))

;; sets an address' contribution in the contributions map

(define-private (setContributionTo (address principle) (satsContributed int))
    (map-set contributions { address: address } { satsContributed: satsContributed } { committedAtBlock: block-height })

;; redeems the rewards for an address. sends them their share of STX rewards and burns their metapool tokens
;; rewards are only available after the address' contribution has been in the pool for 1000 blocks (1 cycle)

(define-private (redeemRewardsFor (address principle))

;; if the address committed bitcoin 1000 or more blocks ago, return true

(define-private (addressCommitted1000BlocksAgo)
    ;; returns true if the contract caller committed their bitcoin 1000 or more blocks before
    (if 
        (>= 
            (- block-height 
                (try! (map-get? contributions { address: contract-caller })))))

;; requests to redeem rewards for an address. request is denied if addressCommitted1000BlocksAgo returns false. rewards given if returns true.

(define-public (redeemRewards)
    (if (>= block-height (map-get? contributions )))

    ;; amount of sats this address contributed to the pool
    (define-data-var satsContributed int 
        (ft-get-balance metapool contract-caller))

    ;; total of sats all address have committed to the pool
    (define-data-var totalSatsContributed int
        (ft-get-supply metapool))
    
    ;; 90% of the total STX rewards the pool generated (10% fee) 
    (define-data-var totalRewards int 
        (* 0.9 (stx-get-balance (as-contract tx-sender))))

    (define-data-var rewardAmount int 
        (* totalRewards (/ satsContributed totalSatsContributed)))
    (as-contract
        (stx-transfer? rewardAmount tx-sender address))

;; requests to update the contribution by an address
;; only allows changes from calls from the control address

(define-public (changeContribution (amountInSats int) (stxAddress principle))
    ;; check if contract caller is one of the control addresses 
    (if (contractCallerIsControlAddress)
        ;; set address
        (setContributionTo stxAddress amountInSats)
        ;; mint metapool tokens
        (mintMetapool stxAddress amountInSats)

        (err u1)
