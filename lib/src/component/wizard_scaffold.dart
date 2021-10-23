import 'package:amigo_flutter/src/config/themes/default_theme.dart';
import 'package:flutter/material.dart';

class WizardScaffold extends StatelessWidget {
  final Widget child;
  final int currentStep;
  final int maxSteps;

  const WizardScaffold(this.child, this.currentStep, this.maxSteps, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Zurück'),
            ElevatedButton(
              onPressed: null,
              child: Text('$currentStep/$maxSteps'),
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.resolveWith((_) => EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (_) => DefaultTheme.secondaryColor),
                shape: MaterialStateProperty.resolveWith(
                  (_) => const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 3,
              width:
                  MediaQuery.of(context).size.width * (currentStep / maxSteps),
              color: const Color(0xffffba5f),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: child,
      ),
    );
  }
}
