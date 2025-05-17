//
//  URLSession+Async.swift
//  OpenAsyncImage
//
//  Created by Kyle on 2025/5/17.
//

/*
 * MIT License
 *
 * Copyright (c) 2025 Kyle-Ye
*
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#if canImport(OpenSwiftUI) && OPENSWIFTUI
#else

// Modified from https://github.com/JohnSundell/AsyncCompatibilityKit/blob/main/Sources/URLSession%2BAsync.swift

/**
*  AsyncCompatibilityKit
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE.md file for details
*/

import Foundation

@available(iOS, deprecated: 15.0, renamed: "download(from:delegate:)")
@available(macOS, deprecated: 12.0, renamed: "download(from:delegate:)")
@available(tvOS, deprecated: 15.0, renamed: "download(from:delegate:)")
@available(watchOS, deprecated: 8.0, renamed: "download(from:delegate:)")
extension URLSession {
    func backport_download(from url: URL, delegate: (any URLSessionTaskDelegate)? = nil) async throws -> (URL, URLResponse) {
        var dataTask: URLSessionDownloadTask?
        let onCancel: @Sendable ()->Void = { [dataTask] in
            dataTask?.cancel()
        }
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                dataTask = self.downloadTask(with: url) { url, response, error in
                    guard let url = url, let response = response else {
                        let error = error ?? URLError(.badServerResponse)
                        return continuation.resume(throwing: error)
                    }

                    continuation.resume(returning: (url, response))
                }
                dataTask?.resume()
            }
        } onCancel: {
            onCancel()
        }
    }
}
#endif
