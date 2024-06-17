abstract class Animal {
  void eat();
}

class Dog extends Animal {
  @override
  void eat() {
    print('Dog is eating');
  }
}

void main() {
  var dog = Dog();
  dog.eat();
}
