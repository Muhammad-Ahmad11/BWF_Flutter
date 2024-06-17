Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() {
  Stream<int> stream = countStream(5);
  
  stream.listen((value) {
    print(value); // Output: 1, 2, 3, 4, 5 (one per second)
  });
}
