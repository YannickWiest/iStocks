//
//  ContentView.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: ContentView
/// The entry-point of the app.
struct ContentView: View {
    @Environment(Model.self) private var model: Model

    var body: some View {
        NavigationView {
            // TabView for the main content
            TabView {
                StockSearchView(viewModel: StockSearchViewModel(model: model))
                    .tabItem {
                        Image(systemName: "arrow.down")
                        Text("Download")
                    }
                StockOverviewView()
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Stocks")
                    }
                WatchlistOverviewView()
                    .tabItem {
                        Image(systemName: "star")
                        Text("Watchlist")
                    }
            }
            .navigationBarTitle("iStocks", displayMode: .inline)
        }
        .environment(model)
    }
}

// MARK: ContentView Preview
#Preview {
    ContentView().environment(MockModel() as Model)
}
