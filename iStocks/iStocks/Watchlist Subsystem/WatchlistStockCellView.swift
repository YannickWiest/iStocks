//
//  StockCellView.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: WatchlistStockCellView
/// Single list cell containing information about a watched stock.
/// Allows to remove stock from watchlist.
struct WatchlistStockCellView: View {
    @Environment(Model.self) private var model: Model
    var stock: Stock

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            VStack(alignment: .leading) {
                Text(stock.companyName)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)

                Text(stock.tickerSymbol)
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            /// Button to remove stock from the watchlist.
            Button(action: {
                model.removeStockFromWatchlist(tickerSymbol: stock.tickerSymbol)
            }, label: {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.yellow)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.bottom)
    }
}

// MARK: WatchlistStockCellView Preview
#Preview {
    guard let stock = MockModel().stockManager.retrieveStock(tickerSymbol: "AAPL") else {
        return EmptyView()
    }
    return WatchlistStockCellView(stock: stock).environment(MockModel() as Model)
}
