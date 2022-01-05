String limitString(String input, int length) {
  return input.toString().length <= length
      ? input
      : input.toString().substring(0, length - 2) + '..';
}
