;;;;
;;;; ray.lisp
;;;;

(defpackage #:clrt-ray
  (:use #:cl #:linalg)
  (:export #:ray
		   #:point-on-ray
		   #:ray-origin
		   #:ray-direction))

(in-package #:clrt-ray)

(defclass ray ()
  ((origin
	 :initarg :origin
	 :initform (error ":origin must be specified")
	 :type matrix
	 :reader ray-origin)
   (direction
	 :initarg :direction:
	 :initform (error ":direction must be specified")
	 :type matrix
	 :reader ray-direction)))

(defmethod initialize-instance :after ((ray ray) &key)
  (assert (<= (- 1 single-float-epsilon)
			  (dot (ray-direction ray) (ray-direction ray))
			  (+ 1 single-float-epsilon))
		  nil
		  ":direction must be a unit-length vector."))

(defun point-on-ray (ray dist)
  (m+ (ray-origin ray) (m* dist (ray-direction ray))))







