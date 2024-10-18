//
//  StockDataTableVIew.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: StockDataTableView
/// A table containing the most important stock data
struct StockDataTableView: View {
    let stock: Stock

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Latest Price:")
                Spacer()
                Text(stock.getLatestPrice().formatted(.currency(code: "USD")))
            }
            HStack {
                Text("Market Cap:")
                Spacer()
                Text(NumberFormatter.formatMarketCap(stock.marketCap))
            }
            HStack {
                Text("P/E Ratio:")
                Spacer()
                Text(String(format: "%.2f", stock.peRatio))
            }
        }
        .font(.body)
        .padding(.vertical)
    }
}

// MARK: StockDataTableView Preview
#Preview {
    guard let stock = MockModel().stockManager.retrieveStock(tickerSymbol: "AAPL") else {
        return EmptyView()
    }
    return StockDataTableView(stock: stock)
}
