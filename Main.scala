#include <algorithm>
#include <iostream>
#include <list>
#include <string>
using namespace std;



int processString(string str) {
  return str.size();
}

list<int> processList(list<string> strs) {
  list<int> result;
  transform(
    strs.begin(),
    strs.end(),
    inserter(result,result.end()),
    ::processString
  );
  return result;
}


int main() {
  cout << processString("hello") << endl;
  
  list<int> r1 = processList(list<string>{"hello", "world"});
  cout << "list(" << endl;
  for(auto it = r1.begin(); it != r1.end(); ++it) {
    cout << "  " << *it << endl;
  }
  cout << ")" << endl;
}

























































































