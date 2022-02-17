import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String titleText;
  final String bodyText;
  final String buttonText;
  final VoidCallback buttonFunction;

  const ResultScreen(
      this.titleText, this.bodyText, this.buttonText, this.buttonFunction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 150),
                Image.asset('assets/images/figma/result-ok.png'),
                Container(height: 25),
                Text(
                  titleText,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Container(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: buttonFunction,
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
