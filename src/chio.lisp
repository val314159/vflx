(in-package :v)
(defconstant VT  #\Vt)
(defconstant TB  #\Tab)
(defconstant FF  #\Page)
(defconstant SP  #\Space)
(defconstant CR  #\Return)
(defconstant NL  #\Newline)
(defparameter WC  (list VT TB FF SP CR))
(defparameter WS  (cons NL WC))
(defparameter EOL (cons NL nil))
(defun f- (&rest r) (apply #'cl:format cl:t   r))
(defun f. (&rest r) (apply #'cl:format cl:t   r) (terpri))
(defun s- (&rest r) (apply #'cl:format cl:nil r))
(defun p- (x &optional s) (cl:prin1 x s) (cl:princ " " s) x)
(defun p. (x &optional s) (cl:prin1 x s) (cl:terpri    s) x)
(defun  ws-p (c) (member c WS))
(defun  wc-p (c) (member c WC))
(defun eol-p (c) (member c EOL))
(defun sym-p (c) (mv-bind (a b) (get-mchar c) (if a b t)))
(defun readr (s) (read-preserving-whitespace s))
(defun readc (s) (read-char s))
(defun peekc (s) (peek-char nil s nil))
(defun eat-c (s) (if (peekc s) (if (readc s) nil)))
(defun read-wc  (s) (if ( wc-p (peekc s)) (cons (readc s) (read-wc  s))))
(defun read-ws  (s) (if ( ws-p (peekc s)) (cons (readc s) (read-ws  s))))
(defun read-sym (s) (if (sym-p (peekc s)) (cons (readc s) (read-sym s))))
