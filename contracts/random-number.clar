(define-public (rand (seed uint) (max uint))
  (ok (mod (+ u94827 (* u983354 seed)) max)))

(rand u936986 u9835478)