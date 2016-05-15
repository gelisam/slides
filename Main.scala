#include <algorithm>
#include <iostream>
#include <list>
#include <set>
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

set<int> processSet(set<string> strs) {
  set<int> result;
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
  
  set<int> r2 = processSet(set<string>{"hello", "world"});
  cout << "set(" << endl;
  for(auto it = r2.begin(); it != r2.end(); ++it) {
    cout << "  " << *it << endl;
  }
  cout << ")" << endl;
}

























































































