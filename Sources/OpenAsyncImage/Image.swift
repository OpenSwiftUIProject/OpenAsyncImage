//
//  Image.swift
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
import SwiftUI

extension Image {
    @_silgen_name("OpenAsyncImage_Image_Redacted_ptr")
    private static var redacted_18_ptr: UnsafeRawPointer?

    private static var redacted_18: Image {
        @_silgen_name("OpenAsyncImage_Image_Redacted")
        get
    }

    static var redacted: Image? {
        if redacted_18_ptr != nil {
            redacted_18
        } else {
            nil
        }
    }
}

extension Image.Orientation {
    /// Creates an image orientation from an EXIF orientation value.
    ///
    /// This initializer converts the standard EXIF orientation values (1-8)
    /// to the corresponding `Image.Orientation` cases.
    ///
    /// - Parameter exifValue: An integer representing the EXIF orientation.
    ///   Valid values are 1 through 8, corresponding to the standard EXIF
    ///   orientation values.
    /// - Returns: The corresponding orientation, or `nil` if the provided
    ///   value is not a valid EXIF orientation value.
    package init?(exifValue: Int) {
        switch exifValue {
        case 1: self = .up
        case 2: self = .upMirrored
        case 3: self = .down
        case 4: self = .downMirrored
        case 5: self = .leftMirrored
        case 6: self = .right
        case 7: self = .rightMirrored
        case 8: self = .left
        default: return nil
        }
    }
}
#endif
