import XCTest
@testable import ExtraBrainClient

final class TaskTests: XCTestCase {
    func testDecode() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = try! decoder.decode(Task.self, from: Resource(name: "Tasks/25503", type: "json").data!)
        
        XCTAssertEqual(task.id, 25503)
        XCTAssertEqual(task.title, "[PROD-455] Company A - Visa sparat state när användaren navigerar mellan vyerna i reg-processen ")
        XCTAssertEqual(task.done, false)
        XCTAssertEqual(task.totalTime, 464.0)
    }

    static var allTests = [
        ("testDecode", testDecode),
    ]
}

