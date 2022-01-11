import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final Widget? hint;

  const CustomDropdownButton({
    Key? key,
    this.value,
    this.onChanged,
    this.items,
    this.hint = const Text('Bitte auswählen'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          onChanged: onChanged,
          items: items,
          underline: const SizedBox(),
          hint: hint,
          style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
