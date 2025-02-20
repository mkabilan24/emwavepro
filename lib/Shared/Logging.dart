import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

List<String> steps = [];

void log_lossless() {
  steps.clear();
  steps = [
    '\\text{You have selected lossless medium.}',
    '\\text{Lossless media have no conductivity, so the conductivity is zero} (\\sigma =\\ 0\\ S/m).',
    '\\text{Step 1: Calculate the intrinsic impedance }(\\eta) \\text{ of the lossless medium.}',
    '\\text{Given that relative permeability }(\\mu_{r} = ${getDouble(lossless_relativepermeability)}) \\text{ and relative permittivity }(\\varepsilon_{r} = ${getDouble(lossless_relativepermittivity)})\\text{ are known,}',
    '\\text{the intrinsic impedance }(\\eta) \\text{ of the lossless medium is given by the formula:}',
    '\\eta = \\sqrt{\\frac{\\mu_{r}}{\\varepsilon_{r}}} \\times 120\\pi.',
  ];
}

void log_lossy() {
  steps.clear();
  steps = [
    'Step 1: Calculate the conductivity of the lossy medium.',
    'Step 2: Calculate the permeability of the lossy medium.',
    'Step 3: Calculate the permittivity of the lossy medium.',
    'Step 4: Calculate the intrinsic impedance of the lossy medium.',
  ];
}

class Logging extends StatefulWidget {
  @override
  _LoggingState createState() => _LoggingState();
}

class _LoggingState extends State<Logging> {
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Step-By-Step Workings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.all(10.0),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: steps.map((step) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical spacing
                        child: Math.tex(
                          step,
                          mathStyle: MathStyle.display,
                          textStyle: TextStyle(fontSize: 18), // Increase font size
                        ),
                      )).toList(),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your button action here
                log_lossless(); // Example action
                setState(() {}); // Refresh the UI
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
