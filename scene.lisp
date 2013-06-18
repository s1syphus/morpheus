;;;;
;;;; scene.lisp
;;;;

(defpackage #:clrt-scene
  (:use :cl :clrt-camera :clrt-objects :linalg)
  (:export :#scene
		   :#add-object)

(in-package #:clrt-scene)

(defclass scene ()
  ((camera
	 :initarg :camera
	 :initform (error ":camera must be specified.")
	 :type camera
	 :reader scene-camera)
	(objects
	  :initform '()
	  :reader scene-objects)
	(lights
	  :initform '()
	  :reader scene-lights)))
	
(defun add-object (scene object)
  (push object (slot-value scene 'objects)))


	
