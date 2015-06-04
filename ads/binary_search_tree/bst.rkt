#lang racket
(require racket/string)
(require racket/pretty)

(define in (open-input-file "input"))
(define input-values (map string->number (string-split (read-line in) " ")))

; Tree node
(struct node (elem left right) #:transparent)
(struct leaf (elem) #:transparent)
  
; Recursive
(define (bst-insert-recursive tree new-elem)
  (cond
	[(empty? tree) (leaf new-elem)]
	[(leaf? tree)
	 (let ([l-elem (leaf-elem tree)])
	   (cond
		 [(= l-elem new-elem) l-elem]
		 [(< l-elem new-elem) (node l-elem (leaf l-elem) (leaf new-elem))]
		 [else (node new-elem (leaf new-elem) (leaf l-elem))]))]
	[else 
	  (let ([n-elem (node-elem tree)]
			[left-subtree (node-left tree)]
			[right-subtree (node-right tree)])
		(if (<= new-elem n-elem)
		  (node n-elem (bst-insert-recursive left-subtree new-elem) right-subtree)
		  (node n-elem left-subtree (bst-insert-recursive right-subtree new-elem))))]))



; Iterative
(define (bst-insert-iterative tree new-elem)
  (define (iter-as-root-tree subtree new-elem)
	(cond
	  [(empty? subtree) (leaf new-elem)]
	  [(leaf? subtree)
	   (let ([l-elem (leaf-elem tree)])
		 (cond
		   [(= l-elem new-elem) l-elem]
		   [(< l-elem new-elem) (node l-elem (leaf l-elem) (leaf new-elem))]
		   [else (node new-elem (leaf new-elem) (leaf l-elem))]))]
	  [else
		(let ([n-elem (node-elem subtree)]
			  [left-subtree (node-left subtree)]
			  [right-subtree (node-right subtree)])
		  (if (<= new-elem n-elem)
			(iter-as-root-tree left-subtree new-elem)
			(iter-as-root-tree right-subtree new-elem)))]))

  (iter-as-root-tree tree new-elem)
  (tree))

; Insert list elements to tree
(define insert-list-to-tree
  (lambda (tree-insert-fn lst tree)
	(cond
	  [(empty? lst) tree]
	  [else
		(insert-list-to-tree tree-insert-fn (cdr lst) (tree-insert-fn tree (car lst)))])))

;(insert-list-to-tree bst-insert-recursive input-values '())
(insert-list-to-tree bst-insert-iterative-with-assignment input-values '())
