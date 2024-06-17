String? getName(bool isValid) {
  if (isValid) {
    return 'Alice';
  } else {
    return null;
  }
}

void main() {
  print(getName(true)); // Output: Alice
  print(getName(false)); // Output: null
}
