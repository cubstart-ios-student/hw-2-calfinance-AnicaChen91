//
//  BalanceAmountView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View that shows the balance amount.
/// - Formats with `$` and the correct positive or negative signage for the respective amount.
/// - It uses a `ternary operator` to accomplish the same logic as an `if else` statement would do. 
struct BalanceAmountView: View {
    var amount: Int
    
    var body: some View {
        Text("\(amount < 0 ? "-" : "+") $\(abs(amount))")
    }
}

#Preview {
    BalanceAmountView(amount: 1000)
}
