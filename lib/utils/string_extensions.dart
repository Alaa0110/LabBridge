/*extension ArabicSort on String {
  /// Compares two strings according to the Arabic alphabet
  int compareToArabic(String other) {
    // Arabic alphabet in proper order
    const arabicAlphabet = "اأإبتثجحخدذرزسشصضطظعغفقكلمنهوي";
    // Map strings to their alphabetical indices
    final thisIndex = this
        .toLowerCase()
        .split("")
        .map((char) => arabicAlphabet.indexOf(char))
        .join();
    final otherIndex = other
        .toLowerCase()
        .split("")
        .map((char) => arabicAlphabet.indexOf(char))
        .join();
    return thisIndex.compareTo(otherIndex);
  }
}*/
