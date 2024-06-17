void greet({required String name, required int age}) {
  print('Hello $name, you are $age years old.');
}

void main() {
  greet(name: 'Alice', age: 30);
}
