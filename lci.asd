;;;; lci.asd
;;
;;;; Copyright (c) 2019 Lennu Vuolanne <vuolanne.lennu@gmail.com>


(asdf:defsystem #:lci
  :description "A lambda calculus interpreter"
  :author "Lennu Vuolanne <vuolanne.lennu@gmail.com>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :defsystem-depends-on (:asdf-parenscript)
  :depends-on (:parenscript)
  :components ((:parenscript-file "package")
               (:parenscript-file "lci")) 
  :in-order-to ((test-op (test-op #:lci/tests))))

(asdf:defsystem #:lci/tests
  :depends-on (:lci :fiveam)
  :components ((:file "tests"))
  :perform (test-op (o c) (symbol-call :fiveam 'run-all-tests)))


