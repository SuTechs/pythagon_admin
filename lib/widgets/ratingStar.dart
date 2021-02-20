import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final Color color;
  final double size;
  final double rating;

  const RatingStar(
      {Key? key,
      this.color = Colors.yellow,
      this.size = 16,
      required this.rating})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: color, size: size),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [for (int i = 1; i <= 5; i++) getStar(rating - i + 1)],
      ),
    );
  }

  Widget getStar(double i) {
    if (i > 0.9) return Icon(Icons.star);

    if (i > 0.3) return Icon(Icons.star_half);

    return Icon(Icons.star_border);
  }
}
