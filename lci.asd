;;;; lci.asd
;;
;;;; Copyright (c) 2019 Lennu Vuolanne <vuolanne.lennu@gmail.com>


(asdf:defsystem #:lci
  :description "Describe lci here"
  :author "Lennu Vuolanne <vuolanne.lennu@gmail.com>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:fiveam)
  :components ((:file "package")
               (:file "lci")))
