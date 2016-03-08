// https://www.hackerrank.com/challenges/two-strings

use std::io::prelude::*;
use std::io::{self, BufReader};
use std::fs::File;
use std::env;


// fn get_my_lines(arg: env::Args) -> std::io::Lines {
//     if let Some(arg) = env::args().skip(1).next() {
//         println!("{}", arg);
//         let file = try!(File::open(arg));
//         let bufread = BufReader::new(file);
//         return bufread.lines();
//     } else {
//         let stdin = io::stdin();
//         return input.lock().lines();
//     }
// }

fn main() {
    if let Some(arg) = env::args().skip(1).next() {
        let file = File::open(arg).expect("File not found");
        let bufread = BufReader::new(file);
        let lines = bufread.lines();
    } else {
        let stdin = io::stdin();
        lines = stdin.lock().lines()
    }

    // for linew in lines() {
    //     let line = linew.unwrap();
    //     match line.parse::<u32>() {
    //         Ok(_) => { continue },
    //         Err(_) => {
    //             println!("{}", line);
    //             continue;
    //         }
    //     }
    // }
}
