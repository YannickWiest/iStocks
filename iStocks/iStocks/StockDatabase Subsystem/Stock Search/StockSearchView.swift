//
//  StockSearchView.swift
//  iStocks
//
//  Created by Yannick Wiest on 10.10.24.
//

import Foundation
import SwiftUI
import AlertToast  // Creates alerts on the screen

// MARK: StockSearchView
/// Searchbar that allows to search a stock and download it.
struct StockSearchView: View {
    @State private var tickerSymbol: String = ""  // State variable to hold user input
    @Bindable var viewModel: StockSearchViewModel

    var body: some View {
        VStack {
            TextField("Enter ticker symbol", text: $tickerSymbol)  // TextField for input
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button(action: {
                    viewModel.loadStock(tickerSymbol: tickerSymbol)  // Call loadStock on button press
                    tickerSymbol = ""  // Clear input after loading stock
                }) {
                    Text("Add stock to collection")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.showFeedback)  // Disable the button if feedback is being shown
                .padding()
            }
        }
        .padding()
        /// Alert toast created by imported package displayed in the middle of the screen.
        .toast(isPresenting: $viewModel.showFeedback, duration: 2.0, tapToDismiss: true) {  // Alert toast modifier
            AlertToast(type: viewModel.stockLoadingSuccess ? .complete(.green) : .error(Color.red),
                       title: viewModel.stockLoadingSuccess ? "Success" : "No data available")
        }
    }
}

// MARK: StockSearchView Preview
#Preview {
    StockSearchView(viewModel: StockSearchViewModel(model: MockModel()))
}
