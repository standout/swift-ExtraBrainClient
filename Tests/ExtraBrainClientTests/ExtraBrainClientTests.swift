import XCTest
@testable import ExtraBrainClient

final class ExtraBrainClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ExtraBrainClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
