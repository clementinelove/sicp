(load "4_1_to_4_10.scm")

(describe "List of values"
  (it "evaluates from left to right"
    (lambda ()
      (define env '())

      (assert
       (equal?
	(list-of-values-left-to-right '(1 2 () 3 4) user-initial-environment)
	'(1 2 () 3 4)))
      ))

  (it "evaluates from right to left"
    (lambda ()
      (assert
       (equal?
	(list-of-values-right-to-left '(1 2 () 3 4) user-initial-environment)
	'(((((() . 4) . 3)) . 2) . 1)))
       ))
  )

(describe "eval"
  (it "evaluates numbers and strings"
    (lambda ()
      (define env '())

      (assert
       (= 3
	  (eval 3 env)))
      ))

  (it "evaluates if statements"
    (lambda ()
      (define env '())

      (assert
       (= 4
	  (eval (list 'if 3 4 5) env)))
      ))
)
