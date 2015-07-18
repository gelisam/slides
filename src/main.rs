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
    
    {
        let mut guard_x = lock_x.lock().unwrap();
        
        let x = my_deref_mut(&mut guard_x);
        *x += 1;
    }
    
    {
        let guard_x = lock_x.lock().unwrap();
        let x = guard_x.deref();
        println!("x is now {}", *x);
    }
}




































































































