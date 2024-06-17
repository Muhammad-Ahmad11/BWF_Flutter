class Animal {
  void sound() {
    print('Some sound');
  }
}

class Dog extends Animal {
  @override
  void sound() {
    print('Bark');
  }
}

void main() {
  Animal myDog = Dog();
  myDog.sound(); // Output: Bark
}
