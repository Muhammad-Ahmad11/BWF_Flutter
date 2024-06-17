Function add(int a) {
  return (int b) => a + b;
}

void main() {
  var add5 = add(5);
  print(add5(10)); // Output: 15
}
