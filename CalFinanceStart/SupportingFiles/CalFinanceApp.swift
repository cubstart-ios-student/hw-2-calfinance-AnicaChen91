//
//  CalFinanceApp.swift
//  CalFinance
//
//  Created by Justin Wong on 1/13/24.
//

import SwiftUI

@main
/// NOT NEEDED IN HW
/// -  The entry point into our application.
/// - While it's not a one-to-one comparison, you can sort of think of it like the "main" method in Java or C. `CalFinanceApp` is the highest point in our view hierarchy where we load ``MyCardsView``.
struct CalFinanceApp: App {
    var body: some Scene {
        WindowGroup {
            MyCardsView()
        }
    }
}
