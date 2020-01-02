import Foundation

public struct ApprovedDay: Decodable, Identifiable {
    public enum Status: String {
        case waitingForApproval = "waiting_for_approval"
        case unknown
    }

    public let id: Int
    public let day: Date
    public let userId: Int
    public let status: Status

    public init(id: Int, day: Date, userId: Int, status: Status) {
        self.id = id
        self.day = day
        self.userId = userId
        self.status = status
    }

    enum CodingKeys: String, CodingKey {
        case id
        case day
        case userId
        case status
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)

        let stringDate = try container.decode(String.self, forKey: .day)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        day = Calendar.current.startOfDay(for: formatter.date(from: stringDate)!)

        userId = try container.decode(Int.self, forKey: .userId)

        if let status = Status(rawValue: try container.decode(String.self, forKey: .status)) {
            self.status = status
        } else {
            status = Status.unknown
        }
    }
}
