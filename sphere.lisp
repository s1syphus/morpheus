;;;;
;;;; sphere.lisp
;;;;


(in-package #:clrt-objects)

(export 'sphere)

(defclass sphere (object)
  ((radius
	 :initarg :radius
	 :initform (error ":radius must be specified.")
	 :type single-float
	 :reader reader-radius)))

(defmethod intersects ((sphere sphere) (ray ray) &key (lower-bound 0.0) shadow-feeler)
  (let* ((ro (ray-origin ray))
		 (rd (ray-direction ray))
		 (c (object-center sphere))
		 (r (sphere-radius sphere))
		 (ro*rd (dot ro rd))
		 (rd*rd (dot rd rd))
		 (c*rd (dot c rd))
		 (discr (- (* 4 (expt (- ro*rd c*rd) 2))
				   (* 4 rd*rd (- (dot ro ro) (* 2 (dot ro c)) (- (dot  c c)) (* r r))))))
	(print discr)))




