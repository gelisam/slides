use std::ops::Deref;
use std::ops::DerefMut;
use std::sync::Mutex;
use std::sync::MutexGuard;

fn my_deref_mut<'scope, A>(g: &'scope mut MutexGuard<A>) -> &'scope mut A
{
    g.deref_mut()
}

fn main() {
    let lock_x = Mutex::new(0);
    let lock_y = Mutex::new(100);
    
    {
        let mut guard_x = lock_x.lock().unwrap();
        let mut guard_y = lock_y.lock().unwrap();
        let x = my_deref_mut(&mut guard_x);
        let y = my_deref_mut(&mut guard_y);
        *x += 1;
        *y += 10;
    }
    
    {
        let guard_x = lock_x.lock().unwrap();
        let guard_y = lock_y.lock().unwrap();
        let x = guard_x.deref();
        let y = guard_y.deref();
        println!("x is now {}, y is now {}", *x, *y);
    }
}




































































































