String determinepolarisation(double EH01, double EH02, double phi1, double phi2) {

  if ((EH01 == 0) || (EH02 == 0)) {
    return "Linear";
  }
  double absolutePhaseDiff = (phi1 - phi2).abs();
  if ((absolutePhaseDiff == 0) || (absolutePhaseDiff == 180)) {
    return "Linear";
  }
  if ((absolutePhaseDiff == 90) && (EH01 == EH02)) {
    return "Circular";
  }
  return "Elliptical";
}