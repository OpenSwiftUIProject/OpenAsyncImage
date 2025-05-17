//
//  onChange+Backport.swift
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

// Modified from https://github.com/shaps80/SwiftUIBackports/blob/main/Sources/SwiftUIBackports/Shared/OnChange/OnChange.swift

/*
 * MIT License
 *
 * Copyright (c) 2021 Shaps Benkau
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 *The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
import SwiftUI
import Combine

@available(iOS, deprecated: 17.0, renamed: "onChange(of:initial:_:)")
@available(macOS, deprecated: 14.0, renamed: "onChange(of:initial:_:)")
@available(tvOS, deprecated: 17.0, renamed: "onChange(of:initial:_:)")
@available(watchOS, deprecated: 10.0, renamed: "onChange(of:initial:_:)")
extension View {
    /// Adds a modifier for this view that fires an action when a specific
    /// value changes.
    ///
    /// You can use `onChange` to trigger a side effect as the result of a
    /// value changing, such as an `Environment` key or a `Binding`.
    ///
    /// The system may call the action closure on the main actor, so avoid
    /// long-running tasks in the closure. If you need to perform such tasks,
    /// detach an asynchronous background task.
    ///
    /// When the value changes, the new version of the closure will be called,
    /// so any captured values will have their values from the time that the
    /// observed value has its new value. The old and new observed values are
    /// passed into the closure. In the following code example, `PlayerView`
    /// passes both the old and new values to the model.
    ///
    ///     struct PlayerView: View {
    ///         var episode: Episode
    ///         @State private var playState: PlayState = .paused
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 Text(episode.title)
    ///                 Text(episode.showTitle)
    ///                 PlayButton(playState: $playState)
    ///             }
    ///             .onChange(of: playState) { oldState, newState in
    ///                 model.playStateDidChange(from: oldState, to: newState)
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - value: The value to check against when determining whether
    ///     to run the closure.
    ///   - initial: Whether the action should be run when this view initially
    ///     appears.
    ///   - action: A closure to run when the value changes.
    ///   - oldValue: The old value that failed the comparison check (or the
    ///     initial value when requested).
    ///   - newValue: The new value that failed the comparison check.
    ///
    /// - Returns: A view that fires an action when the specified value changes.
    @ViewBuilder
    func backport_onChange<V>(of value: V, initial: Bool = false, _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void) -> some View where V: Equatable {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            onChange(of: value, initial: initial, action)
        } else {
            modifier(ChangeModifier(value: value, initial: initial, action: action))
        }
    }
}

private struct ChangeModifier<Value: Equatable>: ViewModifier {
    let value: Value
    let initial: Bool
    let action: (Value, Value) -> Void

    @State var oldValue: Value

    init(value: Value, initial: Bool, action: @escaping (Value, Value) -> Void) {
        self.value = value
        self.initial = initial
        self.action = action
        _oldValue = .init(initialValue: value)
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                if initial {
                    action(value, value)
                }
            }
            .onReceive(Just(value)) { newValue in
                guard newValue != oldValue else { return }
                action(oldValue, newValue)
                oldValue = newValue
            }
    }
}
#endif
