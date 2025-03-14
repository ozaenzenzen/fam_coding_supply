extension StringCasingExtension on String {
  /// Contoh `Hello world`
  String get toCapitalizedOnlyFirstChar => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : ''; // 'Hello world'

  /// Contoh `Hello world`
  String get toCapitalized => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : ''; // 'Hello world'

  /// Contoh `Hello World`
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' '); // 'Hello World'

  /// String extension to convert string value from "likeThis" to "Like This"
  String toTitleCaseFromCamelCase() {
    final buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      if (i == 0) {
        buffer.write(this[i].toUpperCase());
      } else if (this[i].toUpperCase() == this[i]) {
        buffer.write(' ${this[i]}');
      } else {
        buffer.write(this[i]);
      }
    }

    return buffer.toString();
  }

  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    // Check if there's a space and split appropriately.
    final parts = split(' ');
    final transformedParts = parts.map((part) {
      if (part.isEmpty) return part;
      return part[0].toUpperCase() + part.substring(1);
    }).toList();
    return transformedParts.join(' ');
  }

  String capitalizeFirstLetterWithoutSpaces() {
    if (isEmpty) return this;
    // For strings like camelCase.
    return this;
  }
}
