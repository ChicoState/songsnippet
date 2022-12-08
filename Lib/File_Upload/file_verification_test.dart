import 'package:flutter_test/flutter_test.dart';
import 'form_utils.dart';

void main(List<String> args) {
  const String time1 = "100";
  const String time10 = "0";
  const String time11 = "11";
  const String time2 = "100 seconds";
  const String time21 = "-123";
  const String time22 = "100s";
  const String time23 = "12.34";

  test('Valid_Time', () {
    expect(true, isNumber(time1));
    expect(true, isNumber(time11));
    expect(true, isNumber(time10));
  });

  test('Invalid_times', () {
    expect(false, isNumber(time2));
    expect(false, isNumber(time21));
    expect(false, isNumber(time22));
    expect(false, isNumber(time23));
  });
}
