import XCTest
@testable import ExtraBrainClient

final class TimeEntryTests: XCTestCase {
    func testDecode() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let timeEntry = try! decoder.decode(TimeEntry.self, from: Resource(name: "TimeEntries/1", type: "json").data!)
        
        XCTAssertEqual(timeEntry.id, 1)
        XCTAssertEqual(timeEntry.description, "Dashboardappen")
        XCTAssertEqual(timeEntry.duration, TimeInterval(3600))
    }

    static var allTests = [
        ("testDecode", testDecode),
    ]
}

