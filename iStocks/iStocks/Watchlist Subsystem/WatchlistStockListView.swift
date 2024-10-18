import SwiftUI

// MARK: WatchlistStockListView
/// List of all watched stocks currently stored in the database.
/// Ignores watched tickers for which no data is available.
struct WatchlistStockListView: View {
    @Environment(Model.self) private var model: Model

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("Watchlist")
                /// Import custom font for view title
                    .font(.custom("Sacramento-Regular", size: 42))
                    .fontWeight(.bold)
                    .padding(.bottom, 1)
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        let watchedStocks = model.getWatchedStocks()
                        if !watchedStocks.isEmpty {
                            ForEach(watchedStocks, id: \.self) { stock in
                                NavigationLink(destination: StockDetailView(stock: stock)) {
                                    WatchlistStockCellView(stock: stock)
                                        .foregroundColor(.primary)
                                }
                            }
                        } else {
                            Text("No stocks are watchlisted.")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

// MARK: WatchlistStockListView Preview
#Preview {
    return WatchlistStockListView()
        .environment(MockModel() as Model)
}
