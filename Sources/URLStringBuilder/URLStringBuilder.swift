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

    /// Adds a new key/value pair to the URL string.
    /// - Parameters:
    ///   - key:   The key to append to the URL string.
    ///   - value: The value to append to the URL string.
    ///   - option: An optional operation to appending the value.
    /// - Returns: URLStringBuilder instance.
    public func append(key: String, value: any LosslessStringConvertible,
                       with option: Options? = nil) -> URLStringBuilder {
        appendIf(true, key: key, value: value, with: option)
    }

    /// Adds a new key/value pair to the URL string if given condition is true.
    /// - Parameters:
    ///   - condition: Specifying whether given key and value should be append.
    ///   - key:   The key to append to the URL string.
    ///   - value: The value to append to the URL string.
    ///   - option: An optional operation to appending the value.
    /// - Returns: URLStringBuilder instance.
    public func appendIf(_ condition: Bool,
                         key: String, value: any LosslessStringConvertible,
                         with option: Options? = nil) -> URLStringBuilder {
        guard condition else {
            return self
        }

        urlParameters.append((key: key, value: convert(value, with: option)))

        return self
    }
    
    /// Converts a given value to String.
    /// - Parameters:
    ///   - value:  The value to convert to String.
    ///   - option: An optional operation to appending the value.
    /// - Returns: A converted String.
    private func convert(_ value: LosslessStringConvertible, with option: Options?) -> String {
        switch value {
        case let string as String:
            switch option {
            case .urlEncoding:
                return string.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            case .none:
                return string
            }
        default:
            return String(value)
        }
    }
    
    /// Calls the given closure on each element in the sequence in the same order as a for-in loop.
    /// - Parameters:
    ///   - sequence: Sequence with values.
    ///   - content:  A closure that takes itself and an element of the sequence as a parameter.
    /// - Returns: URLStringBuilder instance.
    public func forEach<T: Sequence>(_ sequence: T,
                                     content: (URLStringBuilder, T.Element) -> URLStringBuilder
                                    ) -> URLStringBuilder {
        var builder = self
        sequence.forEach { element in
            builder = content(builder, element)
        }
        return builder
    }

    /// Adds new key/value pairs to the URL string.
    /// - Parameters:
    ///   - key:    The key to append to the URL string.
    ///   - values: The values to append to the URL string.
    ///   - option: An optional operation to appending the value.
    /// - Returns: URLStringBuilder instance.
    public func append<E: LosslessStringConvertible>(key: String, values: any Sequence<E>,
                       with option: Options? = nil) -> URLStringBuilder {
        var builder = self
        values.forEach { value in
            builder = appendIf(true, key: key, value: value, with: option)
        }
        return builder
    }

    /// Builds a URL String using the components.
    /// - Returns: A URL built from the components.
    public func build() -> String {
        var built = baseURL
        urlParameters.enumerated().forEach { index, element in
            built += (index == 0) ? "?" : "&"
            built += element.key
            built += "="
            built += element.value
        }
        return built
    }
}
