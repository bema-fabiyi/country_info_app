import 'package:flutter/material.dart';

class CountryInfoItem extends StatelessWidget {
  const CountryInfoItem({
    super.key,
    required this.title,
    required this.info,
  });

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            info,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
