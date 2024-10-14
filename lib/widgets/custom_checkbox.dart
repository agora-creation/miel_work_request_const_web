import 'package:flutter/material.dart';
import 'package:miel_work_request_const_web/common/style.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?)? onChanged;
  final bool borderView;

  const CustomCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
    this.borderView = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: borderView
          ? const BoxDecoration(
              border: Border(
                top: BorderSide(color: kDisabledColor),
                bottom: BorderSide(color: kDisabledColor),
              ),
            )
          : null,
      child: CheckboxListTile(
        title: Text(label),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
