bool isNumber(String s) {
  return int.tryParse(s) != null && (int.tryParse(s)! >= 0);
}
