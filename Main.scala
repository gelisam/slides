#include <algorithm>
#include <iostream>
#include <list>
#include <set>
#include <string>
using namespace std;


template <typename A>
struct MyList {
  list<A> impl;
  
  MyList(list<A> impl)
  : impl(impl) {}
  
  template <typename B>
  MyList<B> map(function<B(A)> f) {
    list<B> result;
    transform(
      impl.begin(),
      impl.end(),
      inserter(result, result.end()),
      f
    );
    return MyList<B>(result);
  }
  
  void print() {
    auto it = impl.begin();
    cout << "list(";
    if (it != impl.end()) {
      cout << *it;
      for(++it; it != impl.end(); ++it) {
        cout << ", " << *it;
      }
    }
    cout << ")" << endl;
  }
};

template <typename A>
struct MySet {
  set<A> impl;
  
  MySet(set<A> impl)
  : impl(impl) {}
  
  template <typename B>
  MySet<B> map(function<B(A)> f) {
    set<B> result;
    transform(
      impl.begin(),
      impl.end(),
      inserter(result, result.end()),
      f
    );
    return MySet<B>(result);
  }
  
  void print() {
    auto it = impl.begin();
    cout << "set(";
    if (it != impl.end()) {
      cout << *it;
      for(++it; it != impl.end(); ++it) {
        cout << ", " << *it;
      }
    }
    cout << ")" << endl;
  }
};


int processString(string str) {
  return str.size();
}


MyList<int> processList(MyList<string> strs) {
  function<int(string)> f = [](string str) {
    return processString(str);
  };
  
  return strs.map(f);
}

MySet<int> processSet(MySet<string> strs) {
  function<int(string)> f = [](string str) {
    return processString(str);
  };
  
  return strs.map(f);
}


int main() {
  cout << processString("hello") << endl;
  
  processList(MyList<string>(list<string>{"hello", "world"})).print(); // list(5, 5)
  processSet(MySet<string>(set<string>{"hello", "world"})).print(); // set(5)
}

























































































