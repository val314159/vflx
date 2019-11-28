(in-package :v)

(defvar xx (list nil #\,))

(defun readx (s &optional c)
  (let* ((x (readr s))
	 (y (peekc s)))
    (if (eq x '|,|) x
	(if (member y (cons c xx)) x
	    (let* ((m (get-mchar y)))
	      (if m (let* ((z (mv-list (c m s (readc s)))))
		      (if z (return-from readx
			      (if (eq (caar z) '|,|)
				  (cons x (cdar z))
				  (cons x z)))))))))
    x))

(defun rdl (c s)
  (read-ws s)
  (if (eq   (peekc s)  c) (eat-c s)
      (cons (readx s   c) (rdl c s))))

(defvar *indent* 0)

(defun read-nl (s &optional c)
  (declare (ignore c))
  (setf *indent* (length (read-wc s)))
  (if (eq (peekc s) NL) (n (readc   s)
			   (read-nl s))
      (n (f. "new indent is ~a" *indent*)
	 (values))))

(defun xrnl (s)
  (read-wc s)
  (if (member (peekc s) (list #\¶ NL nil))  nil
      (cons (readx s  NL) (xrnl s))))

(defun rnl (s)
  (p- "RNL")
  (p. (xrnl s)))

(defun infix (x)
  (ecase (length x)
    (0  (list 'values))
    ;;(1  (list 'values (:0 x)))
    (1  (:0 x))
    (2  (if (eq (:1 x) '|,|)
	    (list (:1 x) (:0 x))
	    (list (:0 x) (:1 x))))
    (3  (list (:1 x) (:0 x) (:2 x)))
    (4  (if (eq (:1 x) (:3 x)) t
	    (error "X"))
     t  (list (:1 x) (:0 x) (:2 x)))
    (5  (if (eq (:1 x) (:3 x)) t
	    (error "X"))
     t  (list (:1 x) (:0 x) (:2 x) (:4 x)))
    (6  (if (eq (:1 x) (:3 x)) t
	    (if (eq (:1 x) (:5 x)) t
		(error "X")))
     t  (list (:1 x) (:0 x) (:2 x) (:4 x)))
    (7  (if (eq (:1 x) (:3 x)) t
	    (if (eq (:1 x) (:5 x)) t
		(error "X")))
     t  (list (:1 x) (:0 x) (:2 x) (:4 x) (:6 x)))
    (8  (if (eq (:1 x) (:3 x)) t
	    (if (eq (:1 x) (:5 x)) t
		(if (eq (:1 x) (:7 x)) t
		    (error "X"))))
     t  (list (:1 x) (:0 x) (:2 x) (:4 x) (:6 x)))
    (9  (if (eq (:1 x) (:3 x)) t
	    (if (eq (:1 x) (:5 x)) t
		(if (eq (:1 x) (:7 x)) t
		    (error "X"))))
     t  (list (:1 x) (:0 x) (:2 x) (:4 x) (:6 x) (:8 x)))
    (10 (if (eq (:1 x) (:3 x)) t
	    (if (eq (:1 x) (:5 x)) t
		(if (eq (:1 x) (:7 x)) t
		    (if (eq (:1 x) (:9 x)) t
			(error "X")))))
     t  (list (:1 x) (:0 x) (:2 x) (:4 x) (:6 x) (:8 x)))))

(defun read-lines (_1)
  (read-nl _1)
  (cons 'n (loop :with indent0 := (1+ *indent*)
		 :collect           (rnl     _1)
		 :do                (read-nl _1)
		 :until     (member (peekc   _1) '(#\¶ nil))
		 :until     (    |<| indent0 *indent*)
		 :do        (if (|>| indent0 *indent*)
				(error "indent error")))))
(defun read-keyword (_1)
  (intern (string-upcase (cs (read-sym _1))) :keyword))

(defun read-semi (_1)
  (if (eq (peekc _1) #\;) (n (read-line _1) (values)) '|;|))

(defun turn-it-on ()
  (set-mchar #\; (read-semi _1))
  (set-mchar #\' (list (quote quote) (readx _1)))
  (set-mchar #\$ (list (quote quote) (readx _1)))
  (set-macro-character NL 'read-nl)
  (set-mchar CR  (values))
  (set-mchar SP  (values))
  (set-mchar TB  (values))
  (set-mchar FF  (values))
  (set-mchar VT  (values))
  (set-mchar #\: (read-lines _1))
  (set-mchar #\¶ (values))
  (set-mchar #\/ (read-keyword _1))
  (set-mchar #\! (rnl   _1))
  (set-mchar #\~ (readx _1))
  (set-mchar #\, '\,)
  (set-mchar #\( (infix (rdl #\) _1)))
  (set-mchar #\) (error ")"))
  (set-mchar #\{ (rdl #\} _1))
  (set-mchar #\} (error "}"))
  (set-mchar #\< (rdl #\> _1))
  (set-mchar #\> (error ">")))

(defun turn-it-off ()
  (set-mchar #\( (read-delimited-list #\) _1))
  (set-mchar #\) (error ")"))
  (set-macro-character #\: nil)
  (set-macro-character #\^ nil)
  (set-macro-character #\; nil)
  (set-macro-character #\' nil)
  (set-macro-character #\$ nil)
  (set-macro-character #\~ nil)
  (set-macro-character #\, nil)
  (set-macro-character #\{ nil)
  (set-macro-character #\} nil)
  (set-macro-character #\< nil)
  (set-macro-character #\> nil))
