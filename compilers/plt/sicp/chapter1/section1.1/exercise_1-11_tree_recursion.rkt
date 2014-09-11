#lang racket

; recursive process
(define (fn-rec n)
  (cond ((< n 3) n)
		((>= n 3) (+
				   (fn-rec (- n 1))
				   (* 2 (fn-rec (- n 2)))
				   (* 3 (fn-rec (- n 3)))))))

(fn-rec 10)

; iterative process
(define (fn-iter-innner a b c counter)
  (if (< counter 3)
	a
	(fn-iter-innner (+ a (* 2 b) (* 3 c)) a b (- counter 1))))

(define (fn-iter n)
  (if (< n 3)
	n
	(fn-iter-innner 2 1 0 n)))

(fn-iter 10)
