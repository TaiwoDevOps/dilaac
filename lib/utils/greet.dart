String get greet {
  int timeOfDay = DateTime.now().hour;

  if (timeOfDay >= 0 && timeOfDay < 12) {
    return "Good Morning 🌤";
  } else if (timeOfDay >= 12 && timeOfDay < 16) {
    return "Good Afternoon ☀";
  } else if (timeOfDay >= 16 && timeOfDay < 21) {
    return "Good Evening ✨";
  } else if (timeOfDay >= 21 && timeOfDay < 24) {
    return "Good Evening 🌙";
  }
  return "Good Day";
}
