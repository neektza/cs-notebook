// https://www.hackerrank.com/challenges/sherlock-and-anagrams

use std::io;

fn word_fingerprint(word: &str) -> String {
    let mut chars: Vec<char> = word.chars().collect();
    chars.sort();
    return String::from(chars.into_iter().collect::<String>());
}

fn are_anagrams(word1: &str, word2: &str) -> bool {
    return word_fingerprint(word1) == word_fingerprint(word2);
}

fn main() {
    let mut num_lines_str = String::new();
    io::stdin().read_line(&mut num_lines_str).ok().expect("read error");
    let num_lines : i32 = num_lines_str.trim().parse().ok().expect("parse error: not a num");

    for _ in 0..num_lines {
        let mut line = String::new();
        io::stdin().read_line(&mut line).ok().expect("read error");

        let mut anagrams_count = 0;
        let line_len = line.len();

        for i in 1..line_len { // test slice length
            for j in 0..(line_len-(i-1)) { // left slice
                let left_slice = &line[j..j+i];
                for k in (j+1)..(line_len-(i-1)) { // right slice
                    let right_slice = &line[k..k+i];
                    let words_are_anagrams = are_anagrams(left_slice, right_slice);
                    if words_are_anagrams { anagrams_count += 1; }
                }

            }
        }
        println!("{}", anagrams_count);
    }
}
