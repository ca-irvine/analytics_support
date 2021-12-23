final class TAGLoggerSupport {
    @objc private static func info(_: String) {}

    private static var isExchanged = false
    private static var isAdded = false

    /// - SeeAlso: https://stackoverflow.com/questions/45347538/how-to-disable-google-tag-manager-console-logging
    static func consoleLogIsShow(_ isShow: Bool) {
        let selector = NSSelectorFromString("info:")
        let TAGLogger: AnyClass? = NSClassFromString("TAGLogger")
        let tagLoggerInfoMethod = class_getClassMethod(TAGLogger, selector)
        let destroyerInfoMethod = class_getClassMethod(TAGLoggerSupport.self, selector)

        if !isAdded, let detourMethod = destroyerInfoMethod {
            isAdded = class_addMethod(
                TAGLogger, selector,
                method_getImplementation(detourMethod),
                method_getTypeEncoding(detourMethod)
            )
        }

        if isExchanged == isShow, let originalMethod = tagLoggerInfoMethod, let detourMethod = destroyerInfoMethod {
            isExchanged.toggle()
            method_exchangeImplementations(originalMethod, detourMethod)
        }
    }
}
