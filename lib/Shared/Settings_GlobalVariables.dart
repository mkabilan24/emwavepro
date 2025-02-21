import 'package:flutter/material.dart';

int decimalPlaces = 3;
double conductivitymargin = 20;
bool isDegree = true;

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  void _resetToDefaults() {
    setState(() {
      decimalPlaces = 3;
      conductivitymargin = 20;
      isDegree = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EMWavePro',
          style: TextStyle(
            fontFamily: 'Roboto',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ToggleButtons(
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Colors.white,
                  color: Colors.black,
                  fillColor: Colors.blue,
                  isSelected: [isDegree, !isDegree],
                  onPressed: (index) {
                    setState(() {
                      isDegree = index == 0;
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Degrees',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Radians',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Decimal Places:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                DropdownButton<int>(
                  value: decimalPlaces,
                  onChanged: (int? newValue) {
                    setState(() {
                      decimalPlaces = newValue!;
                    });
                  },
                  items: <int>[0, 1, 2, 3, 4, 5, 6]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Conductivity Margin:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text(conductivitymargin.round().toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: conductivitymargin,
              min: 5,
              max: 100,
              divisions: 100,
              label: conductivitymargin.round().toString(),
              onChanged: (double value) {
                setState(() {
                  conductivitymargin = value;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _resetToDefaults,
                child: Text('Reset to Default'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
