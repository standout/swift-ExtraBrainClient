import Foundation

public struct Money: Decodable, Equatable {
    public let cents: Int
    public let currencyIso: String
    
    public var amount: Double {
        Double(cents) / 100
    }
}
