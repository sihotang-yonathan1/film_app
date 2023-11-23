import 'package:flutter/services.dart' show rootBundle;

Future<String> getConfig() {
  return rootBundle.loadString('app_config/config.json');
}
