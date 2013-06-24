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
				(:file "objects" :depends-on ("linalg" "camera" "ray"))
				(:file "scene" :depends-on ("linalg" "camera" "objects"))
				(:file "sphere" :depends-on ("linalg" "objects"))
				(:file "ray" :depends-on ("linalg))))

;;;;1:05 in video 2.1.1

