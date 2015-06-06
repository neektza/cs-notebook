use std::env;
use std::fs::File;
use std::path::Path;
use std::io::BufReader;
use std::io::prelude::*;
use std::collections::HashMap;
use std::error::Error;

fn main() {
    // Create a path to the desired file

    let path_str = env::args().nth(1).unwrap();

    let path = Path::new(&path_str);
    let display = path.display();

    // Open the path in read-only mode, returns `io::Result<File>`
    let file = match File::open(&path) {
        // The `description` method of `io::Error` returns a string that describes the error
        Err(why) => panic!("couldn't open {}: {}", display, Error::description(&why)),
        Ok(file) => file,
    };

    let reader = BufReader::new(file);
    
    let nums: Vec<i64> = reader.lines().map(|l| {
        l.ok().and_then(|s| s.parse().ok()).unwrap_or(0)
    }).collect();
        
    println!("input consumed!");

    let mut cnt = 0;

    for t in -10000..10001 {
        print!("t:{: <10}\r", t);
        let mut sums: HashMap<i64, i64> = HashMap::new();

        for x in nums.iter() { 
            if sums.contains_key(x) {
                // println!("{} = {} + {}", t, t-x, x);
                cnt += 1;
                break;
            } else {
                sums.insert(t-x, 1);
            }
        }
    }

    println!("\nnumber of t-sums {}", cnt);
}
