#lang racket

(define (pascal-triangle row col)
		(cond ((< row col) #f)
			  ((or (= 0 col) (= row col)) 1)
			  (else (+ (pascal-triangle (- row 1) col)
					   (pascal-triangle (- row 1) (- col 1)))))) 

(pascal-triangle 10 6)
