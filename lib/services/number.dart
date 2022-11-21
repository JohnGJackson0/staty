Function isValidDecimalInput = (String val) {
  try {
    double.parse(val);
    return true;
  } catch (e) {
    return false;
  }
};

Function isValidLengthInputWithDOF = (String val) {
  try {
    return int.parse(val) > 1;
  } catch (e) {
    return false;
  }
};
