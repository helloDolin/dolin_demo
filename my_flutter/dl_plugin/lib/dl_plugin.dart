import 'dart:async';

import 'package:flutter/services.dart';

class DlPlugin {
  static const MethodChannel _channel =
      const MethodChannel('dolin.com/dl_plugin');

  static Future<bool> get dismissCurrentVC async {
    final bool isSuccess = await _channel.invokeMethod('dismiss_current_vc');
    return isSuccess;
  }
}
