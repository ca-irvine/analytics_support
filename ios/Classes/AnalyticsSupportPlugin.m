#import "AnalyticsSupportPlugin.h"
#if __has_include(<analytics_support/analytics_support-Swift.h>)
#import <analytics_support/analytics_support-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "analytics_support-Swift.h"
#endif

@implementation AnalyticsSupportPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnalyticsSupportPlugin registerWithRegistrar:registrar];
}
@end
