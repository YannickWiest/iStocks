//
//  WatchlistOverviewView.swift
//  iStocks
//
//  Created by Yannick Wiest on 10.10.24.
//

import SwiftUI

// MARK: WatchlistOverviewView
/// Wrapper for WatchlistStockListView
/// Could initialise viewModel if nescessary
struct WatchlistOverviewView: View {
    @Environment(Model.self) private var model: Model
    
    var body: some View {
        WatchlistStockListView()
    }
}

// MARK: WatchlistOverviewView Preview
#Preview {
    WatchlistOverviewView().environment(MockModel() as Model)
}
