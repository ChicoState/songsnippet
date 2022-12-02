// extension ExtString on String {
//   bool get isNumber {
//     final timeRegExp = RegExp(r"^\+?0[0-0]$");
//     return timeRegExp.hasMatch(this);
//   }
// }

bool isNumber(String s) {
  return int.tryParse(s) != null && (int.tryParse(s)! >= 0);
}
