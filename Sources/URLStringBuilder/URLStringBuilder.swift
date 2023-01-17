//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
// Copyright (c) 2023 Hackenbacker.
//
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

import Foundation

/// Utility to simplify making a URL String with parameters.
public final class URLStringBuilder {

    /// Options for appending operations.
    public enum Options {
        /// Replaces with percent encoded characters.
        case urlEncoding
    }

    private let baseURL: String
    private var urlParameters: [(key: String, value: String)] = []

    /// Initializer.
    /// - Parameter baseURL: a URL based on the builder settings.
    public init(baseURL: String) {
        self.baseURL = baseURL
    }

    /// Adds a new key/value pair into the builder.
    /// - Parameters:
    ///   - key:   The key to append to the URLStringBuilder.
    ///   - value: The value to append to the URLStringBuilder.
    ///   - option: An optional operation to appending the value.
    /// - Returns: URLStringBuilder instance.
    public func append(key: String, value: String, with option: Options? = nil) -> URLStringBuilder {
        appendIf(true, key: key, value: value, with: option)
    }

    /// Adds a new key/value pair into the builder if given condition is true.
    /// - Parameters:
    ///   - condition: Specifying whether given key and value should be append.
    ///   - key:   The key to append to the URLStringBuilder.
    ///   - value: The value to append to the URLStringBuilder.
    ///   - option: An optional operation to appending the value.
    /// - Returns: URLStringBuilder instance.
    public func appendIf(_ condition: Bool, key: String, value: String, with option: Options? = nil) -> URLStringBuilder {
        guard condition else {
            return self
        }

        let encoded: String
        switch option {
        case .urlEncoding:
            encoded = value.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        case .none:
            encoded = value
        }

        urlParameters.append((key: key, value: encoded))

        return self
    }
   
    /// Calls the given closure on each element in the sequence in the same order as a for-in loop.
    /// - Parameters:
    ///   - sequence: Sequence with values.
    ///   - content:  A closure that takes itself and an element of the sequence as a parameter.
    /// - Returns: URLStringBuilder instance.
    public func forEach<T: Sequence>(_ sequence: T, content: (URLStringBuilder, T.Element) -> URLStringBuilder) -> URLStringBuilder {
        var builder = self
        for element in sequence {
            builder = content(builder, element)
        }
        return builder
    }
  
    /// Builds a URL String using the components.
    /// - Returns: A URL built from the components.
    public func build() -> String {
        var built = baseURL
        for (index, element) in urlParameters.enumerated() {
            built += (index == 0) ? "?" : "&"
            built += element.key
            built += "="
            built += element.value
        }
        return built
    }
}
