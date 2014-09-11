#lang racket

;; linear complexity O(n)
(define (mult a b)
  (displayln "called slow")
  (if (= b 0)
	0
	(+ a (mult a (- b 1)))))

(mult 7 9)

;; logarithmic complexity O(log2n)
(define (fast-mult x n)
  (displayln "called fast")
  (define (halve x)
	(/ x 2))
  (define (double x)
	(+ x x))
  (cond
	((= n 0) 0)
	((= n 1) x)
	((even? n) (double (fast-mult x (halve n))))
	(else (+ x (fast-mult x (- n 1))))))

(fast-mult 7 9)
