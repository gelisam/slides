use std::ops::Deref;
use std::ops::DerefMut;
use std::sync::Mutex;
use std::sync::MutexGuard;

fn main() {
    let lock_x: Mutex<i32> = Mutex::new(0);
    let x: &mut i32;
    
    {
        let mut guard_x: MutexGuard<i32> = lock_x.lock().unwrap();
        x = guard_x.deref_mut(); // type error!
        
        
    }
    
    
    
    {
        let guard_x: MutexGuard<i32> = lock_x.lock().unwrap();
        let x: &i32 = guard_x.deref();
        println!("x is now {}", *x);
    }
}
