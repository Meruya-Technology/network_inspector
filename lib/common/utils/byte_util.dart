class ByteUtil {
  String totalTransferSize(
    int? requestSize,
    int? responseSize,
    bool isRaw,
  ) {
    var reqSize = requestSize ?? 0;
    var resSize = responseSize ?? 0;
    var rawTotalSize = reqSize + resSize;
    var totalSize =
        (!isRaw) ? (rawTotalSize / 1024).toStringAsFixed(2) : rawTotalSize;
    return '$totalSize kb';
  }
}
