//
//  Model.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import Foundation
import Combine

// MARK: Model
/// The model of the iStocks App
@Observable public class Model {
    public var stockManager: StockManager
    public var watchlist: Watchlist

    public init() {
        self.stockManager = StockManager()
        self.watchlist = Watchlist()
    }

    /// Loads stock information from an API for the specified ticker symbol.
    /// - Parameter tickerSymbol: The ticker symbol of the stock to load.
    /// - Throws: An error if the stock could not be loaded.
    public func loadStock(tickerSymbol: String) async throws {
        try await stockManager.loadStock(tickerSymbol: tickerSymbol)
    }
    
    /// Retrieves all stocks currently managed by the `StockManager`.
    /// - Returns: An array of `Stock` objects.
    public func retrieveAllStocks() -> [Stock] {
        stockManager.retrieveAllStocks()
    }

    /// Checks if a stock is in the watchlist.
    /// - Parameter tickerSymbol: The ticker symbol of the stock to check.
    /// - Returns: A Boolean value indicating whether the stock is in the watchlist.
    public func isWatchlisted(tickerSymbol: String) -> Bool {
        return watchlist.getWatchedTickers().contains(tickerSymbol)
    }

    /// Adds a stock to the watchlist.
    /// - Parameter tickerSymbol: The ticker symbol of the stock to add to the watchlist.
    public func addStockToWatchlist(tickerSymbol: String) {
        watchlist.addTicker(ticker: tickerSymbol)
    }
    
    /// Removes a stock from the watchlist.
    /// - Parameter tickerSymbol: The ticker symbol of the stock to remove from the watchlist.
    public func removeStockFromWatchlist(tickerSymbol: String) {
        watchlist.removeTicker(ticker: tickerSymbol)
    }
    
    /// Retrieves the current watchlist.
    /// - Returns: The current `Watchlist` object.
    public func getWatchlist() -> Watchlist {
        watchlist
    }

    /// Deletes a stock from the manager by its ticker symbol.
    /// - Parameter tickerSymbol: The ticker symbol of the stock to delete.
    public func deleteStock(tickerSymbol: String) {
        stockManager.deleteStock(tickerSymbol: tickerSymbol)
    }
    
    /// Retrieves all stocks that are currently watched based on the watchlist.
    /// - Returns: An array of `Stock` objects that are in the watchlist.
    public func getWatchedStocks() -> [Stock] {
        let watchedTickers = watchlist.getWatchedTickers()
        return stockManager.retrieveAllStocks().filter { watchedTickers.contains($0.tickerSymbol) }
    }
    
    /// Toggles the watched state of a stock.
    /// - Parameter tickerSymbol: The ticker symbol of the stock to toggle.
    public func toggleWatched(tickerSymbol: String) {
        watchlist.toggleWatched(tickerSymbol: tickerSymbol)
    }
}
