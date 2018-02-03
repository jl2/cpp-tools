;;;; cpp-tools.lisp
;;
;;;; Copyright (c) 2018 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>


(in-package #:cpp-tools)

(defun run-compiler (snippet language compiler args include-dirs lib-dirs libs output-dir output-file)
  (let ((real-dir (ju:fix-directory output-dir)))
    (with-input-from-string (ins snippet)
      (uiop:with-current-directory (output-dir)
        (let ((full-command (concatenate 'list 
                                         (list compiler)
                                         (ju:get-words args)
                                         (list "-x" language)
                                         (if include-dirs
                                             (list "-I" include-dirs)
                                             nil)
                                         (if lib-dirs
                                             (list "-L"  lib-dirs)
                                             nil)
                                         (mapcar (curry #'concatenate "-l") libs)
                                         (if output-file 
                                             (list "-o" output-file)
                                             nil)
                                         (list "-"))))
          (format t "Running command:~%    ~{~a~^ ~}~%~%" full-command)
          (uiop:run-program full-command
                            :output t
                            :input ins
                            :error-output :output
                            :wait t))))))

(defun disassemble-c++ (snippet &key
                                  (compiler "g++")
                                  (compiler-options "")
                                  (default-compiler-options "-O3 --std=c++1y -Wall -pedantic")
                                  (include-dirs nil)
                                  (lib-dirs nil)
                                  (libs nil)
                                  (output-dir "/tmp/")
                                  (output-file "-"))
  "Disassemble a snippet of C++ code using the specified compiler and options."
  (run-compiler snippet "c++" compiler (format nil "~a ~a -S" default-compiler-options compiler-options) include-dirs lib-dirs libs output-dir output-file))
