# OpenAsyncImage

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FOpenSwiftUIProject%2FOpenAsyncImage%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAsyncImage) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FOpenSwiftUIProject%2FOpenAsyncImage%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAsyncImage)

A backport implementation of SwiftUI's AsyncImage on Apple platform.

## Overview

OpenAsyncImage provides a drop-in replacement for SwiftUI's `AsyncImage` that works across all supported platforms.

This package's source code is mainly taken from [OpenSwiftUI](https://github.com/OpenSwiftUIProject/OpenSwiftUI).

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenAsyncImage.git", from: "0.1.0")
]

targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "OpenAsyncImageKit", package: "OpenAsyncImage")
        ]
    )
]
```

Or add it directly in Xcode using File → Add Package Dependencies…

## Usage

Simply import `OpenAsyncImageKit` and use it the same way you would use SwiftUI's AsyncImage:

```swift
import SwiftUI
import OpenAsyncImageKit

struct ContentView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://example.com/image.jpg")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "photo")
                    .imageScale(.large)
            }
        }
    }
}
```

## Documentation

Detailed documentation for OpenAsyncImage can be found on [Swift Package Index](https://swiftpackageindex.com/OpenSwiftUIProject/OpenAsyncImage/main/documentation/openasyncimage).

## Advantages

- **iOS 13+ Support**: Brings AsyncImage functionality to earlier iOS versions instead of being limited to iOS 15+
- **Optimized Implementation**: Provides an implementation based on iOS 18.0 with additional State.wrappedValue setter optimization
- **Consistency**: Delivers consistent behavior across all supported platforms
- **Debuggable**: Easy to debug and understand why something might not be working correctly

## Limitations

- **No Future Optimizations**: Cannot automatically inherit future optimizations made to SwiftUI.AsyncImage with OS updates
- **Missing Redaction Support**: `Image.redacted` can not be implemented by the public API of SwiftUI by now, so the placeholder effect in `AsyncImage(url:scale:)` is not fully equivalent to SwiftUI's implementation

## API Reference

OpenAsyncImage provides the same API as SwiftUI's AsyncImage:

```swift
public init(
    url: URL?, 
    scale: CGFloat = 1.0, 
    transaction: Transaction = Transaction(), 
    @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
)

public init<I, P>(
    url: URL?,
    scale: CGFloat = 1,
    @ViewBuilder content: @escaping (Image) -> I,
    @ViewBuilder placeholder: @escaping () -> P
) where Content == _ConditionalContent<I, P>, I: View, P: View {

public init(
    url: URL?, 
    scale: CGFloat = 1
) where Content == Image
```

## Credits

To make AsyncImage available on earlier versions, code from the following libraries was used and modified:

- [SwiftUIBackports](https://github.com/shaps80/SwiftUIBackports)
- [AsyncCompatibilityKit](https://github.com/JohnSundell/AsyncCompatibilityKit)

## Disclaimer

The assets images used in this documentation are from Apple's documentation website and the property belongs to Apple Inc.

## License

OpenAsyncImage is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
