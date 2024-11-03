import 'package:flutter/material.dart';

class AditionInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AditionInfoItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,size: 32,),
        const SizedBox(
          height: 7,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(
          width: 27,
        ),
      ],
    );
  }
}
