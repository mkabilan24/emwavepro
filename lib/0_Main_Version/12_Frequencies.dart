import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';

void calc_freq() {
  double angularfreqValue = getDouble(angularfreq);
  double freqValue= angularfreqValue / (2 * pi);
  updateDouble(freq, freqValue);
  print("The frequency is $freqValue.");
}

void calc_angular_freq() {
  double freqValue = getDouble(freq);
  double angularfreqValue = 2 * pi * freqValue;
  updateDouble(angularfreq, angularfreqValue);
  print("The angular frequency is $angularfreqValue.");
}