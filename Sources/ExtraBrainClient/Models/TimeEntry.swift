import Foundation

public struct TimeEntry: Codable, Identifiable {
    public let id: Int?
    public let duration: TimeInterval
    public let description: String
    
    public init(id: Int? = nil, duration: TimeInterval, description: String) {
        self.id = id
        self.duration = duration
        self.description = description
    }
}
