class Circle {
  double _radius = 0.0;

  void setRadius(double radius) {
    _radius = radius;
  }

  double get area => 3.14 * _radius * _radius;
}

void main() {
  var circle = Circle();
  circle.setRadius(5.0);
  print('Area: ${circle.area}');
}
