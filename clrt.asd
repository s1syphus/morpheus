;;;;
;;;; clrt.asd
;;;;

(require 'asdf)

(asdf:defystem #:clrt
			   :description "CLRT: A Simple Common Lisp Raytracer"
			   :depends-on(#:zpng)
			   :components
			   ((:file "linalg")))




