//
//  WatchlistViewModel.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import Foundation
import SwiftUI

// WARNING: UNUSED AND DEPRECATED. SUBJECT TO REMOVAL

// MARK: DeprecatedWatchlistViewModel
@Observable class DeprecatedWatchlistViewModel {
    private var model: Model?
    
    private var watchedStocks: [Stock] = []
    
    init(_ model: Model) {
        self.model = model
        refreshWatchedStocks()
    }
    
    func refreshWatchedStocks() {
        guard let model = model else {
            self.watchedStocks = []
            return
        }
        // Fetch and filter watched stocks
        let allStocks = model.retrieveAllStocks()
        
        watchedStocks = allStocks.filter { stock in
            model.isWatchlisted(tickerSymbol: stock.tickerSymbol)
        }
    }
    
    func isWatched(_ ticker: String) -> Bool {
        guard let model = model else {
            return false
        }
        return model.isWatchlisted(tickerSymbol: ticker)
    }
    
    func addToWatchlist(_ ticker: String) {
        guard let model = model else {
            return
        }
        model.addStockToWatchlist(tickerSymbol: ticker)
        refreshWatchedStocks()
    }
    
    func removeFromWatchlist(_ ticker: String) {
        guard let model = model else {
            return
        }
        model.removeStockFromWatchlist(tickerSymbol: ticker)
        refreshWatchedStocks()
    }
    
    func toggleWatched(_ ticker: String) {
        if isWatched(ticker) {
            removeFromWatchlist(ticker)
        } else {
            addToWatchlist(ticker)
        }
    }
    
    func getWatchedStocks() -> [Stock] {
        return watchedStocks
    }
}
