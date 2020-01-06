(defsystem #:asdf-parenscript)

(defclass parenscript-compile-op (downward-operation)
  ())

(defclass parenscript-file (cl-source-file)
  ())

(defmethod perform ((o parenscript-compile-op) p)
  nil)

(defmethod output-files ((o parenscript-compile-op) (c parenscript-file))
  (values (list (make-pathname :defaults (component-pathname c)
			       :directory (list :relative "js")
			       :type "js"))
	  t))

(defmethod input-files ((o parenscript-compile-op) (c parenscript-file))
  (list (component-pathname c)))

(defmethod perform ((o parenscript-compile-op) (c parenscript-file))
  (with-open-file (out (output-file o c)
		       :direction :output
		       :if-exists :supersede
		       :if-does-not-exist :create)
    (write-string (symbol-call 'parenscript
			       'ps-compile-file
			       (first (input-files o c)))
		  out)))


(defclass parenscript-bundle-op (downward-operation)
  ((downward-operation :initform 'parenscript-compile-op)))

(defmethod input-files ((o parenscript-bundle-op) (c system))
  (remove-if #'null
	     (map 'list
		  (lambda (child)
		    (first (output-files 'parenscript-compile-op
					 child)))
		  (component-children c))))

(defmethod output-files ((o parenscript-bundle-op) (c system))
  (values (list "js/bundle.js")
	  t))

(defmethod perform ((o parenscript-bundle-op) (c system)) 
  (concatenate-files (input-files o c)
		     (output-file o c)))




;; (defmethod output-files ((o parenscript-compile-op) (c parenscript-file)) 
;;   (values (list (make-pathname :name (pathname-name (car (input-files o c)))
;; 			       :directory (list :relative (slot-value o 'output-dir))
;; 			       :type "js"))
;; 	  t)
;;   )

;; (defmethod perform ((o parenscript-compile-op) (c system))  
;;   (format t "parenscript-compile-op ~s to ~s ~%"
;; 	  (input-files o c)
;; 	  (output-file o c))
;;   )

;; (defun parenscript-compile-system (system output-dir)
;;   (let ((op (make-operation 'parenscript-compile-op)))
;;     (setf (slot-value op 'output-dir)
;; 	  output-dir)
;;     (operate op system)))

;; (export '(parenscript-compile-op
;; 	  parenscript-compile-system))
