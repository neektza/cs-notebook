(ns gameoflife.core
  (:require [clojure.math.combinatorics :as combo]))

(def beacon-board [[0 0 0 0 0 0]
                   [0 1 1 0 0 0]
                   [0 1 0 0 0 0]
                   [0 0 0 0 1 0]
                   [0 0 0 1 1 0]
                   [0 0 0 0 0 0]])

(defn size [board]
  (count board))

(defn valid-coordinate? [board coord]
    (and (>= coord 0) (<= coord (dec (size board)))))

(defn cell-at [board [x y]]
  (nth (nth board x) y))

(defn live-cell? [board [x y]]
  (cell-at board [x y]))

(defn neighbour-coords [board [x y]]
    (cond
      (and (= x (dec (size board))) (= y (dec (size board)))) (list [x (dec y)] [y (dec x)] [(dec x) (dec y)])
      (and (= x (dec (size board))) (= y 0)) (list [x (inc y)] [(dec x) (inc y)] [(dec x) y])
      (and (= x 0) (= y (dec (size board)))) (list [x (dec y)] [(inc x) (dec y)] [(inc x) y])
      (and (= x 0) (= y 0)) (list [x (inc y)] [(inc x) y] [(inc x) (inc y)])
      (= x (dec (size board))) (list [(dec x) (dec y)] [(dec x) y] [(dec x) (inc y)] [x (inc y)] [x (dec y)])
      (= y (dec (size board))) (list [(dec x) (dec y)] [(dec x) y] [(inc x) (dec y)] [(inc x) y] [x (dec y)])
      (= x 0) (list [(inc x) (dec y)] [(inc x) y] [(inc x) (inc y)] [x (inc y)] [x (dec y)])
      (= y 0) (list [(dec x) y] [(dec x) (inc y)]  [(inc x) y] [(inc x) (inc y)] [x (inc y)])
      :else (list [(dec x) (dec y)] [(dec x) y] [(dec x) (inc y)] [(inc x) (dec y)] [(inc x) y] [(inc x) (inc y)] [x (inc y)] [x (dec y)])))

(defn alive-neighbors-count [board [x y]]
  (let [edges [x y (inc x) (inc y) (dec x) (dec y)]]
    (reduce + (map (partial cell-at board) (neighbour-coords board [x y])))))

(defn next-cell-status [board [x y]]
  (let [lc (alive-neighbors-count board [x y])]
        (if (live-cell? board [x y])
          ; alive
          (cond
            (< lc 2) 0
            (or (= lc 2) (= lc 3)) 1
            (> lc 3) 0)
          ; dead
          (if (= 3 lc) 1 0))))

(defn next-gen-row [board row]
  (loop [y 0 ng-row []]
    (if (= (count ng-row) (size board))
      ng-row
      (recur (inc y) (conj ng-row (next-cell-status board [row y]))))))

(defn next-gen-board [board]
  (loop [x 0 ng-board []]
    (if (= (count ng-board) (size board))
      ng-board
      (recur (inc x) (conj ng-board (next-gen-row board x))))))
