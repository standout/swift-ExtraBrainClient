import Foundation

public struct Customer: Decodable, Identifiable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
