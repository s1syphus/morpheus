;;;;
;;;; objects.lisp
;;;;

(defpackage #:clrt-objects
  (:use #:cl #:linalg #:clrt-camera)
  (:export #:object
		   #:object-material
		   #:intersects
		   #:finalize))

(in-package #:clrt-objects)

(defclass object ()
  ((center
	 :initarg :center
	 :initform (error ":center must be specified.")
	 :type matrix
	 :reader object-center)
	(material
	:reader object-material)))

(defgeneric intersects (obj ray))

(defgeneric finalize (obj cam))

(defmethod finalize ((obj object) (cam camera))
  (setf (slot-value obj 'center)
		(world->view cam (slot-value obj 'center))))









