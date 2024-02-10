//
//  Card.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import Foundation

/// A struct representing what a credit card looks like.  Each `CFCard` contains an array of `CFTransactions`.
struct CFCard: Identifiable, Equatable {
    static func == (lhs: CFCard, rhs: CFCard) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var cardNumber: String
    var ownerName: String
    var balance: Int
    var transactions: [CFTransaction]
}

/// A struct representing what a transaction looks like. Each `CFTransaction` belongs to a `CFCard`.
struct CFTransaction: Identifiable {
    enum CFTransactionType: CaseIterable {
        case transfer, deposit, purchase
    }
    
    let id = UUID()
    var type: CFTransactionType
    var changeAmount: Int
    var date: Date
    var associatedCardNumber: String
}

/// A helper struct to manage our cards with postive and negative balances.
struct CFCardBalances {
    var cardsWithPositiveBalances: [CFCard]
    var cardsWithNegativeBalances: [CFCard]
}
