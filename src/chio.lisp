(in-package :v)
<<<<<<< HEAD

(defun f. (&rest r) (apply #'cl:format cl:t   r))
(defun s. (&rest r) (apply #'cl:format cl:nil r))

(defun p- (x &optional s) (cl:prin1 x s) (cl:princ " " s) x)
(defun p. (x &optional s) (cl:prin1 x s) (cl:terpri    s) x)

(defun readx (a &optional (b t) c d)
  (cl:read-preserving-whitespace a b c d))
(defun peekc (s &optional  eof-p)
  (cl:peek-char nil s eof-p))
(defun readc (s &optional (eof-p t))
  (cl:read-char     s eof-p))
(defun  eatc (s)
  (if2 (read-char s nil)))

=======
>>>>>>> dev2
(defconstant VT  #\Vt)
(defconstant TB  #\Tab)
(defconstant FF  #\Page)
(defconstant SP  #\Space)
(defconstant CR  #\Return)
(defconstant NL  #\Newline)
<<<<<<< HEAD
(defconstant WC  (list VT TB FF SP CR))
(defconstant WS  (cons NL WC))
(defconstant EOL (cons NL nil))

(defun sym-p (c) (mv-bind (a b) (get-macro-char c) (if a b t)))
(defun eol-p (c) (member c EOL))
(defun  wc-p (c) (member c WC))
(defun  ws-p (c) (member c WS))
=======
(defvar WC  (list VT TB FF SP CR))
(defvar WS  (cons NL WC))
(defvar EOL (cons NL nil))
(defun s- (&rest r) (apply #'format nil r))
(defun f- (&rest r) (apply #'format  t  r))
(defun f. (&rest r) (apply #'format  t  r) (terpri))
(defun p- (x) (prin1 x) (princ " ") x)
(defun p. (x) (prin1 x) (terpri)    x)
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
>>>>>>> dev2
