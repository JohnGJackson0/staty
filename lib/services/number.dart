Function isValidDecimalInput = (String val) {
  try {
    double.parse(val);
    return true;
  } catch (e) {
    return false;
  }
};
