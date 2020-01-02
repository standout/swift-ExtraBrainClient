import EasyMode
@testable import ExtraBrainClient
import XCTest

final class ApprovedDayTests: XCTestCase {
    func testDecode() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let approvedDays = try! decoder.decode([ApprovedDay].self, from: Resource(name: "ApprovedDays/index", type: "json").data!)

        XCTAssertEqual(approvedDays.first?.id, 1)
        XCTAssertEqual(approvedDays.first?.day, Date.from(year: 2019, month: 12, day: 27))
        XCTAssertEqual(approvedDays.first?.userId, 1)
        XCTAssertEqual(approvedDays.first?.status, ApprovedDay.Status.waitingForApproval)
    }

    func testInitWithValues() {
        let approvedDay = ApprovedDay(id: 10, day: Date.from(year: 2019, month: 1, day: 1), userId: 2, status: .waitingForApproval)

        XCTAssertEqual(approvedDay.id, 10)
        XCTAssertEqual(approvedDay.day, Date.from(year: 2019, month: 01, day: 01))
        XCTAssertEqual(approvedDay.userId, 2)
        XCTAssertEqual(approvedDay.status, .waitingForApproval)
    }

    static var allTests = [
        ("testDecode", testDecode),
        ("testInitWithValues", testInitWithValues),
    ]
}
