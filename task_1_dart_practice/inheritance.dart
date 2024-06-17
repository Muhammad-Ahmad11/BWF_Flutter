class Animal {
  void eat() {
    print('Eating');
  }
}

class Dog extends Animal {
  void bark() {
    print('Barking');
  }
}

void main() {
  var dog = Dog();
  dog.eat();
  dog.bark();
}
