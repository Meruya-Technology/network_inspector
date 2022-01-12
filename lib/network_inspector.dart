library network_inspector;

/// Export section
export 'network_inspector_common.dart';
export 'network_inspector_infrastructure.dart';
export 'network_inspector_presentation.dart';

/// Import section
import 'network_inspector_common.dart';

/// Core class section
class NetworkInspector {
  static Future<void> initialize() async {
    await DatabaseHelper.initialize();
  }
}
