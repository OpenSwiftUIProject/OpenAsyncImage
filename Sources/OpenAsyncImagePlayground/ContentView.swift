//
//  ContentView.swift
//  OpenAsyncImagePlayground
//
//  Created by Kyle on 2025/5/17.
//

#if canImport(OpenSwiftUI) && OPENSWIFTUI
import OpenSwiftUI
#else
import SwiftUI
#endif
import OpenAsyncImage

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
struct ContentView: View {
    private let url = URL(string: "https://picsum.photos/200")

    var body: some View {
        NavigationStack {
            NavigationLink {
                SwiftUI.AsyncImage(url: url)
            } label: {
                Text("SwiftUI.AsyncImage")
            }
            NavigationLink {
                OpenAsyncImage.AsyncImage(url: url)
            } label: {
                Text("OpenAsyncImage.AsyncImage")
            }
            NavigationLink {
                VStack {
                    SwiftUI.AsyncImage(url: url)
                    OpenAsyncImage.AsyncImage(url: url)
                }
            } label: {
                Text("Compare 2 version of AsyncImage")
            }
        }
    }
}

#if canImport(SwiftUI)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
#Preview {
    ContentView()
}
#endif
