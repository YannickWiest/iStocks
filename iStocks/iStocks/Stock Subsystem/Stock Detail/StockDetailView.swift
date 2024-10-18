//
//  StockDetailView.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: StockDetailView
/// A view containing a graph and a table filled with stock data for a specific stock
struct StockDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Model.self) private var model: Model
    
    let stock: Stock

    var body: some View {
        VStack(alignment: .leading) {
            // Header with company name and star for favoriting
            HStack {
                VStack(alignment: .leading) {
                    Text(stock.companyName)
                        .font(.title)
                        .bold()
                    Text("Ticker: \(stock.tickerSymbol)")
                        .font(.subheadline)
                }
            
                Spacer()

                Button(action: {
                    model.toggleWatched(tickerSymbol: stock.tickerSymbol)
                }, label: {
                    Image(systemName: model.isWatchlisted(tickerSymbol: stock.tickerSymbol) ? "star.fill" : "star")
                        .foregroundColor(model.isWatchlisted(tickerSymbol: stock.tickerSymbol) ? .yellow : .gray)
                        .font(.title)
                })
            }
            
            // PriceGraphView with price history of the stock
            PriceGraphView(prices: stock.priceHistory)
                
            // Latest stock information in a table
            StockDataTableView(stock: stock)

            Spacer()
        }
        .padding()
    }
}

// MARK: StockDetailView Preview
#Preview {
    guard let stock = MockModel().stockManager.retrieveStock(tickerSymbol: "AAPL") else {
        return EmptyView()
    }
    return StockDetailView(stock: stock).environment(MockModel() as Model)
}
