String getSession() {
  final DateTime now = DateTime.now();
  final int hour = now.hour;
  if (hour <= 4) {
    return "buổi tối";
  }
  if (hour < 11) {
    return "buổi sáng";
  } else if (hour < 14) {
    return "buổi trưa";
  } else if (hour < 18)
    return "buổi chiều";
  else
    return "buổi tối";
}
