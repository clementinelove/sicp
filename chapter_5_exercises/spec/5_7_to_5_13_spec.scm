(load "5_7_to_5_13.scm")

(describe "Register machine simulator"
  (it "can simulate a recursive exponentiation machine"
    (lambda ()
      (load "book_code/ch5-regsim.scm")

      (define expt-machine
	(make-machine
	 '(b n continue val)
	 (list
	  (list '= =)
	  (list '- -)
	  (list '* *))
	 '((assign continue (label expt-done))
	   expt-loop
	   (test (op =) (reg n) (const 0))
	   (branch (label base-case))
	   (save continue)
	   (save n)
	   (assign n (op -) (reg n) (const 1))
	   (assign continue (label after-expt))
	   (goto (label expt-loop))
	   after-expt
	   (restore n)
	   (restore continue)
	   (assign val (op *) (reg b) (reg val))
	   (goto (reg continue))
	   base-case
	   (assign val (const 1))
	   (goto (reg continue))
	   expt-done)
	 ))

      (set-register-contents! expt-machine 'b 9)
      (set-register-contents! expt-machine 'n 4)
      (start expt-machine)

      (assert
       (=
	(get-register-contents expt-machine 'val)
	6561))
      ))

  (it "can simulate an iterative exponentiation machine"
    (lambda ()
      (load "book_code/ch5-regsim.scm")

      (define expt-machine
	(make-machine
	 '(b n product)
	 (list
	  (list '= =)
	  (list '- -)
	  (list '* *))
	 '((assign product (const 1))
	  test-counter
	  (test (op =) (reg n) (const 0))
	  (branch (label expt-done))
	  (assign n (op -) (reg n) (const 1))
	  (assign product (op *) (reg b) (reg product))
	  (goto (label test-counter))
	  expt-done)))

      (set-register-contents! expt-machine 'b 9)
      (set-register-contents! expt-machine 'n 4)
      (start expt-machine)

      (assert
       (=
	(get-register-contents expt-machine 'product)
	6561))
      ))
  )