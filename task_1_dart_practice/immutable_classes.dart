class ImmutablePoint {
  final int x;
  final int y;

  ImmutablePoint(this.x, this.y);
}

void main() {
  var point = ImmutablePoint(5, 10);
  print('x: ${point.x}, y: ${point.y}');
}
