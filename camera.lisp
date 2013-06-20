;;;;
;;;; camera.lisp
;;;;

(defpackage #:clrt-camera
  (:use #:cl #:linalg)
  (:export #:camera
		   #:camera-pos
		   #:camera-direction
		   #:camera-fov))

(in-package #:clrt-camera)

(defclass camera ()
  ((pos
	 :initarg :pos
	 :initform (error ":pos must be specified.")
	 :type 'matrix
	 :reader camera-pos)
   (dir
	 :type 'matrix
	 :reader camera-direction)
   (up
	 :initarg :up
	 :initform (error ":up must be specified.")
	 :type 'matrix)
   (fov
	 :initarg :fov
	 :initform 110.0
	 :type (real 70.0 130.0)
	 :reader camera-fov)))

(defmethod initialize-instance :after ((cam camera) &key look-at)
  (setf (slot-value cam 'dir)
		(normalized (m- look-at (camera-pos cam)))))












