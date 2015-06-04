#lang racket

; Tree node
(struct node (elem left right) #:transparent)
(struct leaf (elem) #:transparent)

(define empty-tree?
  (lambda (tree)
	(null? tree)))
