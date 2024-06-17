mixin Fly {
  void fly() {
    print('Flying');
  }
}

class Bird with Fly {}

void main() {
  var bird = Bird();
  bird.fly();
}
