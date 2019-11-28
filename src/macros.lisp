(in-package :v)

(defmacro if2 (a b)   `(cl:if ,a ,b))
(defmacro if3 (a b c) `(cl:if ,a ,b ,c))

(defmacro :0 (e) `(cl:elt ,e 0))
(defmacro :1 (e) `(cl:elt ,e 1))
(defmacro :2 (e) `(cl:elt ,e 2))
(defmacro :3 (e) `(cl:elt ,e 3))
(defmacro :4 (e) `(cl:elt ,e 4))
(defmacro :5 (e) `(cl:elt ,e 5))
(defmacro :6 (e) `(cl:elt ,e 6))
(defmacro :7 (e) `(cl:elt ,e 7))
(defmacro :8 (e) `(cl:elt ,e 8))
(defmacro :9 (e) `(cl:elt ,e 9))

(defmacro n (  &rest r) `(cl:progn      ,@r))
(defmacro a (f &rest r) `(cl:apply   ,f ,@r))
(defmacro c (f &rest r) `(cl:funcall ,f ,@r))

(defmacro cs (&rest r) `(concatenate 'string ,@r))
(defmacro cl (&rest r) `(concatenate 'list   ,@r))
(defmacro cv (&rest r) `(concatenate 'vector ,@r))

(defmacro set-macro-char (c x)
  `(set-macro-character
    ,c (lambda (s c) (declare (ignorable s c)) ,x)))
(defmacro get-macro-char (c)
  `(let* ((c ,c)) (if c (get-macro-character c))))

(defmacro mv-list (&rest r) `(multiple-value-list ,@r))
(defmacro mv-bind (&rest r) `(multiple-value-bind ,@r))
(defmacro mv-setq (&rest r) `(multiple-value-setq ,@r))
(defmacro mv-call (&rest r) `(multiple-value-call ,@r))
(defmacro mv-prg1 (&rest r) `(multiple-value-prog1 ,@r))

;;;

(set-dispatch-macro-character #\# #\λ
			      (lambda (s c d)
				(declare (ignore c d))
				`(lambda (&optional _1 _2 _3 _4 _5 _6 _7 _8 _9)
				   (declare (ignorable _1 _2 _3 _4 _5 _6 _7 _8 _9))
				   ,(read-preserving-whitespace s))))

(c #λ(print (list 10 20 _1 _2)) 112 334 )

