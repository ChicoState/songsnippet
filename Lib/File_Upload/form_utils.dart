extension ExtString on String {
  bool get isValidTime {
    final timeRegExp = RegExp(r"^\+?0[0-0]$");
    return timeRegExp.hasMatch(this);
  }
}
