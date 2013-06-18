;;;;
;;;; clrt.asd
;;;;

(require 'asdf)

(defsystem #:clrt
			   :description "CLRT: A Simple Common Lisp Raytracer"
			   :depends-on(#:zpng)
			   :components
			   ((:file "linalg")
				(:file "camera" :depends-on ("linalg"))
				(:file "objects" :depends-on ("linalg" "camera"))
				(:file "scene" :depends-on ("linalg" "camera" "objects"))




