extension ExtString on String {
  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([].,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidTime {
    final timeRegExp = RegExp(r"^\+?0[0-0]$");
    return timeRegExp.hasMatch(this);
  }
}
