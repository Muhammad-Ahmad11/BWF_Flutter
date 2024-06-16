enum Colors {
  red('FF0000'),
  green('00FF00'),
  blue('0000FF');

  final String hex;
  const Colors(this.hex);
}

void main() {
  var color = Colors.red;
  print(color.hex); // Output: FF0000
}
