import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTryAgain;
  const CustomErrorWidget(
      {super.key, required this.title, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent.shade700,
                ),
                onPressed: () {
                  onTryAgain();
                },
                child: const Text('Thử lại'))
          ],
        ),
      ),
    );
  }
}
