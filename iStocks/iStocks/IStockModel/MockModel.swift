import Foundation
import SwiftUI

// MARK: MockModel
/// A `Model` that replaces the content of the iStocks app with a predefined set of elements every time it is initialized
@available(iOS 17.0, *)
@Observable public class MockModel: Model {
    override public init() {
        super.init()
        self.addStockToWatchlist(tickerSymbol: "AAPL")
        self.addStockToWatchlist(tickerSymbol: "V")
        self.addStockToWatchlist(tickerSymbol: "NVDA")
        self.stockManager.setStocks(stock: [
            Stock(tickerSymbol: "AAPL",
                  companyName: "Apple Inc.",
                  marketCap: 2.5e12, // Example market cap in dollars
                  peRatio: 28.5,     // Example P/E ratio
                  priceHistory: [175.08, 176.00, 175.50, 176.25, 176.75, 177.00, 177.50, 178.00, 178.50]),
            Stock(tickerSymbol: "GOOGL",
                  companyName: "Alphabet Inc.",
                  marketCap: 1.8e12,
                  peRatio: 24.5,
                  priceHistory: [2790.89, 2800.00, 2795.00, 2805.00, 2810.00, 2815.00, 2820.00, 2830.00, 2840.00]),
            Stock(tickerSymbol: "AMZN",
                  companyName: "Amazon.com Inc.",
                  marketCap: 1.4e12,
                  peRatio: 57.0,
                  priceHistory: [143.54, 145.00, 144.50, 145.25, 146.00, 147.00, 148.00, 148.50, 149.00]),
            Stock(tickerSymbol: "TSLA",
                  companyName: "Tesla Inc.",
                  marketCap: 800.0e9,
                  peRatio: 90.0,
                  priceHistory: [249.55, 250.00, 249.75, 250.50, 251.00, 251.50, 252.00, 252.50, 253.00]),
            Stock(tickerSymbol: "NVDA",
                  companyName: "NVIDIA Corporation",
                  marketCap: 1.1e12,
                  peRatio: 90.0,
                  priceHistory: [208.39, 210.00, 209.00, 210.50, 211.00, 211.50, 212.00, 213.00, 214.00])
        ])
    }
}
