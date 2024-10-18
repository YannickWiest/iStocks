//
//  iStocksApp.swift
//  iStocks
//
//  Created by Yannick Wiest on 09.10.24.
//

import SwiftUI

@main
struct IStocksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(Model())
        }
    }
}
