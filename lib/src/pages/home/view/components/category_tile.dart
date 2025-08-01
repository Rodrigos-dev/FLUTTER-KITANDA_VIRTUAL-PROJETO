import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onpressed
  }) : super(key: key);

  final String category;
  final bool isSelected;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? CustomColors.customSwatchColor : Colors.transparent,
          ),
          child: Text(category,
              style: TextStyle(
                color: isSelected ? Colors.white : CustomColors.customContrastColor,
                fontWeight: FontWeight.bold,
                fontSize: isSelected ? 16 : 14
              )),
        ),
      ),
    );
  }
}
