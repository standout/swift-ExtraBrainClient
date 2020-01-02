import EasyMode
import Foundation

extension ExtraBrainClient {
    @available(*, deprecated, renamed: "TimeEntriesController")
    public typealias TimeEntries = TimeEntriesController

    public struct TimeEntriesController {
        let client: ExtraBrainClient

        struct TimeEntryRequestWrapper: Encodable {
            let timeEntry: TimeEntry
        }

        public func create(_ timeEntry: TimeEntry, completion: @escaping ExtraBrainClientResultCompletion<TimeEntry>) {
            let coder = JSONEncoder()
            coder.keyEncodingStrategy = .convertToSnakeCase

            let requestWrapper = TimeEntryRequestWrapper(timeEntry: timeEntry)

            let data = try! coder.encode(requestWrapper)

            client.post(path: "/time_entries", data: data) {
                Responder<TimeEntry>().respond($0, completion: completion)
            }
        }

        public func summary(fromDay: Date? = nil,
                            toDay: Date? = nil,
                            taskIds: [Int]? = nil,
                            userIds: [Int]? = nil,
                            completion: @escaping ExtraBrainClientResultCompletion<TimeEntry.Summary>) {
            var query = [URLQueryItem]()

            if let fromDay = fromDay {
                query.append(URLQueryItem(name: "from_day", value: fromDay.isoDate))
            }

            if let toDay = toDay {
                query.append(URLQueryItem(name: "to_day", value: toDay.isoDate))
            }

            if let taskIds = taskIds {
                for taskId in taskIds {
                    query.append(URLQueryItem(name: "task_ids[]",
                                              value: taskId.description))
                }
            }

            if let userIds = userIds {
                for userId in userIds {
                    query.append(URLQueryItem(name: "user_ids[]",
                                              value: userId.description))
                }
            }

            client.get(path: "/time_entries/summary", query: query) {
                Responder<TimeEntry.Summary>().respond($0, completion: completion)
            }
        }
    }
}
