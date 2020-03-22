#import "DlPlugin.h"

@implementation DlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"dolin.com/dl_plugin"
            binaryMessenger:[registrar messenger]];
  DlPlugin* instance = [[DlPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"dismiss_current_vc" isEqualToString:call.method]) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss_current_vc" object:nil];
    result(@(YES));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
