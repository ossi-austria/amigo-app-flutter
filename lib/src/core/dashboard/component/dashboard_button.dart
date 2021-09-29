import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const DashboardButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
              size: 60,
            ),
            Container(
              height: 10,
            ),
            Text(
              label.split(' ').join('\n'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
