;;;; cpp-tools.asd
;;
;;;; Copyright (c) 2018 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>


(asdf:defsystem #:cpp-tools
  :description "Utilities for working with C++ code."
  :author "Jeremiah LaRocco <jeremiah_larocco@fastmail.com>"
  :license  "ISC"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria #:j-utils #:uiop)
  :components ((:file "package")
               (:file "cpp-tools")))
