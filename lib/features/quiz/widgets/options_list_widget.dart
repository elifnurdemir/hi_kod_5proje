// options_list.dart
import 'package:flutter/material.dart';

class OptionsList extends StatelessWidget {
  final List<String> options;
  final Function(String) onOptionSelected;
  const OptionsList({required this.options, required this.onOptionSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) => Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ElevatedButton(
          onPressed: () => onOptionSelected(option),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A86B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 18),
            minimumSize: const Size(double.infinity, 70),
          ),
          child: Text(option, style: const TextStyle(fontSize: 20, color: Colors.white)),
        ),
      )).toList(),
    );
  }
}
