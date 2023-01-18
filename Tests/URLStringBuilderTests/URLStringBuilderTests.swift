import XCTest
@testable import URLStringBuilder

final class URLStringBuilderTests: XCTestCase {
    
    /// Test to build without parameters.
    /// パラメーター無しでビルドするテスト.
    func testInitializeAndBuild() throws {
        
        let baseURL = "https://github.com/hackenbacker/URLStringBuilder"
        
        let urlString = URLStringBuilder(baseURL: baseURL)
            .build()
        
        XCTAssertEqual(urlString, baseURL,
                       "The result of build() is different from the original URL.")
        // build()の結果が元のURLと異なる。
    }
    
    /// Test appen()
    /// append()のテスト
    func testAppend() throws {
        
        let baseURL = "https://github.com/hackenbacker"
        
        let urlString = URLStringBuilder(baseURL: baseURL)
            .append(key: "type", value: "source")
            .append(key: "type", value: "target")
            .append(key: "Int",  value: 5)
            .build()
        
        XCTAssertEqual(urlString, "\(baseURL)?type=source&type=target&Int=5",
                       "append() is not executed as expected.")
        // append()が期待通りに実行されていない。
    }
    
    /// Test appenIf()
    /// appendIf()のテスト
    func testAppendIf() throws {
        
        let baseURL = "https://github.com/hackenbacker"
        let condition = true
        
        let urlString = URLStringBuilder(baseURL: baseURL)
            .appendIf(condition,  key: "type", value: "true")
            .appendIf(!condition, key: "type", value: "false")
            .appendIf(condition,  key: "text", value: "This is it?", with: .urlEncoding)
            .build()
        
        XCTAssertEqual(urlString, "\(baseURL)?type=true&text=This%20is%20it%3F",
                       "appendIf() is not executed as expected.")
        // appendIf()が期待通りに実行されていない。
    }
    
    /// Test forEach()
    /// forEach()のテスト
    func testForEach() throws {
        
        let baseURL = "https://github.com/hackenbacker"
        let list: [(key: String, value: String)] = [
            (key: "source", value: "EN"),
            (key: "target", value: "JA")
        ]

        let urlString = URLStringBuilder(baseURL: baseURL)
            .forEach(list) {
                $0.append(key: $1.key, value: $1.value)
            }
            .build()

        XCTAssertEqual(urlString, "\(baseURL)?source=EN&target=JA",
                       "forEach() is not executed as expected.")
                        // forEach()が期待通りに実行されていない。
    }

    /// Test to append Sequence.
    /// Sequenceをappendするテスト
    func testAppendSequence() throws {
        
        let baseURL = "https://github.com/hackenbacker"
        let list: [String] = ["source", "target"]

        let urlString = URLStringBuilder(baseURL: baseURL)
            .append(key: "text", values: list)
            .build()

        XCTAssertEqual(urlString, "\(baseURL)?text=source&text=target",
                       "append(key:values:) is not executed as expected.")
                        // append(key:values:)が期待通りに実行されていない。
    }
    
    /// Cases where percent encoding fails.
    /// パーセントエンコーディングに失敗するケース。
    func testFailedPercentEncoding() throws {

        let baseURL = "https://github.com/hackenbacker"
        let invalid = String(bytes: [0xD8, 0x40], encoding: .utf16BigEndian)!
        
        let urlString = URLStringBuilder(baseURL: baseURL)
            .append(key: "text", value: invalid, with: .urlEncoding)
            .build()
        
        XCTAssertEqual(urlString, "\(baseURL)?text=",
                       "percent encoding didn't occur an error.")
                        // パーセントエンコーディングがエラーを発生しない。
    }
}
