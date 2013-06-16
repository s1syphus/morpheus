;;;;
;;;; clrt.asd
;;;;

(require 'asdf)

(asdf:defsystem #:clrt
			   :description "CLRT: A Simple Common Lisp Raytracer"
			   :depends-on(#:zpng)
			   :components
			   ((:file "linalg")))




