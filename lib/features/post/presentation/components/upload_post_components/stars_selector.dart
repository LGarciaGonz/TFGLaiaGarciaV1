import 'package:flutter/material.dart';

class StarsSelector extends StatelessWidget {
  final int starsNumber;
  final Function(int) onStarSelected;

  const StarsSelector({
    super.key,
    required this.starsNumber,
    required this.onStarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return IconButton(
          icon: Icon(
            starsNumber >= starIndex ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () => onStarSelected(starIndex),
        );
      }),
    );
  }
}
