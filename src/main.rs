

use std::sync::Mutex;


fn main() {
    let mut x: i32 = 0;
    let lock_x = Mutex::new(());
    
    {
                                      lock_x.lock();
        x += 1;
    }
    
    {
                                      lock_x.lock();
        println!("x is now {}", x);
    }
}
