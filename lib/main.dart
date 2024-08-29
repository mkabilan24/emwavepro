import 'package:emwavepro/widgets/losslessmediumproperties.dart';
import 'package:emwavepro/widgets/lossymediumproperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'Miscellaneous/theme.dart'; 
import 'package:math_keyboard/math_keyboard.dart';
import 'Calculations/directionvectors.dart';
import 'Calculations/update_eqns.dart';
import 'package:emwavepro/widgets/freespaceproperties.dart';
import 'package:emwavepro/widgets/1ComponentEquations.dart';
import 'package:emwavepro/widgets/2ComponentEquations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('EM Wave Analysis'),
        ),
        body: const MainWidget(),
      ),
      themeMode: ThemeMode.light, // or ThemeMode.dark
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  String numofcomponents = "2";
  List <bool> selected = [false, true];

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _E01.dispose();
    // _phi_x.dispose();
    // _E02.dispose();
    // _phi_y.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        //Free Space Properties
        children: [
          //Free Space Properties
          FreespacePropertiesWidget(),
          //Lossless Medium Properties
          LosslessMediumPropertiesWidget(),
          //Lossy Medium Properties
          LossyMediumPropertiesWidget(),

          const SizedBox(height: 15),

          //Number of Components of E-Field Function
          Row(children: [
            Math.tex('\\text{Number of Components: }', textStyle: const TextStyle(fontSize: 18),),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  List <String> list = ["1", "2"];
                  numofcomponents = list[index];
                  if (index == 0) {
                    selected = [true, false];
                  } else if (index == 1) {
                    selected = [false, true];
                  }
                });
              },
              isSelected: selected,
              children: const [
                Text("1",),
                Text("2",),
              ]
            ),
          ],),
          const SizedBox(height: 15),

          Visibility(
            visible: (numofcomponents == "1"),
            child: Component1EquationsWidget(),
          ),
            
          Visibility(
            visible: (numofcomponents == "2"),
            child: Component2EquationsWidget(),
          ),
            
          const SizedBox(height: 15),

        ],
      ),
    );
  }
}
