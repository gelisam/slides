use std::ops::Deref;
use std::ops::DerefMut;
use std::sync::Mutex;
use std::sync::MutexGuard;

fn my_deref_mut<'scope, A>(g: &'scope mut MutexGuard<A>) -> &'scope mut A
{
    g.deref_mut()
}

fn main() {
    let lock_x: Mutex<i32> = Mutex::new(0);
    
    
    {
        let mut guard_x: MutexGuard<i32> = lock_x.lock().unwrap();
        let x: &mut i32 = my_deref_mut(&mut guard_x); // typechecks!
    }
    
    {
        let guard_x: MutexGuard<i32> = lock_x.lock().unwrap();
        let x: &i32 = guard_x.deref();
        println!("x is now {}", *x);
    }
}
