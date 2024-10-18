//
//  Watchlist.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import Foundation

// MARK: Watchlist
/// Holds a list of tickers that are watchlisted
@Observable public class Watchlist {
    private var tickers: [String]

    public init() {
        tickers = []
    }

    /// Adds a ticker to the watchlist
    /// - Parameters:
    ///     - ticker: Ticker symbol of the stock
    public func addTicker(ticker: String) {
        tickers.append(ticker)
    }

    /// Removes a ticker from the watchlist
    /// - Parameters:
    ///     - ticker: Ticker symbol of the stock
    public func removeTicker(ticker: String) {
        tickers.removeAll(where: { $0 == ticker })
    }

    /// - Returns: List of currently watched tickers
    public func getWatchedTickers() -> [String] {
        return tickers
    }
    
    /// Toggles whether a stock is watched.
    /// - Parameters:
    ///     - tickerSymbol: Ticker symbol of the stock
    public func toggleWatched(tickerSymbol: String) {
        if tickers.contains(tickerSymbol) {
            removeTicker(ticker: tickerSymbol)
        } else {
            addTicker(ticker: tickerSymbol)
        }
    }
}
