//
//  PriceGraphView.swift
//  iStocks
//
//  Created by Yannick Wiest on 10.10.24.
//

import SwiftUI
import Charts

// MARK: PriceGraphView
/// A view containing a graph of the stock price
struct PriceGraphView: View {
    let prices: [Double]

    var body: some View {
        LineChartView(data: prices)
            .padding()
    }
}

// MARK: LineChartView
/// A subview of the pricegraph with with only the chart
struct LineChartView: View {
    let data: [Double]

    var body: some View {
        let minPrice = data.min() ?? 0
        let maxPrice = data.max() ?? 1

        VStack {
            Text("Max: \(String(format: "%.2f", maxPrice))")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
                .padding(.leading, 8)

            Chart {
                ForEach(data.indices, id: \.self) { index in
                    LineMark(
                        x: .value("Index", index),
                        y: .value("Price", data[index])
                    )
                    .foregroundStyle(.blue)
                }
            }
            .chartXAxis(.hidden) // Remove x-axis label
            .chartYAxis {
                AxisMarks()
            }
            .frame(height: 200)
            .chartYScale(domain: minPrice...maxPrice)

            Text("Min: \(String(format: "%.2f", minPrice))")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 8)
                .padding(.leading, 8)
        }
    }
}

// MARK: LineCharView Preview
#Preview {
    LineChartView(data: Array(1...100).map { Double($0) })
}
