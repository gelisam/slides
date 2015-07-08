use std::thread;

fn main() {
    let mut v = Vec::with_capacity(5); 
    for i in 0..4 {
        v.push(thread::spawn(move || {
            println!("philosopher {} is thinking...", i);
            thread::sleep_ms(1000);
            println!("philosopher {} is hungry", i);
            i
        }));
    }
    for child in v {
        match child.join() {
            Ok(i)  => println!("philosopher {} left the table.", i),
            Err(_) => println!("one of the philosophers lies face-first in their food, dead.")
        }
    }
}
