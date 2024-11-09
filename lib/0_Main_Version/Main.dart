import 'package:emwavepro/0_Main_Version/Lossless/Main_Lossless.dart';
import 'package:emwavepro/0_Main_Version/Lossy/Main_Lossy.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'EMWavePro',
            style: TextStyle(
              fontFamily: 'Roboto', // You can use a custom font here
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          actions: [
            Padding(padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  size: 30.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Add settings functionality here
                },
                tooltip: 'Settings', // Add a tooltip for better accessibility
              ),
            ),
          ],
        ),
        body: RadioButtonsRow(),
      ),
    );
  }
}

class RadioButtonsRow extends StatefulWidget {
  @override
  _RadioButtonsRowState createState() => _RadioButtonsRowState();
}

class _RadioButtonsRowState extends State<RadioButtonsRow> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedValue = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: _selectedValue == 0 ? Colors.blue : Colors.white,
                    border: Border.all(
                      color: _selectedValue == 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Lossless',
                      style: TextStyle(
                        color: _selectedValue == 0 ? Colors.white : Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedValue = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: _selectedValue == 1 ? Colors.blue : Colors.white,
                    border: Border.all(
                      color: _selectedValue == 1 ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Lossy',
                      style: TextStyle(
                        color: _selectedValue == 1 ? Colors.white : Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: _selectedValue == 1
              ? LossyEMFieldEquationsWidget()
              : EMFieldEquationsWidget(),
        ),
      ],
    );
  }
}