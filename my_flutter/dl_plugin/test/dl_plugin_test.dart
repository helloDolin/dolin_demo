import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dl_plugin/dl_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('dl_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DlPlugin.platformVersion, '42');
  });
}
