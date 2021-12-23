import GoogleTagManager

/// - SeeAlso:
///     - https://developers.google.com/tag-manager/ios/v5/advanced-config
@objc(GoogleCustomTag)
public final class GoogleCustomTag: NSObject, TAGCustomFunction {
    public func execute(withParameters _: [AnyHashable: Any]!) -> NSObject! {
        UInt64(Date().timeIntervalSince1970 * 1000) as NSObject
    }
}
