//
//  StockOverviewView.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: StockOverviewView
/// Wraps StocksListView to hide initialisation of the viewModel
struct StockOverviewView: View {
    @Environment(Model.self) private var model: Model

    var body: some View {
        StockListView(viewModel: StockListViewModel(model: model))
    }
}

// MARK: StockOverviewView Preview
#Preview {
    StockOverviewView().environment(MockModel() as Model)
}
