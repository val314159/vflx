test:
	sbcl   --script test.lisp
	ecl    --eval '(setf *load-verbose* nil)' --eval '(load "test")'
	ccl64  --eval '(setf *load-verbose* nil)' --eval '(load "test")'
