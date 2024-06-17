int globalVar = 10;

void greet(String name, int age) {
  print('Hello $name, you are $age years old.');
}

void main() {
  greet('Alice', 30);
  print('Global variable: $globalVar');
}
