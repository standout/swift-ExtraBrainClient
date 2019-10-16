import XCTest
@testable import ExtraBrainClient

final class TaskTests: XCTestCase {
    func testDecode() {
        let json = """
        {"description":null,"charging":"fixed","budget":8500,"total_time":464,"vat_percentage":25.0,"errors":{},"id":25503,"title":"[PROD-455] Growmatcher - Visa sparat state när användaren navigerar mellan vyerna i reg-processen ","task_list_id":3737,"project_id":1393,"project_title":"Growmatcher, poängbaserade ärenden","done":false,"worker_id":212,"customer_id":655,"position":null,"assigned_to_id":212,"priority":2,"assigned_to":{"id":212,"name":"Axel Gustafsson","avatar_color":"#004358","initials":"AG","initials_color":"#ffffff"},"updated_at_in_seconds":1571121575,"deadline":null,"comments":[],"time_entries":[{"id":111944,"started_at":"2019-10-15T08:31:51.456+02:00","day":"2019-10-15","user_id":63,"task_id":25503,"running":false,"charging":"fixed","description":null,"duration":464,"approved":false}],"subscribers":[],"project_subscribers":[],"kind":"task","assigned_to_gravatar":"https://secure.gravatar.com/avatar/e9d251f9c8228f53b6aa0e12a51f271a.png?r=PG","url":"/tasks/25503","estimated_remaining_time":"22m","estimated_time":"30m","customer_name":"Growmatcher AB","list_name":"To Dos","project_charging":"let_children_decide"}
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = try! decoder.decode(Task.self, from: json)
        
        XCTAssertEqual(task.id, 25503)
        XCTAssertEqual(task.title, "[PROD-455] Growmatcher - Visa sparat state när användaren navigerar mellan vyerna i reg-processen ")
        XCTAssertEqual(task.done, false)
        XCTAssertEqual(task.totalTime, 464.0)
    }

    static var allTests = [
        ("testDecode", testDecode),
    ]
}

