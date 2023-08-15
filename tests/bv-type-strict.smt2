(declare-sort Int 0)
(declare-consts <numeral> Int)

(declare-const = (-> (! Type :var T :implicit) T T Bool))
(declare-const + (-> Int Int Int))
(declare-const - (-> Int Int Int))
(declare-const > (-> Int Int Bool))
(declare-const >= (-> Int Int Bool))


(program run_evaluate ((T Type) (U Type) (S Type) (a T) (b U) (z S))
    (S) S
    (
      ((run_evaluate (= a b))  (eval.is_eq (run_evaluate a) (run_evaluate b)))
      ((run_evaluate (> a b))  (eval.is_neg (run_evaluate (- b a))))
      ((run_evaluate (>= a b)) (let ((x (run_evaluate (- b a)))) 
                                 (eval.or (eval.is_neg x) (eval.is_zero x))))
      ((run_evaluate (+ a b))  (eval.add (run_evaluate a) (run_evaluate b)))
      ((run_evaluate (- a b))  (eval.add (run_evaluate a) (eval.neg (run_evaluate b))))
      ((run_evaluate z)        z)
    )
)

(declare-const BitVec 
  (-> 
    (! Int :var w :restrict ((run_evaluate (> w 0)) true))
    Type))

(declare-const bvadd (->
  (! Int :var n :implicit)
  (BitVec n)
  (BitVec n)
  (BitVec n)))

(declare-const a (BitVec 4))

(declare-const i Int)
(declare-const j Int)
;(declare-const b (BitVec (+ i j)))
