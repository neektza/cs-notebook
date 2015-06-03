use std::error::Error;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;
use std::path::Path;

fn main() {
    // Create a path to the desired file
    let path = Path::new("input/algo1-programming_prob-2sum.txt");
    let display = path.display();

    // Open the path in read-only mode, returns `io::Result<File>`
    let file = match File::open(&path) {
        // The `description` method of `io::Error` returns a string that describes the error
        Err(why) => panic!("couldn't open {}: {}", display, Error::description(&why)),
        Ok(file) => file,
    };

    let reader = BufReader::new(file);
    let lines: Vec<_> = reader.lines().collect();

    // println!("{:?}", lines);
    
    let mut nums:Vec<i64> = vec![];
                
    for l in lines {
        let num = match l {
            Ok(s) => match s.parse() { 
                Ok(i) => i,
                Err(e) => panic!("{:?}", e)
            },
            Err(e) => panic!("{:?}", e)
        };
        nums.push(num);
    }

    println!("{:?}", nums);
}
