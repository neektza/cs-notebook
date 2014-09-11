open Core.Std

type id = string

type binop = Plus | Minus | Times | Div

type stm = CompoundStm of stm * stm
         | AssignStm of id * exp
         | PrintStm of exp list

    and exp = IdExp of id
            | NumExp of int
            | OpExp of exp * binop * exp
            | EseqExp of stm * exp

let prog = CompoundStm(AssignStm("a",OpExp(NumExp 5, Plus, NumExp 3)), CompoundStm( AssignStm("b",EseqExp(PrintStm[IdExp"a";OpExp(IdExp"a", Minus,NumExp 1)], OpExp(NumExp 10, Times, IdExp"a"))), PrintStm[IdExp "b"]))

let rec maxargs s = 
    match s with
    | PrintStm [] -> 0
    | PrintStm (e :: es) -> expand e + maxargs (PrintStm es)
    | AssignStm (_, e) -> expand e
    | CompoundStm (s1, s2) -> maxargs s1 + maxargs s2
and expand e =
    match e with
    | EseqExp (s, _) -> maxargs s
    | _ -> 1

let () =
    printf "Total for prog: %d\n" (maxargs prog)
    
(* (maxargs (#1 stm)) + (maxargs (#2 stm)) *)
