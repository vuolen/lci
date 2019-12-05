;;;; tests.lisp
;;
;;;; Copyright (c) 2019 Lennu Vuolanne <vuolanne.lennu@gmail.com>

(defpackage #:lci/tests
  (:use #:cl #:fiveam))

(in-package #:lci/tests)

(def-suite lexer)
(in-suite lexer)

(test lci:tokenize
  (is equal (lci:tokenize "x"))
  (is (equal (lci:tokenize "y")
	     '(variable (y)))))
