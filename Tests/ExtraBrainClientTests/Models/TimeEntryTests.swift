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
    
    func testDecodeSummary() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let summary = try! decoder.decode(TimeEntry.Summary.self, from: Resource(name: "TimeEntries/summary", type: "json").data!)
        
        XCTAssertEqual(summary.duration, TimeInterval(3529123))
        XCTAssertEqual(summary.billablePayPerHour, Money(cents: 268_665_88, currencyIso: "SEK"))
    }

    static var allTests = [
        ("testDecode", testDecode),
    ]
}

