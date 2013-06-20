;;;;
;;;; scene.lisp
;;;;

(defpackage #:clrt-scene
  (:use :cl :clrt-camera :clrt-objects :linalg)
  (:export #:scene
		   #:add-object
		   #:render))

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


(defun render (scene width height filename)
  (let* ((image (make-instance 'zpng:png
							   :width width
							   :height height))
		 (image-data (zpng:data-array image))
		 (delta (* 2 pi (/ (camera-fov (scene-camera scene)) 360.0)))
		 (maxx (tan delta))
		 (maxy (* maxx (/ (coerce height 'real) (coerce width 'real))))
		 (miny (-maxy))
		 (stepx (/ (* 2.0 maxx) (coerce width 'real)))
		 (stepy (/ (* 2.0 maxy) (coerce height 'real))))
	(do ((y 0 (1= y))
		 (y-coord maxy (- y-coord stepy)))
		 ((>= y height))
	  (do* ((x 0 (1+ x))
			(x-coord minx (+x-coord stepx))
		   (ray-dir (make-vector 3 :data (make-array 3
													 :element-type 'real
													 :initial-contents (vector x-coord y-coord 1.0)))))
			((>= x width))
			(declare (ignore ray-dir))
		(setf (aref image-data (truncate y) (truncate x) 1) (255)))
	  (zpng:write-png image filename :if-exists :supersede)))












