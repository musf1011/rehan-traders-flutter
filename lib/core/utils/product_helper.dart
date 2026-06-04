class ProductHelper {
  static List<String> generateSearchKeywords(String text) {
    final words = text.toLowerCase().split(' ');

    final keywords = <String>{};

    for (var word in words) {
      for (int i = 1; i <= word.length; i++) {
        keywords.add(word.substring(0, i));
      }
    }

    keywords.add(text.toLowerCase());

    return keywords.toList();
  }

  static String generateProductId(String name) {
    final cleaned = name.toLowerCase().replaceAll(' ', '-');

    final unique = DateTime.now().millisecondsSinceEpoch.toString().substring(
      7,
    );

    return '$cleaned-$unique';
  }
}
