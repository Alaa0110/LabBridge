import 'package:flutter/material.dart';


class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: const Icon(Icons.question_mark)
        ),
        AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0, // يتحكم في ظهور واختفاء النص
          duration: const Duration(seconds: 1),
          child: const Text(
            'تواصل مع صاحب المعمل لتحصل على الرمز',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}