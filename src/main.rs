

use std::sync::Mutex;
use std::sync::MutexGuard;

fn main() {
    let lock_x             = Mutex::new(());
    
    {
        let     guard_x: MutexGuard<()>  = lock_x.lock().unwrap();
        
         x += 1;
    }
    
    {
        let guard_x: MutexGuard<()>  = lock_x.lock().unwrap();
        
        println!("x is now {}",  x);
    }
}
