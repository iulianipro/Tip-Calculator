import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();

  final List<bool> _selection = [true, false, false];

 String tip="";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body:
          Container(
        decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/background.png"),
        fit: BoxFit.cover,
         ),
        ),
         child: Center(
                 child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                if (tip != "")
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      tip,
                       style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                                      // backgroundColor: Colors.deepOrangeAccent,
                                       color: Colors.blue,
                         decoration: TextDecoration.underline,
                         decorationStyle: TextDecorationStyle.double,
                       ),
                    ),
                  ),
                 Text('Total Amount',
                    style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.black,
                    ),
                 ),

                SizedBox(
                  width: 110,
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: '\€100.00'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ToggleButtons(
                      isSelected: _selection,
                      onPressed: updateSelection,
                      children: const [Text('10%'), Text('15%'), Text('20%')]),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    fixedSize: const Size.fromWidth(150),
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: calculateTip, child: const Text("Calculate Tip")
                )],

            ),

          ),



        ),


    ),
    );
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTip() {
    final totalAmount = double.parse(controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercentage = [0.1, 0.15, 0.2][selectedIndex];

    final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

    setState(() {
      tip = '$tipTotal\€';
    });
  }
}