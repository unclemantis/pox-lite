(define-data-var vrf-buf (buff 32) 0x00)
(define-data-var vrf-short (buff 32) 0x00)
(define-data-var counter uint u0)

(define-private (first-eight-bytes (x (buff 1)))
    (begin
        (var-set counter (+ (var-get counter) u1))
        (asserts! (<= (var-get counter) u8) false)))

(define-private (get-random-integer (block-height-input uint))
    (begin
        (var-set vrf-buf (unwrap! (get-block-info? vrf-seed block-height-input) (err "invalid block height input")))
        (var-set vrf-short (filter first-eight-bytes (var-get vrf-buf)))
        (var-set counter u0)
        (ok (get val (unwrap! (bytes-to-uint (var-get vrf-short)) (err "cannot unwrap"))))))


(define-private (byte-between-00-and-31? (b (buff 1)))
  (if (is-eq b 0x00) (some u0)
  (if (is-eq b 0x01) (some u1)
  (if (is-eq b 0x02) (some u2)
  (if (is-eq b 0x03) (some u3)
  (if (is-eq b 0x04) (some u4)
  (if (is-eq b 0x05) (some u5)
  (if (is-eq b 0x06) (some u6)
  (if (is-eq b 0x07) (some u7)
  (if (is-eq b 0x08) (some u8)
  (if (is-eq b 0x09) (some u9)
  (if (is-eq b 0x0A) (some u10)
  (if (is-eq b 0x0B) (some u11)
  (if (is-eq b 0x0C) (some u12)
  (if (is-eq b 0x0D) (some u13)
  (if (is-eq b 0x0E) (some u14)
  (if (is-eq b 0x0F) (some u15)
  (if (is-eq b 0x10) (some u16)
  (if (is-eq b 0x11) (some u17)
  (if (is-eq b 0x12) (some u18)
  (if (is-eq b 0x13) (some u19)
  (if (is-eq b 0x14) (some u20)
  (if (is-eq b 0x15) (some u21)
  (if (is-eq b 0x16) (some u22)
  (if (is-eq b 0x17) (some u23)
  (if (is-eq b 0x18) (some u24)
  (if (is-eq b 0x19) (some u25)
  (if (is-eq b 0x1A) (some u26)
  (if (is-eq b 0x1B) (some u27)
  (if (is-eq b 0x1C) (some u28)
  (if (is-eq b 0x1D) (some u29)
  (if (is-eq b 0x1E) (some u30)
  (if (is-eq b 0x1F) (some u31) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-32-and-63? (b (buff 1)))
  (if (is-eq b 0x20) (some u32)
  (if (is-eq b 0x21) (some u33)
  (if (is-eq b 0x22) (some u34)
  (if (is-eq b 0x23) (some u35)
  (if (is-eq b 0x24) (some u36)
  (if (is-eq b 0x25) (some u37)
  (if (is-eq b 0x26) (some u38)
  (if (is-eq b 0x27) (some u39)
  (if (is-eq b 0x28) (some u40)
  (if (is-eq b 0x29) (some u41)
  (if (is-eq b 0x2A) (some u42)
  (if (is-eq b 0x2B) (some u43)
  (if (is-eq b 0x2C) (some u44)
  (if (is-eq b 0x2D) (some u45)
  (if (is-eq b 0x2E) (some u46)
  (if (is-eq b 0x2F) (some u47)
  (if (is-eq b 0x30) (some u48)
  (if (is-eq b 0x31) (some u49)
  (if (is-eq b 0x32) (some u50)
  (if (is-eq b 0x33) (some u51)
  (if (is-eq b 0x34) (some u52)
  (if (is-eq b 0x35) (some u53)
  (if (is-eq b 0x36) (some u54)
  (if (is-eq b 0x37) (some u55)
  (if (is-eq b 0x38) (some u56)
  (if (is-eq b 0x39) (some u57)
  (if (is-eq b 0x3A) (some u58)
  (if (is-eq b 0x3B) (some u59)
  (if (is-eq b 0x3C) (some u60)
  (if (is-eq b 0x3D) (some u61)
  (if (is-eq b 0x3E) (some u62)
  (if (is-eq b 0x3F) (some u63) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-64-and-95? (b (buff 1)))
  (if (is-eq b 0x40) (some u64)
  (if (is-eq b 0x41) (some u65)
  (if (is-eq b 0x42) (some u66)
  (if (is-eq b 0x43) (some u67)
  (if (is-eq b 0x44) (some u68)
  (if (is-eq b 0x45) (some u69)
  (if (is-eq b 0x46) (some u70)
  (if (is-eq b 0x47) (some u71)
  (if (is-eq b 0x48) (some u72)
  (if (is-eq b 0x49) (some u73)
  (if (is-eq b 0x4A) (some u74)
  (if (is-eq b 0x4B) (some u75)
  (if (is-eq b 0x4C) (some u76)
  (if (is-eq b 0x4D) (some u77)
  (if (is-eq b 0x4E) (some u78)
  (if (is-eq b 0x4F) (some u79)
  (if (is-eq b 0x50) (some u80)
  (if (is-eq b 0x51) (some u81)
  (if (is-eq b 0x52) (some u82)
  (if (is-eq b 0x53) (some u83)
  (if (is-eq b 0x54) (some u84)
  (if (is-eq b 0x55) (some u85)
  (if (is-eq b 0x56) (some u86)
  (if (is-eq b 0x57) (some u87)
  (if (is-eq b 0x58) (some u88)
  (if (is-eq b 0x59) (some u89)
  (if (is-eq b 0x5A) (some u90)
  (if (is-eq b 0x5B) (some u91)
  (if (is-eq b 0x5C) (some u92)
  (if (is-eq b 0x5D) (some u93)
  (if (is-eq b 0x5E) (some u94)
  (if (is-eq b 0x5F) (some u95) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-96-and-127? (b (buff 1)))
  (if (is-eq b 0x60) (some u96)
  (if (is-eq b 0x61) (some u97)
  (if (is-eq b 0x62) (some u98)
  (if (is-eq b 0x63) (some u99)
  (if (is-eq b 0x64) (some u100)
  (if (is-eq b 0x65) (some u101)
  (if (is-eq b 0x66) (some u102)
  (if (is-eq b 0x67) (some u103)
  (if (is-eq b 0x68) (some u104)
  (if (is-eq b 0x69) (some u105)
  (if (is-eq b 0x6A) (some u106)
  (if (is-eq b 0x6B) (some u107)
  (if (is-eq b 0x6C) (some u108)
  (if (is-eq b 0x6D) (some u109)
  (if (is-eq b 0x6E) (some u110)
  (if (is-eq b 0x6F) (some u111)
  (if (is-eq b 0x70) (some u112)
  (if (is-eq b 0x71) (some u113)
  (if (is-eq b 0x72) (some u114)
  (if (is-eq b 0x73) (some u115)
  (if (is-eq b 0x74) (some u116)
  (if (is-eq b 0x75) (some u117)
  (if (is-eq b 0x76) (some u118)
  (if (is-eq b 0x77) (some u119)
  (if (is-eq b 0x78) (some u120)
  (if (is-eq b 0x79) (some u121)
  (if (is-eq b 0x7A) (some u122)
  (if (is-eq b 0x7B) (some u123)
  (if (is-eq b 0x7C) (some u124)
  (if (is-eq b 0x7D) (some u125)
  (if (is-eq b 0x7E) (some u126)
  (if (is-eq b 0x7F) (some u127) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-128-and-159? (b (buff 1)))
  (if (is-eq b 0x80) (some u128)
  (if (is-eq b 0x81) (some u129)
  (if (is-eq b 0x82) (some u130)
  (if (is-eq b 0x83) (some u131)
  (if (is-eq b 0x84) (some u132)
  (if (is-eq b 0x85) (some u133)
  (if (is-eq b 0x86) (some u134)
  (if (is-eq b 0x87) (some u135)
  (if (is-eq b 0x88) (some u136)
  (if (is-eq b 0x89) (some u137)
  (if (is-eq b 0x8A) (some u138)
  (if (is-eq b 0x8B) (some u139)
  (if (is-eq b 0x8C) (some u140)
  (if (is-eq b 0x8D) (some u141)
  (if (is-eq b 0x8E) (some u142)
  (if (is-eq b 0x8F) (some u143)
  (if (is-eq b 0x90) (some u144)
  (if (is-eq b 0x91) (some u145)
  (if (is-eq b 0x92) (some u146)
  (if (is-eq b 0x93) (some u147)
  (if (is-eq b 0x94) (some u148)
  (if (is-eq b 0x95) (some u149)
  (if (is-eq b 0x96) (some u150)
  (if (is-eq b 0x97) (some u151)
  (if (is-eq b 0x98) (some u152)
  (if (is-eq b 0x99) (some u153)
  (if (is-eq b 0x9A) (some u154)
  (if (is-eq b 0x9B) (some u155)
  (if (is-eq b 0x9C) (some u156)
  (if (is-eq b 0x9D) (some u157)
  (if (is-eq b 0x9E) (some u158)
  (if (is-eq b 0x9F) (some u159) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-160-and-191? (b (buff 1)))
  (if (is-eq b 0xA0) (some u160)
  (if (is-eq b 0xA1) (some u161)
  (if (is-eq b 0xA2) (some u162)
  (if (is-eq b 0xA3) (some u163)
  (if (is-eq b 0xA4) (some u164)
  (if (is-eq b 0xA5) (some u165)
  (if (is-eq b 0xA6) (some u166)
  (if (is-eq b 0xA7) (some u167)
  (if (is-eq b 0xA8) (some u168)
  (if (is-eq b 0xA9) (some u169)
  (if (is-eq b 0xAA) (some u170)
  (if (is-eq b 0xAB) (some u171)
  (if (is-eq b 0xAC) (some u172)
  (if (is-eq b 0xAD) (some u173)
  (if (is-eq b 0xAE) (some u174)
  (if (is-eq b 0xAF) (some u175)
  (if (is-eq b 0xB0) (some u176)
  (if (is-eq b 0xB1) (some u177)
  (if (is-eq b 0xB2) (some u178)
  (if (is-eq b 0xB3) (some u179)
  (if (is-eq b 0xB4) (some u180)
  (if (is-eq b 0xB5) (some u181)
  (if (is-eq b 0xB6) (some u182)
  (if (is-eq b 0xB7) (some u183)
  (if (is-eq b 0xB8) (some u184)
  (if (is-eq b 0xB9) (some u185)
  (if (is-eq b 0xBA) (some u186)
  (if (is-eq b 0xBB) (some u187)
  (if (is-eq b 0xBC) (some u188)
  (if (is-eq b 0xBD) (some u189)
  (if (is-eq b 0xBE) (some u190)
  (if (is-eq b 0xBF) (some u191) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-192-and-223? (b (buff 1)))
  (if (is-eq b 0xC0) (some u192)
  (if (is-eq b 0xC1) (some u193)
  (if (is-eq b 0xC2) (some u194)
  (if (is-eq b 0xC3) (some u195)
  (if (is-eq b 0xC4) (some u196)
  (if (is-eq b 0xC5) (some u197)
  (if (is-eq b 0xC6) (some u198)
  (if (is-eq b 0xC7) (some u199)
  (if (is-eq b 0xC8) (some u200)
  (if (is-eq b 0xC9) (some u201)
  (if (is-eq b 0xCA) (some u202)
  (if (is-eq b 0xCB) (some u203)
  (if (is-eq b 0xCC) (some u204)
  (if (is-eq b 0xCD) (some u205)
  (if (is-eq b 0xCE) (some u206)
  (if (is-eq b 0xCF) (some u207)
  (if (is-eq b 0xD0) (some u208)
  (if (is-eq b 0xD1) (some u209)
  (if (is-eq b 0xD2) (some u210)
  (if (is-eq b 0xD3) (some u211)
  (if (is-eq b 0xD4) (some u212)
  (if (is-eq b 0xD5) (some u213)
  (if (is-eq b 0xD6) (some u214)
  (if (is-eq b 0xD7) (some u215)
  (if (is-eq b 0xD8) (some u216)
  (if (is-eq b 0xD9) (some u217)
  (if (is-eq b 0xDA) (some u218)
  (if (is-eq b 0xDB) (some u219)
  (if (is-eq b 0xDC) (some u220)
  (if (is-eq b 0xDD) (some u221)
  (if (is-eq b 0xDE) (some u222)
  (if (is-eq b 0xDF) (some u223) none)))))))))))))))))))))))))))))))))

(define-private (byte-between-224-and-255? (b (buff 1)))
  (if (is-eq b 0xE0) (some u224)
  (if (is-eq b 0xE1) (some u225)
  (if (is-eq b 0xE2) (some u226)
  (if (is-eq b 0xE3) (some u227)
  (if (is-eq b 0xE4) (some u228)
  (if (is-eq b 0xE5) (some u229)
  (if (is-eq b 0xE6) (some u230)
  (if (is-eq b 0xE7) (some u231)
  (if (is-eq b 0xE8) (some u232)
  (if (is-eq b 0xE9) (some u233)
  (if (is-eq b 0xEA) (some u234)
  (if (is-eq b 0xEB) (some u235)
  (if (is-eq b 0xEC) (some u236)
  (if (is-eq b 0xED) (some u237)
  (if (is-eq b 0xEE) (some u238)
  (if (is-eq b 0xEF) (some u239)
  (if (is-eq b 0xF0) (some u240)
  (if (is-eq b 0xF1) (some u241)
  (if (is-eq b 0xF2) (some u242)
  (if (is-eq b 0xF3) (some u243)
  (if (is-eq b 0xF4) (some u244)
  (if (is-eq b 0xF5) (some u245)
  (if (is-eq b 0xF6) (some u246)
  (if (is-eq b 0xF7) (some u247)
  (if (is-eq b 0xF8) (some u248)
  (if (is-eq b 0xF9) (some u249)
  (if (is-eq b 0xFA) (some u250)
  (if (is-eq b 0xFB) (some u251)
  (if (is-eq b 0xFC) (some u252)
  (if (is-eq b 0xFD) (some u253)
  (if (is-eq b 0xFE) (some u254)
  (if (is-eq b 0xFF) (some u255) none)))))))))))))))))))))))))))))))))

(define-private (byte-to-uint (b (buff 1)))
  (ok (match (byte-between-00-and-31? b) 
    res res 
    (match (byte-between-32-and-63? b) 
      res res 
      (match (byte-between-64-and-95? b) 
        res res 
        (match (byte-between-96-and-127? b) 
          res res
          (match (byte-between-128-and-159? b) 
            res res 
            (match (byte-between-160-and-191? b) 
              res res 
              (match (byte-between-192-and-223? b) 
                res res
                (unwrap! (byte-between-224-and-255? b) (err "uint not found")))))))))))

(define-private (byte-to-uint-wrap (byte (buff 1)) (acc { val: uint, exp: uint }))
    (let (
        (val (unwrap-panic (byte-to-uint byte)))
        (exp (- (get exp acc) u2))
        (val-pow (if (is-eq val u0) u0 (* val (pow u16 exp)))))
        { 
          exp: exp, 
          val: (+ (get val acc) val-pow)
        }))

(define-private (bytes-to-uint (bytes (buff 32)))
    (ok (fold byte-to-uint-wrap bytes { val: u0, exp: (* u2 (len bytes)) })))