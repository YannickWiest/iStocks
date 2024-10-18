//
//  StockCellView.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: StockCellView
// A list cell representing a single `Stock`
struct StockCellView: View {
    var stock: Stock

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 50)
                AsyncImage(url: URL(string: "https://financialmodelingprep.com/image-stock/\(stock.tickerSymbol).png")) { image in
                    image
                        .resizable()
                        .scaledToFill() // Ensures the image fills the circle
                        .clipShape(Circle()) // Clips the image to a circle shape
                        .frame(width: 40, height: 40) // Set the frame to match the circle size
                } placeholder: {
                }
            }
            .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(stock.companyName)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text(stock.tickerSymbol)
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            let latestPrice = stock.getLatestPrice()
            Text(String(format: "$%.2f", latestPrice))
                .font(.system(size: 18))
                .foregroundStyle(.primary)
        }
    }
}

// MARK: StockCellView Preview
#Preview {
    guard let stock = MockModel().stockManager.retrieveStock(tickerSymbol: "AAPL") else {
        return EmptyView()
    }
    return StockCellView(stock: stock)
}
