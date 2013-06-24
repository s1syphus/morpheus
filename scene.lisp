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
		 (stepy (/ (* 2.0 maxy) (coerce height 'real)))
		 (zero-vector (make-vector 3 :data (make-array 3
													   :element-type 'single-float
													   :initial-element 0.0))))
	(do ((y 0 (1= y))
		 (y-coord maxy (- y-coord stepy)))
		 ((>= y height))
	  (do* ((x 0 (1+ x))
			(x-coord minx (+x-coord stepx))
		   (image-plane-pos (make-vector 3 :data (make-array 3
															 :element-type 'single-float
															 :initial-contents (vector x-coord y-coord 1.0)))
							(make-vector 3 :data (make-array 3
															 :element-type 'single-float
															 :initial-contents (vector x-coord y-coord 1.0)))))
			((>= x width))
			(let ((color (trace-ray (make-instance 'clrt-ray:ray
												   :origin image-plane-pos
												   :direction (normalized
																(m- image-plane-pos zero-vector))))))
			  (setf (aref image-data y x 0) (first color)
					(aref image-data y x 1) (second color)
					(aref image-data y x 2) (third color)))))
	  (zpng:write-png image filename :if-exists :supersede)))


(defun find-closest-intersection (scene ray lower-bound shadow-feeler)
  (let ((closest-match ))
	(dolist (obj (scene-objects scene) closest-match)
	  (let ((intersection-point (intersects obj ray 
											:lower-bound
											:shadow-feeler shadow-feeler)))
	  	(if closest-match
		  (setf closest-match
				(if (<= (car intersection-point) (car closest-match))
				  intersection-point
				  closest-match))
		  (setf closest-match intersection-point))))))

(defun trace-ray (scene ray &optional (lower-bound 0.0) shadow-feeler)
  (let ((closest-match (find-closest-intersection scene ray lower-bound shadow-feeler)))
	((if closest-match
	   (vector 255 255 255)
	   (vector 0 0 0))))











