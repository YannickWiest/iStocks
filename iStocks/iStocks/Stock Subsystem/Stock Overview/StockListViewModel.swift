//
//  StockListViewModel.swift
//  iStocks
//
//  Created by Yannick Wiest on 10.10.24.
//

import SwiftUI
import Combine

// MARK: StockListViewModel
/// Logic of StockListView. Handles list filter and reloading.
@Observable class StockListViewModel {
    var selectedSortingOption: SortingOption = .marketCap
    var model: Model

    /// Available sortingOptions
    enum SortingOption: String, CaseIterable {
        case price = "Price"
        case marketCap = "Market Cap"
        case peRatio = "P/E Ratio"
    }

    init(model: Model) {
        self.model = model
    }

    /// Contains the stock array sorted based on the selectedSortingOption
    var sortedStocks: [Stock] {
        switch selectedSortingOption {
        case .price:
            return model.retrieveAllStocks().sorted { $0.getLatestPrice() > $1.getLatestPrice() }
        case .marketCap:
            return model.retrieveAllStocks().sorted { $0.marketCap > $1.marketCap }
        case .peRatio:
            return model.retrieveAllStocks().sorted { $0.peRatio < $1.peRatio }
        }
    }
    
    /// Delecates the reload call to the model stock manager
    func reloadAllStocks() {
        model.stockManager.reloadAllStock()
    }
}
