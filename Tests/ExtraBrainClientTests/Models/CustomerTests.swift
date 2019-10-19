import XCTest
@testable import ExtraBrainClient

final class CustomerTests: XCTestCase {
    func testDecode() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let customer = try! decoder.decode(Customer.self, from: Resource(name: "Customers/1", type: "json").data!)
        
        XCTAssertEqual(customer.id, 1)
        XCTAssertEqual(customer.name, "Company A")
    }

    static var allTests = [
        ("testDecode", testDecode),
    ]
}

