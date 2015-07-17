

use std::sync::Mutex;
use std::sync::MutexGuard;

fn main() {
    let mut x: i32 = 0;
    let lock_x = Mutex::new(());
    
    {
        let guard_x: MutexGuard<()> = lock_x.lock().unwrap();
        x += 1;
    }
    
    // x modified without being protected by a lock!
    x += 1;
    
    {
        let guard_x: MutexGuard<()> = lock_x.lock().unwrap();
        println!("x is now {}", x);
    }
}
