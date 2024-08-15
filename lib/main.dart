import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'theme.dart'; 
import 'package:math_keyboard/math_keyboard.dart';
import 'vectorsdropdown.dart';
import 'update_eqns.dart';

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
          title: const Text('Equation Input Example'),
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
  final MathFieldEditingController _E0x = MathFieldEditingController();
  final MathFieldEditingController _H0x = MathFieldEditingController();
  final MathFieldEditingController _phix = MathFieldEditingController();

  String? a_E_Field_Propagation_2_1 = '+\\vec{a}_x';
  String? a_H_Field_Propagation_2_1 = '+\\vec{a}_y';
  String? a_k_Wave_Propagation_2_1 = '+\\vec{a}_z';

  //Second Component of Equation
  final MathFieldEditingController _E0y = MathFieldEditingController();
  final MathFieldEditingController _H0y = MathFieldEditingController();
  final MathFieldEditingController _phiy = MathFieldEditingController();

  String? a_E_Field_Propagation_2_2 = '+\\vec{a}_y';
  String? a_H_Field_Propagation_2_2 = '+\\vec{a}_x';
  String? a_k_Wave_Propagation_2_2 = '+\\vec{a}_z';

  //Equation with 2 Components
  String E_Time_Domain_Equation_2 = '\\vec{E} =  \\vec{a}_x |E_{0x}|\\cos(\\omega t - k_{1}z + \\phi_x) + \\vec{a}_y |E_{0y}|\\cos(\\omega t - k_{2}z + \\phi_y)';
  String E_Phasor_Domain_Equation_2 = '\\vec{E} =  \\vec{a}_x |E_{0x}|\\angle\\phi_xe^{-jk_{1}z} + \\vec{a}_y |E_{0y}|\\angle\\phi_ye^{-jk_{2}z}';

  String H_Time_Domain_Equation_2 = '\\vec{H} =  \\vec{a}_x |H_{0x}|\\cos(\\omega t - k_{1}z + \\phi_x) + \\vec{a}_y |H_{0y}|\\cos(\\omega t - k_{2}z + \\phi_y)';
  String H_Phasor_Domain_Equation_2 = '\\vec{H} =  \\vec{a}_x |H_{0x}|\\angle\\phi_xe^{-jk_{1}z} + \\vec{a}_y |H_{0y}|\\angle\\phi_ye^{-jk_{2}z}';


  String numofcomponents = "1";
  List <bool> selected = [true, false];

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _E0x.dispose();
    // _phi_x.dispose();
    // _E0y.dispose();
    // _phi_y.dispose();
    super.dispose();
  }

  void setETimeDomainEquation1(String value) {
    setState(() {
      E_Time_Domain_Equation_1 = value;
    });
  }

  void setEPhasorDomainEquation1(String value) {
    setState(() {
      E_Phasor_Domain_Equation_1 = value;
    });
  }

  void setHTimeDomainEquation1(String value) {
    setState(() {
      H_Time_Domain_Equation_1 = value;
    });
  }

  void setHPhasorDomainEquation1(String value) {
    setState(() {
      H_Phasor_Domain_Equation_1 = value;
    });
  }


  void _updateComponent2Vectors() {
    // setState(() {
    //   if (a_k_Wave_Propagation_2_1 == '+\\vec{a}_z') {
    //   E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t - kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    //   E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jkz}';

    //   H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t - kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    //   H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jkz}';
    //   }
    //   if (a_k_Wave_Propagation_1 == '-\\vec{a}_z') {
    //     E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t + kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    //     E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jkz}';

    //     H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t + kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    //     H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jkz}';
    //   }
    // });
  }

  //TODO
  void _updateComponent2Eqns() {
  
  }

  void _updateEquation() {
    setState(() {
      //E_Time_Domain_Equation_2 = '\\vec{E} =  \\vec{a}_x ${_isMFControllerEmpty(_E0x) ? '|E_{ox}|' : _E0x.currentEditingValue()}\\cos(\\omega t - kz + ${_isMFControllerEmpty(_phi_x) ? '\\phi_x' : _phi_x.currentEditingValue()}) + \\vec{a}_y ${_isMFControllerEmpty(_E0y) ? '|E_{oy}|' : _E0y.currentEditingValue()}\\cos(\\omega t - kz + ${_isMFControllerEmpty(_phi_y) ? '\\phi_y' : _phi_y.currentEditingValue()})';
      //E_Phasor_Domain_Equation_2 = '\\vec{E} =  \\vec{a}_x ${_isMFControllerEmpty(_E0x) ? '|E_{ox}|' : _E0x.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi_x) ? '\\phi_x' : _phi_x.currentEditingValue()}e^{-jkz} + \\vec{a}_y ${_isMFControllerEmpty(_E0y) ? '|E_{oy}|' : _E0y.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi_y) ? '\\phi_y' : _phi_y.currentEditingValue()}e^{-jkz}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        //Free Space Properties
        children: [
          const Text('Assuming Free Space,', style: TextStyle(fontSize: 18),),
          const SizedBox(height: 15),
          Math.tex('\\text{Permeability, }\\mu = \\mu_0 = 4\\pi*10^{-7}\\,H/m', textStyle: const TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          Math.tex('\\text{Permittivity, }\\varepsilon = \\varepsilon_0 = \\frac{1}{36\\pi}*10^{-9}\\,F/m', textStyle: const TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          Math.tex('\\text{Conductivity, }\\sigma = 0\\,S/m', textStyle: const TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          Math.tex('\\text{Impedence, }\\eta = \\sqrt{\\frac{\\mu}{\\varepsilon}} = \\frac{E}{H} = 120\\pi \\approx 377\\,\\Omega', textStyle: const TextStyle(fontSize: 18)),
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
                        initialValue: a_E_Field_Propagation_1!,
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
                        initialValue: a_H_Field_Propagation_1!,
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
                          Math.tex(
                            E_Time_Domain_Equation_2,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            E_Phasor_Domain_Equation_2,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            H_Time_Domain_Equation_2,
                            mathStyle: MathStyle.display, // Render the equation using LaTeX
                            textStyle: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Math.tex(
                            H_Phasor_Domain_Equation_2,
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
                        initialValue: a_E_Field_Propagation_2_1!,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_E_Field_Propagation_2_1 = newValue;
                            //_updateVectors();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Math.tex('\\vec{a}_{E2}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_E_Field_Propagation_2_2!,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_E_Field_Propagation_2_2 = newValue;
                            //_updateVectors();
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
                        initialValue: a_H_Field_Propagation_2_1!,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_H_Field_Propagation_2_1 = newValue;
                            //_updateVectors();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Math.tex('\\vec{a}_{H2}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_H_Field_Propagation_2_2!,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_H_Field_Propagation_2_2 = newValue;
                            //_updateVectors();
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
                  children: [
                    Math.tex('\\vec{a}_{k1}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_k_Wave_Propagation_2_1!,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_k_Wave_Propagation_2_1 = newValue;
                            //_updateVectors();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Math.tex('\\vec{a}_{k2}=', textStyle: const TextStyle(fontSize: 18),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathDropdown(
                        initialValue: a_k_Wave_Propagation_2_2!,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_k_Wave_Propagation_2_2 = newValue;
                            //_updateVectors();
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    //E_{0}
                    Math.tex('|E_{0x}|=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _E0x,
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
                    Math.tex('|H_{0x}|=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _H0x,
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

                const SizedBox(height: 15),

                Row(
                  children: [
                    //E_{0}
                    Math.tex('|E_{0y}|=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _E0y,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _updateComponent2Eqns(),
                      ),
                    ),
                    const SizedBox(width: 10),

                    //H_{0}
                    Math.tex('|H_{0y}|=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _H0y,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _updateComponent2Eqns(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    //phi_x
                    Math.tex('\\phi_x=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _phix,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _updateEquation(),
                      ),
                    ),
                    const SizedBox(width: 10),

                    //phi_y
                    Math.tex('\\phi_y=', textStyle: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MathField(
                        controller: _phiy,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (_) => _updateEquation(),
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
