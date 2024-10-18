//
//  StockMetricFormatter.swift
//  iStocks
//
//  Created by Yannick Wiest on 11.10.24.
//

import Foundation

extension NumberFormatter {
    // Helper function to format market cap in billions or trillions
    public static func formatMarketCap(_ marketCap: Double) -> String {
        if marketCap >= 1e12 {
            return String(format: "%.1fT", marketCap / 1e12) // Trillions
        } else if marketCap >= 1e9 {
            return String(format: "%.1fB", marketCap / 1e9)  // Billions
        } else {
            return String(format: "%.0f", marketCap)          // As is for smaller values
        }
    }
}
