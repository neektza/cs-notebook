type key = string

type btree = Empty | Tree of key * btree * btree

let rec insert el t =
    match t with
    | Empty -> Tree(el, Empty, Empty)
    | Tree (k, l, r) ->
            if el < k
            then Tree (k, (insert el l), r)
            else if el > k
                then Tree (k, l, (insert el r))
                else Tree (k, l, r)


let sometree = insert "nista" Empty
