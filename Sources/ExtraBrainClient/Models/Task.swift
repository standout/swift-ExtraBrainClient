import Foundation

public struct Task: Decodable, Identifiable {
    public let id: Int
    public let title: String
    public let done: Bool
    public let totalTime: TimeInterval
}
