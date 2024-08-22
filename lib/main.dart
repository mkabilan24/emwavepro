import 'package:emwavepro/widgets/losslessmediumproperties.dart';
import 'package:emwavepro/widgets/lossymediumproperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'theme.dart'; 
import 'package:math_keyboard/math_keyboard.dart';
import 'directionvectors.dart';
import 'update_eqns.dart';
import 'package:emwavepro/widgets/freespaceproperties.dart';

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

  String message = "";
  String message2 = "";

  //Only one component in E or H Field Equations
  final MathFieldEditingController _E0 = MathFieldEditingController();
  final MathFieldEditingController _H0 = MathFieldEditingController();
  final MathFieldEditingController _phi = MathFieldEditingController();

  //Default directions of EM Wave
  String a_E_Field_Propagation_1 = '+\\vec{a}_x';
  String a_H_Field_Propagation_1 = '+\\vec{a}_y';
  String a_k_Wave_Propagation_1 = '+\\vec{a}_z';

  //Default Equations of EM Wave
  String E_Time_Domain_Equation_1 = '\\vec{E} =  +\\vec{a}_x |E_{0}|\\cos(\\omega t - kz + \\phi)';
  String E_Phasor_Domain_Equation_1 = '\\vec{E} =  +\\vec{a}_x |E_{0}|\\angle\\phi e^{-jkz}';

  String H_Time_Domain_Equation_1 = '\\vec{H} =  +\\vec{a}_y |H_{0}|\\cos(\\omega t - kz + \\phi)';
  String H_Phasor_Domain_Equation_1 = '\\vec{H} =  +\\vec{a}_y |H_{0}|\\angle\\phi e^{-jkz}';

  //////
  //2 Components in E or H Field Equations
  //First Component of Equation
  final MathFieldEditingController _E01 = MathFieldEditingController();
  final MathFieldEditingController _H01 = MathFieldEditingController();
  final MathFieldEditingController _phi1 = MathFieldEditingController();

  //Default Variable names of First Component of Equation
  String E01 = '|E_{0x}|=';
  String H01 = '|H_{0y}|=';
  String phi1 = '\\phi_x=';

  //Default Directions of the First Component of the EM Wave
  String a_E_Field_Propagation_2_1 = '+\\vec{a}_x';
  String a_H_Field_Propagation_2_1 = '+\\vec{a}_y';

  //Default Equations of the First Component of the EM Wave
  String E_Time_Domain_Equation_2_1 = '+\\vec{a}_x |E_{0x}|\\cos(\\omega t - kz + \\phi_x)';
  String E_Phasor_Domain_Equation_2_1 = '+\\vec{a}_x |E_{0x}|\\angle\\phi_xe^{-jkz}';

  String H_Time_Domain_Equation_2_1 = '+\\vec{a}_y |H_{0y}|\\cos(\\omega t - kz + \\phi_y)';
  String H_Phasor_Domain_Equation_2_1 = '+\\vec{a}_y |H_{0y}|\\angle\\phi_ye^{-jkz}';

  //Second Component of Equation
  final MathFieldEditingController _E02 = MathFieldEditingController();
  final MathFieldEditingController _H02 = MathFieldEditingController();
  final MathFieldEditingController _phi2 = MathFieldEditingController();

  //Default Variable names of First Component of Equation
  String E02 = '|E_{0y}|=';
  String H02 = '|H_{0x}|=';
  String phi2 = '\\phi_y=';

  //Default Directions of the Second Component of the EM Wave
  String a_E_Field_Propagation_2_2 = '+\\vec{a}_y';
  String a_H_Field_Propagation_2_2 = '-\\vec{a}_x';

  //Default Equations of the Second Component of the EM Wave
  String E_Time_Domain_Equation_2_2 = '+\\vec{a}_y |E_{0y}|\\cos(\\omega t - kz + \\phi_y)';
  String E_Phasor_Domain_Equation_2_2 = '+\\vec{a}_y |E_{0y}|\\angle\\phi_ye^{-jkz}';

  String H_Time_Domain_Equation_2_2 = '-\\vec{a}_x |H_{0x}|\\cos(\\omega t - kz + \\phi_x)';
  String H_Phasor_Domain_Equation_2_2 = '-\\vec{a}_x |H_{0x}|\\angle\\phi_xe^{-jkz}';

  //Common Wave Propagation of 2 component Equation
  String a_k_Wave_Propagation_2 = '+\\vec{a}_z';

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

  void _update1CompEqns() {
    setState(() {
      List equations = update1CompEqns(a_E_Field_Propagation_1, a_H_Field_Propagation_1, a_k_Wave_Propagation_1, _E0, _H0, _phi);
      message = equations[0];
      E_Time_Domain_Equation_1 = equations[1];
      E_Phasor_Domain_Equation_1 = equations[2];
      H_Time_Domain_Equation_1 = equations[3];
      H_Phasor_Domain_Equation_1 = equations[4];
    });
  }

  void _update2CompEqns() {
    setState(() {
      List comp1equations = update2CompEqns("1", a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_k_Wave_Propagation_2, _E01, _H01, _phi1, E01, H01, phi1);
       message2 = comp1equations[0];
       E_Time_Domain_Equation_2_1 = comp1equations[1];
       E_Phasor_Domain_Equation_2_1 = comp1equations[2];
       H_Time_Domain_Equation_2_1 = comp1equations[3];
       H_Phasor_Domain_Equation_2_1 = comp1equations[4];
    
      List comp2equations = update2CompEqns("2", a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2, a_k_Wave_Propagation_2, _E02, _H02, _phi2, E02, H02, phi2);
       message2 = comp2equations[0];
       E_Time_Domain_Equation_2_2 = comp2equations[1];
       E_Phasor_Domain_Equation_2_2 = comp2equations[2];
       H_Time_Domain_Equation_2_2 = comp2equations[3];
       H_Phasor_Domain_Equation_2_2 = comp2equations[4];
    });
  }

  String _getdirection(String vectorstring) {
    return vectorstring[vectorstring.length-1];
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(8), // Adjust padding as needed
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400]!, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8), // Optional: Border radius
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width, // Maximum width constraint
                      ), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.isNotEmpty) 
                            Text(
                              message,
                              style: const TextStyle(fontSize: 18),
                            ),
                          Math.tex(
                            E_Time_Domain_Equation_1,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            E_Phasor_Domain_Equation_1,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            H_Time_Domain_Equation_1,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            H_Phasor_Domain_Equation_1,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Row(
                  children: [
                    Math.tex('\\text{E-Field propagation: }\\vec{a}_{E}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_E_Field_Propagation_1,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_E_Field_Propagation_1 = newValue;
                            a_k_Wave_Propagation_1 = wave_propagation_result(a_E_Field_Propagation_1, a_H_Field_Propagation_1);
                            _update1CompEqns();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Math.tex('\\text{H-Field propagation: }\\vec{a}_H=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_H_Field_Propagation_1,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_H_Field_Propagation_1 = newValue;
                            a_k_Wave_Propagation_1 = wave_propagation_result(a_E_Field_Propagation_1, a_H_Field_Propagation_1);
                            _update1CompEqns();
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                //Wave Propagation
                Math.tex('\\text{Wave propagation: }\\vec{a}_k= $a_k_Wave_Propagation_1', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(height: 20),
                Row(
                  children: [
                    //E_{0}
                    Math.tex('|E_{0}|=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _E0,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update1CompEqns(),
                      ),
                    ),
                    const SizedBox(width: 10),

                    //H_{0}
                    Math.tex('|H_{0}|=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _H0,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update1CompEqns(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                //phi
                Row(
                  children: [
                    Math.tex('\\phi=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _phi,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update1CompEqns(),
                      ),
                    ),
                    const SizedBox(width: 170),
                  ]
                ),
              ],
            ),
          ),
            
          Visibility(
            visible: (numofcomponents == "2"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(8), // Adjust padding as needed
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400]!, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8), // Optional: Border radius
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width, // Maximum width constraint
                      ), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message2.isNotEmpty) 
                            Text(
                              message2,
                              style: const TextStyle(fontSize: 18),
                            ),
                          Math.tex(
                            "\\vec{E} = $E_Time_Domain_Equation_2_1 $E_Time_Domain_Equation_2_2",
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            "\\vec{E} = $E_Phasor_Domain_Equation_2_1 $E_Phasor_Domain_Equation_2_2",
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            "\\vec{H} = $H_Time_Domain_Equation_2_1 $H_Time_Domain_Equation_2_2",
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            "\\vec{H} = $H_Phasor_Domain_Equation_2_1 $H_Phasor_Domain_Equation_2_2",
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 15),
                Math.tex('\\text{E-Field propagation: }', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Math.tex('\\vec{a}_{E1}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_E_Field_Propagation_2_1,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_E_Field_Propagation_2_1 = newValue;
                            a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                            E01 = "|E_{0${_getdirection(newValue)}}|=";
                            phi1 = "\\phi_${_getdirection(newValue)} = ";
                            _update2CompEqns();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Math.tex('\\vec{a}_{E2}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_E_Field_Propagation_2_2,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_E_Field_Propagation_2_2 = newValue;
                            a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                            E02 = "|E_{0${_getdirection(newValue)}}|=";
                            phi2 = "\\phi_${_getdirection(newValue)} = ";
                            _update2CompEqns();
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Math.tex('\\text{H-Field propagation: }', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Math.tex('\\vec{a}_{H1}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_H_Field_Propagation_2_1,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_H_Field_Propagation_2_1 = newValue;
                            a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                            H01 = "|H_{0${_getdirection(newValue)}}|=";
                            _update2CompEqns();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Math.tex('\\vec{a}_{H2}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_H_Field_Propagation_2_2,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_H_Field_Propagation_2_2 = newValue;
                            a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                            H02 = "|H_{0${_getdirection(newValue)}}|=";
                            _update2CompEqns();
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Math.tex('\\text{Wave propagation: }', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Math.tex('\\vec{a}_{k}= $a_k_Wave_Propagation_2', textStyle: const TextStyle(fontSize: 18),),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    //E_{01}
                    Math.tex(E01, textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _E01,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update2CompEqns(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    //E_{02}
                    Math.tex(E02, textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _E02,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update2CompEqns,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    //H_{01}
                    Math.tex(H01, textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _H01,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update2CompEqns(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    //H_{02}
                    Math.tex(H02, textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _H02,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update2CompEqns,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    //phi1
                    Math.tex(phi1, textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _phi1,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update2CompEqns,
                      ),
                    ),
                    const SizedBox(width: 10),

                    //phi2
                    Math.tex(phi2, textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _phi2,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _update2CompEqns,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
            
          const SizedBox(height: 15),

        ],
      ),
    );
  }
}
