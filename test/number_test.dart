import 'package:flutter_test/flutter_test.dart';
import 'package:staty/services/number.dart';

void main() {
  test('isValidLengthInputWithDOF should return true for values over 1', () {
    expect(isValidLengthInputWithDOF('4'), true);
    expect(isValidLengthInputWithDOF('90'), true);
  });
  test('isValidLengthInputWithDOF should return false for other values 1', () {
    expect(isValidLengthInputWithDOF('-1'), false);
    expect(isValidLengthInputWithDOF('a'), false);
    expect(isValidLengthInputWithDOF('1'), false);
  });

  test('is valid decimal input returns true for decimal', () {
    expect(isValidDecimalInput('1'), true);
    expect(isValidDecimalInput('1 '), true);
    expect(isValidDecimalInput('1.2'), true);
    expect(isValidDecimalInput('a'), false);
  });
}
