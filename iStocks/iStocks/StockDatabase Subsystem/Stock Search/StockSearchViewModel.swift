//
//  StockSearchViewModel.swift
//  iStocks
//
//  Created by Yannick Wiest on 14.10.24.
//

import Foundation

// MARK: StockSearchViewModel
/// Provides stock loading logic to the StockSearchView
/// Stores current state of loading process and handles errors
@Observable class StockSearchViewModel {
    var model: Model
    var stockLoadingSuccess = false
    var showFeedback = false

    init(model: Model) {
        self.model = model
    }

    func loadStock(tickerSymbol: String) {
        Task {
            do {
                try await model.loadStock(tickerSymbol: tickerSymbol)
                stockLoadingSuccess = true  // Indicate success
                showFeedback = true
            } catch {
                stockLoadingSuccess = false  // Indicate failure
                showFeedback = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showFeedback = false
            }
        }
    }
}
