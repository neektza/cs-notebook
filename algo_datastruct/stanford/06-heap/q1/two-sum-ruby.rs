use std::env;
use std::fs::File;
use std::path::Path;
use std::io::BufReader;
use std::io::prelude::*;
use std::collections::HashMap;
use std::error::Error;

extern crate rand;
use rand::{thread_rng, Rng};

#[derive(Debug)]
struct Bucket {
    key: usize,
    storage: Vec<i64>
}

impl Bucket {
    fn push(&mut self, v: i64) {
        self.storage.push(v);
    }
}

fn main() {
    let mut rng = thread_rng();

    let path_str = env::args().nth(1).unwrap();
    let path = Path::new(&path_str);
    let display = path.display();

    let file = match File::open(&path) {
        Err(why) => panic!("couldn't open {}: {}", display, Error::description(&why)),
        Ok(file) => file,
    };

    let reader = BufReader::new(file);
    
    let mut nums: Vec<i64> = reader.lines().map(|l| {
        l.ok().and_then(|s| s.parse().ok()).unwrap_or(0)
    }).collect();
        
    println!("input consumed!");

    let mut table: Vec<Bucket> = Vec::new();

    for i in 0..10000 {
        let b = Bucket { key: i, storage: vec![] };
        table.insert(i, b);
    }

    for x in nums.iter() { 
        let key: usize = rng.gen_range(0, 10000);
        if let Some(b) = table.get(key) {
            println!("{:?}", b);
            b.push(x.clone());
        }
    }
}

    // for t in -10000..10001 {
    //     println!("--------> t:{: <20}\r", t);
    //     let mut sums: HashMap<i64, i64> = HashMap::with_capacity(1000000);
    //     let mut i = 0;

    //     for x in nums.iter() { 
    //         print!("x:{: <7}\r", i);
    //         if sums.contains_key(x) {
    //             println!("{} = {} + {}", t, t-x, x);
    //             cnt += 1;
    //             break;
    //         } else {
    //             sums.insert(t-x, 1);
    //         }
    //         i += 1;
    //     }
    // }

    // println!("\nnumber of t-sums {}", cnt);

//     for k in buckets.keys() {
//         if let Some(cnt) = buckets.get(k) {
//             println!("bucket {} cnt {}", k, cnt);
//         }
//     }

//     println!("num of buckets {}", nums.len());
//     println!("num of buckets {}", buckets.keys().count());
// }



// 10000 - 4 nule
// 2371419621 / 20001 = 118565
// 118565 -> kako? -> 0..50

// hash funkcija f koja ulazne brojeve sprema u lonce prema intervalima
// neka dva integera x1 i x2, idu u isti lonac ako |x1 - x2| < 20001
// neka dva integer x1 i x2, idu u razlicite lonce ako |x1 - x2| > 20001

// svi brojevi koji zajedno mogu dati neki od T-ova iz [-10K .. 10K] idu u isti lonac

// kad je to poslozeno:
// za svaki x, kako nadjemo lonce u kojima
// bi trebali biti svi brojevi y za koje x+y=t
