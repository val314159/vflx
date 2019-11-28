(in-package :v)

(defun readx (s &optional c)
  (let ((x (readr s))
	(y (peekc s)))
    (if (not y) x
	(if (eq y c) x
	    (let ((m (get-mchar y)))
	      (if (not m) x
		  (let ((z (mv-list (c m s (readc s)))))
		    (if (not z) x
			(cons x z)))))))))

(defun rdl (c s)
  (read-ws s)
  (if (eq (peekc s) c) (eatc s)
      (cons (readx s c) (rdl c s))))

