class ValidationsAll{
  static bool isAlphabet(String input) {

    return !onlyAlpha.hasMatch(input);
  }
  static bool isValidPassword(String input) {
    return !input.contains(" ") && input.length>=6;
  }
  static bool isValidEmail(String value) {
    return emailValidation
        .hasMatch(value);
  }

  static String stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  static final onlyAlpha = RegExp(r'[0-9\s]');
  static final emailValidation = RegExp(r'^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$');
}

