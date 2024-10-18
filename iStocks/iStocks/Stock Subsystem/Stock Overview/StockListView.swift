//
//  StockCellView.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

// MARK: StockListView
// A list containing all stocks loaded in the stock manager
struct StockListView: View {
    @Environment(Model.self) private var model: Model
    @Bindable var viewModel: StockListViewModel

    init(viewModel: StockListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Stocks")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Button(action: {
                        viewModel.reloadAllStocks()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                    }
                    Spacer()
                    
                    /// List sorting options providied by the StockListViewModel
                    Picker("Sort by", selection: $viewModel.selectedSortingOption) {
                        ForEach(StockListViewModel.SortingOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .fixedSize()
                }
                .padding(.bottom)
                
                List {
                    ForEach(viewModel.sortedStocks, id: \.self) { stock in
                        NavigationLink(destination: StockDetailView(stock: stock)) {
                            StockCellView(stock: stock)
                                .foregroundColor(.primary)
                        }
                    }
                    .onDelete(perform: deleteStocks)
                }
                .listStyle(PlainListStyle())
            }
            .padding(.top)
        }
    }
    
    /// Helper function for swiping gesture that deletes the stock
    /// - Parameters:
    ///     - offsets: Index of the swiped cell
    private func deleteStocks(at offsets: IndexSet) {
        for index in offsets {
            let stock = viewModel.sortedStocks[index]
            model.deleteStock(tickerSymbol: stock.tickerSymbol)
        }
    }
}

// MARK: StockListView Preview
#Preview {
    let mockModel = MockModel() as Model
    let viewModel = StockListViewModel(model: mockModel)
    return StockListView(viewModel: viewModel).environment(mockModel)
}
