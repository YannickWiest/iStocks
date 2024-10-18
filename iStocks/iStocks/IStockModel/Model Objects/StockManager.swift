//
//  StockManager.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import Foundation
import os

// MARK: StockManager
/// Manages a collection of stocks
@Observable public class StockManager {
    /// List of all loaded stocks
    public var stocks: [Stock]
    public var stockLoader: StockLoader
    
    let logger = Logger()
    
    public init() {
        self.stocks = []
        self.stockLoader = StockLoader()
    }
    
    /// Sets the stored stocks to the parameter
    /// - Parameters:
    ///     - stock: List of stocks
    public func setStocks(stock: [Stock]) {
        stocks = stock
    }

    /// Finds and retrieves a stock from the stored data.
    /// - Parameters:
    ///     - tickerSymbol: Ticker symbol of the stock
    /// - Returns: Stock optional
    public func retrieveStock(tickerSymbol: String) -> Stock? {
        stocks.first { $0.tickerSymbol == tickerSymbol }
    }

    /// Loads a stock using the stock manager
    /// - Parameters:
    ///     - tickerSymbol: Ticker symbol of the stock
    /// - Throws: StockLoaderError
    public func loadStock(tickerSymbol: String) async throws {
        if retrieveStock(tickerSymbol: tickerSymbol) == nil {
            do {
                let stock = try await stockLoader.loadStockFromAPI(ticker: tickerSymbol)
                stocks.append(stock)
                logger.info("Successfully loaded stock for \(tickerSymbol)")
            } catch {
                logger.error("Failed to load stock for \(tickerSymbol): \(error.localizedDescription)")
                throw error
            }
        } else {
            logger.info("Stock already loaded!")
        }
    }

    /// Reloads all stocks by loading the newest data using the stock manager
    public func reloadAllStock() {
        Task {
            var newStocks: [Stock] = []
            for stock in stocks {
                do {
                    let updatedStock = try await stockLoader.loadStockFromAPI(ticker: stock.tickerSymbol)
                    newStocks.append(updatedStock)
                } catch {
                    logger.error("Failed to reload stock for \(stock.tickerSymbol): \(error.localizedDescription)")
                }
            }
            stocks = newStocks
            logger.info("Successfully reloaded all available stocks")
            logger.info("Removed all invalid stocks")
        }
    }

    /// - Returns: Currently stored stocks as list
    public func retrieveAllStocks() -> [Stock] {
        stocks
    }

    /// Deletes the stock associated with the ticker symbol
    /// - Parameters:
    ///     - tickerSymbol: Ticker symbol of the stock
    public func deleteStock(tickerSymbol: String) {
        stocks.removeAll { $0.tickerSymbol == tickerSymbol }
    }
}
