(in-package :v)

(defun readx (s &optional c)
  (let* ((x (readr s))
	 (y (peekc s)))
    (if (eq y c) (eat-c s)
	(let* ((m (get-mchar y)))
	  (if (not m) x
	      (let* ((z (mv-list (c m s (readc s)))))
		(if z (cons x z) x)))))))

(defun read-d-list (c s)
  (read-ws s)
  (if (eq (peekc s) c) (eat-c s)
      (cons (readx s c) (read-d-list c s))))
