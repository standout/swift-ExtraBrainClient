import XCTest
@testable import ExtraBrainClient

final class CustomersControllerTests: XCTestCase {
    func tesCustomersAll_throughClient() throws {
        let expectation = self.expectation(description: "response")

        let session = URLSessionMock()
        session.data = try Resource(name: "Customers/index", type: "json").data
        session.response = HTTPURLResponse(url: URL(string: "https://extrabrain.se/customers")!, mimeType: "application/json", expectedContentLength: -1, textEncodingName: nil)

        let client = ExtraBrainClient(username: "username@example.com", password: "password", session: session)
        var customers: [Customer]!
        client.customers.all {
            customers = try! $0.get()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(customers.first?.id, 1)
        XCTAssertEqual(customers.first?.name, "Company A")
    }
}
