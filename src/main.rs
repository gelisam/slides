use std::ops::Deref;
use std::ops::DerefMut;
use std::sync::Mutex;
use std::sync::MutexGuard;

fn deref_incr(g: &mut MutexGuard<i32>)
{
    let x: &mut i32 = g.deref_mut();
    *x += 1;
}

fn main() {
    let lock_x = Mutex::new(0);
    
    {
        let mut guard_x;
        let mut alt_guard_x;
        
        guard_x = lock_x.lock().unwrap();
        deref_incr(&mut guard_x);
        alt_guard_x = guard_x;
        
    }
    
    {
        let guard_x = lock_x.lock().unwrap();
        let x = guard_x.deref();
        println!("x is now {}", *x);
    }
}




































































































