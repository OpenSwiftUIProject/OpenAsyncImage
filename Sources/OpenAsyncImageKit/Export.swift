//
//  Export.swift
//  OpenAsyncImageKit
//
//  Created by Kyle on 2025/5/17.
//

#if canImport(OpenSwiftUI) && OPENSWIFTUI
import OpenSwiftUI
#else
import SwiftUI
import OpenAsyncImage
@_exported import struct OpenAsyncImage.AsyncImage
#endif
