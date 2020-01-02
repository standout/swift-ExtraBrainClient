@testable import ExtraBrainClient
import XCTest

final class ApprovedDaysControllerTests: XCTestCase {
    func testApprovedDaysAll_throughClient() throws {
        let expectation = self.expectation(description: "response")

        let session = URLSessionMock()
        session.data = try Resource(name: "ApprovedDays/index", type: "json").data
        session.response = HTTPURLResponse(url: URL(string: "https://extrabrain.se/approved_days")!, mimeType: "application/json", expectedContentLength: -1, textEncodingName: nil)

        let client = ExtraBrainClient(username: "username@example.com", password: "password", session: session)
        var approvedDays: [ApprovedDay]!
        client.approvedDays.all {
            approvedDays = try! $0.get()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(approvedDays.first?.id, 1)
        XCTAssertEqual(approvedDays.first?.day, Date.from(year: 2019, month: 12, day: 27))
    }
}
