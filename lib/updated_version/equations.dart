String wave_propagation_result(String a_E_Field_Propagation, String a_H_Field_Propagation) {

    //E-Field along X-axis
    if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_H_Field_Propagation == '+\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_H_Field_Propagation == '-\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_H_Field_Propagation == '+\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_H_Field_Propagation == '-\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }

    if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_H_Field_Propagation == '+\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_H_Field_Propagation == '-\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_H_Field_Propagation == '+\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_H_Field_Propagation == '-\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }

    //E-Field along Y-axis
    if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_H_Field_Propagation == '+\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_H_Field_Propagation == '-\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_H_Field_Propagation == '+\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_H_Field_Propagation == '-\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }

    if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_H_Field_Propagation == '+\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_H_Field_Propagation == '-\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_H_Field_Propagation == '+\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_H_Field_Propagation == '-\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }

    //E-Field along Z-axis
    if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_H_Field_Propagation == '+\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_H_Field_Propagation == '-\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_H_Field_Propagation == '+\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
    if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_H_Field_Propagation == '-\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }

    if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_H_Field_Propagation == '+\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_H_Field_Propagation == '-\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_H_Field_Propagation == '+\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }
    if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_H_Field_Propagation == '-\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
    return 'Error!';
  }

String H_Field_Direction_result(String a_E_Field_Propagation, String a_k_Wave_Propagation) {
  //E-Field along X-axis
  if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    
  if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }

  //E-Field along Y-axis
  if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }

  if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    
  //E-Field along z-axis
  if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
  if ((a_E_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }

  if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
  if ((a_E_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }
  return 'Error!';
}

String E_Field_Direction_result(String a_H_Field_Propagation, String a_k_Wave_Propagation) {

    //E-Field along X-axis
    if ((a_H_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '+\\vec{a}_x';
    }
    if ((a_H_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '+\\vec{a}_x';
    }

    if ((a_H_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '-\\vec{a}_x';
    }
    if ((a_H_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '-\\vec{a}_x';
    }

    //E-Field along Y-axis
    if ((a_H_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '+\\vec{a}_y';
    }
    if ((a_H_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '+\\vec{a}_y';
    }

    if ((a_H_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_z')) {
      return '-\\vec{a}_y';
    }
    if ((a_H_Field_Propagation == '+\\vec{a}_z') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_z') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '-\\vec{a}_y';
    }

    //E-Field along Z-axis
    if ((a_H_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '+\\vec{a}_z';
    }
    if ((a_H_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '+\\vec{a}_z';
    }

    if ((a_H_Field_Propagation == '+\\vec{a}_x') && (a_k_Wave_Propagation == '-\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_x') && (a_k_Wave_Propagation == '+\\vec{a}_y')) {
      return '-\\vec{a}_z';
    }
    if ((a_H_Field_Propagation == '+\\vec{a}_y') && (a_k_Wave_Propagation == '+\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    if ((a_H_Field_Propagation == '-\\vec{a}_y') && (a_k_Wave_Propagation == '-\\vec{a}_x')) {
      return '-\\vec{a}_z';
    }
    return 'Error!';
  }
  