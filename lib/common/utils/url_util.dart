class UrlUtil {
  static Uri isUrlNeedToOveride(Uri url, Uri globalUrl) {
    bool isEligible = url.isAbsolute;
    bool isHaveBaseSection = url.hasAuthority;
    bool isHaveHost = url.host.isNotEmpty;
    bool isNoNeedToOverride = (isEligible && isHaveBaseSection && isHaveHost);

    var result =
        (isNoNeedToOverride) ? url : compilePathToUri(url.path, globalUrl);
    return result;
  }

  static Uri compilePathToUri(String path, Uri url) {
    var baseUrl = url.toString();
    var result = Uri.parse('$baseUrl$path');
    return result;
  }
}
