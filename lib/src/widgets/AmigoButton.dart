import 'package:amigoapp/src/config/themes/default_theme.dart';
import 'package:flutter/material.dart';

class AmigoButton extends ElevatedButton {
  const AmigoButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enabled = true,
    Clip clipBehavior = Clip.none,
    required Widget? child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: (style ?? const ButtonStyle()).copyWith(
            backgroundColor: enabled
                ? MaterialStateProperty.all<Color>(AmigoColors.secondaryColor)
                : MaterialStateProperty.all<Color>(
                    AmigoColors.backgroundColor)));
  }
}
