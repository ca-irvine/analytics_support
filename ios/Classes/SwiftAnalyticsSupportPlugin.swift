import Flutter
import GoogleAnalytics
import UIKit

public class SwiftAnalyticsSupportPlugin: NSObject, FlutterPlugin {
    enum TrackerMethod: String {
        case getGoogleClientId
        case showConsoleLog
    }

    enum Channel: String {
        case tracker

        func valueWith(name: String) -> String {
            "\(name)/\(rawValue)"
        }
    }

    static let channelName = "com.cairvine.analytics_support"

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: Channel.tracker.valueWith(name: SwiftAnalyticsSupportPlugin.channelName),
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftAnalyticsSupportPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == TrackerMethod.getGoogleClientId.rawValue, let trackingId = call.arguments as? String {
            result(trackingId.isEmpty ? nil : GAI.sharedInstance().tracker(withTrackingId: trackingId).get(kGAIClientId))
        } else if call.method == TrackerMethod.showConsoleLog.rawValue, let show = call.arguments as? NSNumber {
            TAGLoggerSupport.consoleLogIsShow(Bool(truncating: show))
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
