class APIConstants {
  static String numberEndpoint(int number) => 'http://numbersapi.com/$number';
  static String get randomNumberEndpoint => 'http://numbersapi.com/random';
  static String dateEndpoint(int month, int day) =>
      'http://numbersapi.com/$month/$day/date';
  static String get randomDateEndpoint => 'http://numbersapi.com/random/date';

  static Map<String, String> headers = {'Content-Type': 'application/json'};
}
