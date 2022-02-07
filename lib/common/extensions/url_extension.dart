extension UrlExtension on String? {
  bool get isSecure {
    var url = this ?? '';
    return url.contains('https');
  }
}
