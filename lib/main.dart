import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_number_checker/flutter_number_checker.dart' as checker;

void main() {
  runApp(const CheckerApp());
}

class CheckerApp extends StatelessWidget {
  const CheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shapes',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: const CheckerPage(title: 'Number Shapes'),
    );
  }
}

class CheckerPage extends StatefulWidget {
  const CheckerPage({super.key, required this.title});

  final String title;

  @override
  State<CheckerPage> createState() => _CheckerPageState();
}

class _CheckerPageState extends State<CheckerPage> {
  String? _alertMessage;
  String? _alertTitle;

  final TextEditingController sumController = TextEditingController();

  void _calculateResult() {
    setState(() {
      if (sumController.text.isEmpty) {
        _alertMessage = 'Please enter a number.';
      } else {
        var number = int.parse(sumController.text);
        _alertMessage = "Number $number is neither TRIANGULAR nor SQUARE.";
        bool isSquare = checker.FlutterNumberChecker.isPerfectSquare(number);
        bool isTriangle = checker.FlutterNumberChecker.isTriangularNumber(number);
        if (isSquare && isTriangle) {
          _alertMessage = "Number $number is both SQUARE and TRIANGULAR.";
        } else {
          if (isSquare) {
            _alertMessage = "Number $number is SQUARE.";
          }
          if (isTriangle) {
            _alertMessage = "Number $number is TRIANGULAR.";
          }
        }
        _alertTitle = number.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text(widget.title)),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const Text(
                'Please input a number to see if it is square or triangular.',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              TextField(
                controller: sumController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:\.\d+)?$')),
                ],
              )
            ]),
            IconButton(
                icon: const Icon(Icons.check_circle),
                iconSize: 50,
                color: Colors.blueAccent,
                onPressed: () {
                  _calculateResult();
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(_alertTitle!),
                      content: Text(_alertMessage!),
                      actions: [
                        TextButton(
                          child: const Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ]
                    );
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}