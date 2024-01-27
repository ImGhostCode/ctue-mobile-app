import 'package:flutter/material.dart';

class MyFeatureListTile extends StatelessWidget {
  final String imagePath;

  final String title;

  final String subtitle;

  final VoidCallback onTap;
  const MyFeatureListTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 10,
      minVerticalPadding: 8,
      titleTextStyle: const TextStyle(color: Colors.yellow),
      tileColor: Colors.green,
      leading: Image.asset(
        imagePath,
        height: 40,
        width: 40,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.yellow),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        size: 35,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}
