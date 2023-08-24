(include "../programs/Nary.smt2")
(include "../programs/Booleans.smt2")

; Nary tests on a custom type
(declare-type S ())

(declare-const cons (-> S S S)
    :right-assoc-nil
)

(declare-const c1 S)
(declare-const c2 S)
(declare-const c3 S)
(declare-const c4 S)

; inList
(declare-rule check_inList((c S) (l S) (out S))
    :args (c l out)
    :requires (((inList cons c l) out))
    :conclusion true
)

(step in1 :rule check_inList :args (c3 (cons c3 c1 c2) true))
(step in2 :rule check_inList :args (c3 (cons c1 c3 c2) true))
(step in3 :rule check_inList :args (c3 (cons c1 c2 c3) true))
(step in4 :rule check_inList :args (c4 (cons c1 c2 c3) false))

; Append
(declare-rule check_append((c S) (l S) (out S))
    :args (c l out)
    :requires (((append cons c l) out))
    :conclusion true
)

(step ap1 :rule check_append :args (c3 (cons c1 c2) (cons c3 c1 c2)))
(step ap2 :rule check_append :args ((alf.nil S) (cons c1 c2) (cons (alf.nil S) c1 c2)))
(step ap3 :rule check_append :args (c1 (alf.nil S) (remove cons c2 (cons c1 c2))))

; Concat
(declare-rule check_concat((t1 S) (t2 S) (out S))
    :args (t1 t2 out)
    :requires (((concat cons t1 t2) out))
    :conclusion true
)

(step co1 :rule check_concat :args ((alf.nil S) (cons c1 c3) (cons c1 c3)))
(step co2 :rule check_concat :args ((cons c1 c3) (alf.nil S) (cons c1 c3)))
(step co3 :rule check_concat :args ((cons c1 c2) (cons c1 c3) (cons c1 c2 c1 c3)))

; Remove
(declare-rule check_remove((c S) (l S) (out S))
    :args (c l out)
    :requires (((remove cons c l) out))
    :conclusion true
)

(step rm1 :rule check_remove :args (c1 (cons c1 c2 c3) (cons c2 c3)))
(step rm2 :rule check_remove :args (c2 (cons c1 c2 c3) (cons c1 c3)))
(step rm3 :rule check_remove :args (c3 (cons c1 c2 c3) (cons c1 c2)))
(step rm4 :rule check_remove :args ((alf.nil S) (cons c1 c2 c3) (cons c1 c2 c3)))
(step rm5 :rule check_remove :args (c1 (alf.nil S) (alf.nil S)))
(step rm6 :rule check_remove :args (c1 (cons c1 c1 c2 c3) (cons c1 c2 c3)))
(step rm7 :rule check_remove :args (c2 (cons c1 c2 c2 c3) (cons c1 c2 c3)))

; naryElim

; Constant to map the nil constant to in empty lists
(declare-const elim-nil S)
(declare-rule check_naryElim((in S) (out S))
    :args (in out)
    :requires (((naryElim cons (alf.nil S) elim-nil in) out))
    :conclusion true
)

(step elim1 :rule check_naryElim :args ((cons c1 c2) (cons c1 c2)))
(step elim2 :rule check_naryElim :args ((remove cons c2 (cons c1 c2))  c1))
(step elim3 :rule check_naryElim :args ((remove cons c2 (cons (alf.nil S) c2)) (alf.nil S)))
(step elim4 :rule check_naryElim :args ((remove cons c1 (remove cons c2 (cons c1 c2))) elim-nil))
(step elim5 :rule check_naryElim :args ((remove cons c2 (cons (cons c1 c3) c2)) (cons c1 c3)))

; naryIntro
(declare-rule check_naryIntro((in S) (out S))
    :args (in out)
    :requires (((naryIntro cons (alf.nil S) in) out))
    :conclusion true
)

(step intro1 :rule check_naryIntro :args ((cons c1 c2) (cons c1 c2)))
(step intro3 :rule check_naryIntro :args (c1 (remove cons c2 (cons c2 c1))))
(step intro4 :rule check_naryIntro :args ((cons c1 c2 c3) (cons c1 c2 c3)))
