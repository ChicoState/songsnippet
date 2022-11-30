import 'package:flutter_test/flutter_test.dart';
import 'form_utils.dart';

void main(List<String> args) {
  const String time1 = "100";
  const String time2 = "100 seconds";
  const String time3 = "100s";

  test ('test_tester', (){
    expect (0, 0);
  });

  test('Valid_Time', (){
    expect(true, isNumber(time1));
  });

  test('Invalid_times', (){
    expect(false, isNumber(time2));
    expect(false, isNumber(time3));
  });
}