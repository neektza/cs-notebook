// https://www.hackerrank.com/challenges/sherlock-and-anagrams

use std::io::{self, BufReader};
use std::io::prelude::*;
use std::fs::File;

fn word_fingerprint(word: &str) -> String {
    let mut chars: Vec<char> = word.chars().collect();
    chars.sort();
    return String::from(chars.into_iter().collect::<String>());
}

fn are_anagrams(word1: &str, word2: &str) -> bool {
    return word_fingerprint(word1) == word_fingerprint(word2);
}

fn main() {
    let f = File::open("in.txt").expect("file not found");
    let reader = BufReader::new(f);

    for line_w in reader.lines() {
        let mut anagrams_count = 0;
        let line = line_w.unwrap();
        let line_len = line.len();
        println!("line={}", line);

        for i in 1..line_len { // test slice length
            for j in 0..(line_len-(i-1)) { // left slice
                let left_slice = &line[j..j+i];

                for k in (j+1)..(line_len-(i-1)) { // right slice
                    let right_slice = &line[k..k+i];

                    let words_are_anagrams = are_anagrams(left_slice, right_slice);
                    if words_are_anagrams {
                        println!("left={} right={} anagrams? {}", left_slice, right_slice, words_are_anagrams);
                        anagrams_count += 1;
                    }
                }

            }
        }
        println!("anagrams_count={}", anagrams_count);
        println!("_________________");
    }
}
