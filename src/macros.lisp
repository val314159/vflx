(in-package :v)

(defmacro if3 (a b c) (cl:if a b c))
(defmacro if2 (a b)   (cl:if a b))

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
