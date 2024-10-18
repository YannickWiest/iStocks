//
//  Stock.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import Foundation

// MARK: Stock
/// Represents a single stock.
public struct Stock {
    /// Unique identifier for the stock
    public var tickerSymbol: String
    public var companyName: String
    public var marketCap: Double
    
    /// Price-to-earnings ratio
    public var peRatio: Double
    /// Price history of a stock, sorted from latest to newest.
    public var priceHistory: [Double]
    
    public init(tickerSymbol: String,
                companyName: String,
                marketCap: Double,
                peRatio: Double,
                priceHistory: [Double]) {
        self.tickerSymbol = tickerSymbol
        self.companyName = companyName
        self.marketCap = marketCap
        self.peRatio = peRatio
        self.priceHistory = priceHistory
    }
    
    /// Returns the latest recorded stock price.
    /// - Returns: stock price
    public func getLatestPrice() -> Double {
        priceHistory.last ?? -1
    }
}

@available(iOS 17.0, *)
extension Stock: Identifiable {
    public var id: String {
        return tickerSymbol
    }
}

// MARK: Stock: Hashable
@available(iOS 17.0, *)
extension Stock: Hashable { }

// MARK: Stock: Codable
@available(iOS 17.0, *)
extension Stock: Codable {
    enum CodingKeys: String, CodingKey {
        case tickerSymbol = "symbol"
        case companyName = "name"
        case marketCap
        case peRatio = "pe"
        case priceHistory
    }
}

// MARK: Stock: Comparable
@available(iOS 17.0, *)
extension Stock: Comparable {
    public static func < (lhs: Stock, rhs: Stock) -> Bool {
        lhs.companyName < rhs.companyName
    }
}
