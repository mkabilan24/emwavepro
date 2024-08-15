import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

final List<String> vect_options = [
  '+\\vec{a}_x',
  '-\\vec{a}_x',
  '+\\vec{a}_y',
  '-\\vec{a}_y',
  '+\\vec{a}_z',
  '-\\vec{a}_z',
];

String wave_propagation_result(String a_E_Field_Propagation_1, String a_H_Field_Propagation_1) {

    //E-Field along X-axis
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_x') && (a_H_Field_Propagation_1 == '+\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_x') && (a_H_Field_Propagation_1 == '-\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_x') && (a_H_Field_Propagation_1 == '+\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_x') && (a_H_Field_Propagation_1 == '-\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }

    if ((a_E_Field_Propagation_1 == '-\\vec{a}_x') && (a_H_Field_Propagation_1 == '+\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_x') && (a_H_Field_Propagation_1 == '-\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_x') && (a_H_Field_Propagation_1 == '+\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_x') && (a_H_Field_Propagation_1 == '-\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }

    //E-Field along Y-axis
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_y') && (a_H_Field_Propagation_1 == '+\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_y') && (a_H_Field_Propagation_1 == '-\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_y') && (a_H_Field_Propagation_1 == '+\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_y') && (a_H_Field_Propagation_1 == '-\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }

    if ((a_E_Field_Propagation_1 == '-\\vec{a}_y') && (a_H_Field_Propagation_1 == '+\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_y') && (a_H_Field_Propagation_1 == '-\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_y') && (a_H_Field_Propagation_1 == '+\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_y') && (a_H_Field_Propagation_1 == '-\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }

    //E-Field along Z-axis
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_z') && (a_H_Field_Propagation_1 == '+\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_z') && (a_H_Field_Propagation_1 == '-\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_z') && (a_H_Field_Propagation_1 == '+\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
    if ((a_E_Field_Propagation_1 == '+\\vec{a}_z') && (a_H_Field_Propagation_1 == '-\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }

    if ((a_E_Field_Propagation_1 == '-\\vec{a}_z') && (a_H_Field_Propagation_1 == '+\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_z') && (a_H_Field_Propagation_1 == '-\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_z') && (a_H_Field_Propagation_1 == '+\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }
    if ((a_E_Field_Propagation_1 == '-\\vec{a}_z') && (a_H_Field_Propagation_1 == '-\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
    return 'Error!';
  }

class MathDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> options;
  final Function(String) onChanged;

  const MathDropdown({super.key, 
    required this.initialValue,
    required this.options,
    required this.onChanged,
  });

  @override
  _MathDropdownState createState() => _MathDropdownState();
}

class _MathDropdownState extends State<MathDropdown> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        decoration: const InputDecoration(
          border: InputBorder.none, // Remove default border
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
          });
          widget.onChanged(newValue!);
        },
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Math.tex(
              value,
              textStyle: const TextStyle(fontSize: 20), // Customize as needed
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return widget.options.map<Widget>((String value) {
            return Math.tex(
              selectedOption,
              textStyle: const TextStyle(fontSize: 20), // Customize as needed
            );
          }).toList();
        },
      ),
    );
  }
}