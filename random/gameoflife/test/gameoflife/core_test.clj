(ns gameoflife.core-test
  (:require [clojure.test :refer :all]
            [gameoflife.core :refer :all]))


(def sample-board [[0 0 0 0 0 0]
                   [0 1 1 0 0 0]
                   [0 1 0 0 0 0]
                   [0 0 0 0 1 0]
                   [0 0 0 1 1 0]
                   [0 0 0 0 0 0]])

(def sbs (size sample-board)) ; sample board size

(deftest size-test
         (testing "Size of the board is size of first axis"
                  (is (size sample-board) (count sample-board))))

(deftest valid-coordinate?-test
         (testing "Coordinate must be gt 0 and lt size of the board"
                  (is (valid-coordinate? sample-board 4)) ; inside
                  (is (valid-coordinate? sample-board 0)) ; low edge
                  (is (valid-coordinate? sample-board (dec (size sample-board)))))) ; high edge

(deftest neighbour-coords-test
         (testing "For a given coord, return all valid adjecent coords"
                  (let [nc (partial neighbour-coords sample-board)]
                    (is (nc [0 0]) '([1 0] [0 1] [1 1]))
                    (is (nc [5 5]) '([4 4] [4 5] [5 4]))
                    (is (nc [0 5]) '([1 4] [1 5] [0 4]))
                    (is (nc [5 0]) '([4 1] [5 0] [4 0]))
                    (is (nc [3 0]) '([2 0] [4 0] [3 1] [4 1] [2 1]))
                    (is (nc [0 3]) '([0 2] [0 4] [1 3] [1 4] [1 2]))
                    (is (nc [3 5]) '([2 5] [4 5] [3 4] [4 4] [2 4]))
                    (is (nc [5 3]) '([5 2] [5 4] [4 3] [4 4] [4 2]))
                    (is (nc [2 4]) '([1 4] [3 4] [2 3] [2 5] [1 3] [3 5] [1 5] [3 3])))))

(deftest alive-neighbors-count-test
         (testing "Number of alive neighbours"
                  (is (alive-neighbors-count sample-board [2 2]) 3)
                  (is (alive-neighbors-count sample-board [0 0]) 1)
                  (is (alive-neighbors-count sample-board [5 0]) 0)))

(deftest next-cell-status-test
         (testing "Status of the cell in next generation"
                  (is (next-cell-status sample-board [2 2]) 1)
                  (is (next-cell-status sample-board [0 0]) 0)
                  (is (next-cell-status sample-board [0 2]) 0)
                  (is (next-cell-status sample-board [1 1]) 1)))


(deftest next-gen-row-test
         (testing "Given a row coord, returns the state of the row in the next gen"
                  (is (next-gen-row sample-board 0) [0 0 0 0 0 0])
                  (is (next-gen-row sample-board 1) [0 1 1 0 0 0])
                  (is (next-gen-row sample-board 2) [0 1 1 0 0 0])))

; (deftest next-gen-board-test
;          (testing "Given a board, returns the state of the board in the next gen"
;                   (is (next-gen-board-test sample-board) [[0 0 0 0 0 0]
;                                                           [0 1 1 0 0 0]
;                                                           [0 1 1 0 0 0]
;                                                           [0 0 0 1 1 0]
;                                                           [0 0 0 1 1 0]
;                                                           [0 0 0 0 0 0]])))

