//
//  Logging.swift
//  Modified from https://github.com/OpenSwiftUIProject/OpenSwiftUI/blob/main/Sources/OpenSwiftUICore/Log/Logging.swift
//  Kyle-Ye MIT License

import Foundation
public import os.log

#if DEBUG
package let dso = { () -> UnsafeMutableRawPointer in
    let count = _dyld_image_count()
    for i in 0 ..< count {
        if let name = _dyld_get_image_name(i) {
            let swiftString = String(cString: name)
            if swiftString.hasSuffix("/SwiftUI") {
                if let header = _dyld_get_image_header(i) {
                    return UnsafeMutableRawPointer(mutating: UnsafeRawPointer(header))
                }
            }
        }
    }
    return UnsafeMutableRawPointer(mutating: #dsohandle)
}()
#endif

@usableFromInline
package enum Log {
    @usableFromInline
    package static var runtimeIssuesLog: OSLog = OSLog(subsystem: "com.apple.runtime-issues", category: "OpenAsyncImage")

    @_transparent
    package static func runtimeIssues(
        _ message: @autoclosure () -> StaticString,
        _ args: @autoclosure () -> [CVarArg] = []
    ) {
        #if DEBUG
        unsafeBitCast(
            os_log as (OSLogType, UnsafeRawPointer, OSLog, StaticString, CVarArg...) -> Void,
            to: ((OSLogType, UnsafeRawPointer, OSLog, StaticString, [CVarArg]) -> Void).self
        )(.fault, dso, runtimeIssuesLog, message(), args())
        #else
        os_log(.fault, log: runtimeIssuesLog, message(), args())
        #endif
    }
}
