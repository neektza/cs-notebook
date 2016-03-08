// https://www.hackerrank.com/challenges/sherlock-and-anagrams

use std::io::prelude::*;

fn is_palindrome(mut l: usize, mut r: usize, chars: &Vec<char>) -> bool {
    let mut flag = true;
    while l < r {
        if chars[l] != chars[r] {
            flag = false;
            break;
        }
        l += 1; r -= 1;
    }
    return flag;
}

fn main() {
    let stdin = std::io::stdin();
    let lock = stdin.lock();
    let mut linecnt : u32 = 0;
    let mut linesnum : u32 = 0;

    for linew in lock.lines() {
        let line = linew.unwrap();

        match line.parse::<u32>() {
            Ok(num) => {
                linesnum = num;
                continue;
            },
            Err(_) => {
                let chars : Vec<char> = line.chars().collect();
                let len = line.len();

                let mut l : usize = 0;
                let mut r : usize = len-1;
                let mut palidx = -1i32;

                while l < r {
                    if chars[l] == chars[r] {
                        l += 1; r -= 1;
                        continue;
                    } else { 
                        if chars[l] == chars[r-1] {
                            if is_palindrome(l, (r-1), &chars) {
                                palidx = r as i32;
                                break;
                            }
                        }

                        if chars[l+1] == chars[r] {
                            if is_palindrome((l+1), r, &chars) {
                                palidx = l as i32;
                                break;
                            }
                        }
                        break;
                    }
                }

                println!("{}", palidx);
                linecnt += 1;
                if linecnt == linesnum { break }
            }
        }
    }
}
