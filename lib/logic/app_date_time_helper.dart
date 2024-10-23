class AppDateTimeHelper {
  static String processDateTime(String responseBody) {
    // Find the position of the '+' character
    int plusIndex = responseBody.indexOf('+');

    if (plusIndex != -1) {
      // Remove characters after the '+' character
      String cleanedResponse = responseBody.substring(0, plusIndex);

      // print("Original Response Body: $responseBody");
      // print("Cleaned Response Body: $cleanedResponse");
      return cleanedResponse;
    } else {
      // print("No '+' character found in the response body.");
      return DateTime.now().toIso8601String();
    }
  }
}
