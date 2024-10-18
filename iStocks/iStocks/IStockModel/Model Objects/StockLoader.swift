//
//  StockLoader.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import Foundation

// MARK: StockLoader
/// Manages API calls to load stock data
public struct StockLoader {
	/// BAD PRACTICE!!! ONLY FOR DEMO PURPOSE
	/// ADD YOUR API KEY HERE
    private let apiKey = "1234"
    private let endpointURLString = "https://financialmodelingprep.com/api/v3"
    
    /// Loads a stock's profile form the endpoint
    /// - Parameters:
    ///     - ticker: Ticker symbol of the stock
    /// - Returns: Stock profile
    private func loadStockProfileFromAPI(ticker: String) async throws -> StockProfileResponse {
        let urlString = "\(endpointURLString)/quote-order/\(ticker)?apikey=\(apiKey)"
        
        guard let endpointURL = URL(string: urlString) else {
            throw StockLoaderError.invalidURL(urlString)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: endpointURL)
            let stockProfile = try JSONDecoder().decode([StockProfileResponse].self, from: data)
            
            guard let profile = stockProfile.first else {
                throw StockLoaderError.emptyResponse
            }
            
            return profile
        } catch {
            throw StockLoaderError.networkError(error)
        }
    }
    
    /// Returns price history of a stock for the last year
    /// - Parameters:
    ///     - ticker: Ticker symbol of the stock
    /// - Returns: Stock price history
    private func loadStockPriceHistoryFromAPI(ticker: String) async throws -> [Double] {
        let currentDate = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: currentDate) else {
            throw StockLoaderError.invalidDate
        }
        
        let baseString = "\(endpointURLString)/historical-price-full/\(ticker)"
        let fromDate = dateFormatter.string(from: oneYearAgo)
        let toDate = dateFormatter.string(from: currentDate)
        
        let urlString = "\(baseString)?from=\(fromDate)&to=\(toDate)&apikey=\(apiKey)"
        
        guard let endpointURL = URL(string: urlString) else {
            throw StockLoaderError.invalidURL(urlString)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: endpointURL)
            let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
            
            // If historical data is empty, throw an error
            guard !apiResponse.historical.isEmpty else {
                throw StockLoaderError.emptyResponse
            }
            
            let averagePrices: [Double] = apiResponse.historical.map { ($0.open + $0.close) / 2 }
            return averagePrices.reversed()
        } catch {
            throw StockLoaderError.networkError(error)
        }
    }
    
    /// Loads a complete stock struct
    /// - Parameters
    ///     - ticker: Ticker symbol of the stock
    /// - Returns: Stock
    public func loadStockFromAPI(ticker: String) async throws -> Stock {
        // Fetch the stock price history from the API
        let priceHistory: [Double] = try await loadStockPriceHistoryFromAPI(ticker: ticker)
        
        // Fetch the stock profile from the API
        let stockProfile: StockProfileResponse = try await loadStockProfileFromAPI(ticker: ticker)
        
        // Construct the Stock object
        let stock = Stock(
            tickerSymbol: stockProfile.symbol,
            companyName: stockProfile.name,
            marketCap: stockProfile.marketCap,
            peRatio: stockProfile.pe,
            priceHistory: priceHistory
        )
        
        return stock
    }
}

// MARK: StockLoaderError
// Defines error types occuring during API calls
enum StockLoaderError: Error {
    case invalidURL(String)
    case networkError(Error)
    case invalidResponse
    case emptyResponse
    case invalidDate
}

// MARK: StockProfileResponse
// Holds a stock profile response
private struct StockProfileResponse: Decodable {
    let symbol: String
    let name: String
    let marketCap: Double
    let pe: Double
    
    enum CodingKeys: CodingKey {
        case symbol
        case name
        case marketCap
        case pe
    }
}

// MARK: HistoricalData
// Holds a stock's historical data
struct HistoricalData: Decodable {
    let open: Double
    let high: Double
    let low: Double
    let close: Double
}

// MARK: ApiResponse
struct ApiResponse: Decodable {
    let historical: [HistoricalData]
}
