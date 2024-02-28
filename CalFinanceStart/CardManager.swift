//
//  CardManager.swift
//  CalFinance
//
//  Created by Justin Wong on 1/13/24.
//

import SwiftUI
/// A class than manages all of the generation and tracking of cards and transactions as well as their respective logic.
@Observable class CardManager {
    /// All the credit cards that ``CardManager`` manages. An array of ``CFCard``s.
    private var cards = [CFCard]()
    /// All the transactions from all cards. An array of ``CFTransaction``.
    /// - This is a `computed property` which is like special variable in the sense that it is derived from some computation from other properties and methods.
    /// - In this case, we are aggregating all the ``CFTransaction``s from `cards` together. Whenever `cards` changes, `allTransactions` will reflect any necessary changes! So cool 😎!
    private var allTransactions: [CFTransaction] {
        return cards.flatMap { $0.transactions }
    }
    
    /// The ``CardManager`` initialization method. On instantiation, the `cards` property will be set to an array of 10 randomly generated ``CFCard``s.
    init() {
        cards = generateCards(for: 10)
    }
    
    private var personNames = [
        "Ethan Johnson",
        "Mia Davis",
        "Benjamin Taylor",
        "Abigail Anderson",
        "Samuel White",
        "Harper Martinez",
        "Jackson Wilson",
        "Lily Harris",
        "Aiden Thomas",
        "Grace Robinson",
        "Lucas Moore",
        "Scarlett Martin",
        "Elijah Clark",
        "Chloe Lewis",
        "Henry Turner",
        "Sofia Baker",
        "Jack Hill",
        "Amelia Mitchell",
        "Oliver Perez",
        "Ava Scott"
    ]
    
    //MARK: - Getters and Setters
    /// A "getter" for `cards`.
    /// - Returns: The `cards` instance variable.
    /// - Since `cards`'s access level is `private` we need to use a "getter" to access the property/ instance variable.
    func getCards() -> [CFCard] {
        return cards
    }
    
    /// A "getter" for `allTransactions`.
    /// - Returns: The `allTransactions` instance variable.
    /// - Since `allTransactions`'s access level is `private` we need to use a "getter" to access the property/ instance variable.
    func getAllTransactions() -> [CFTransaction] {
        return allTransactions
    }
    
    //MARK: - Generation Logic
    /// Generate a given number of cards.
    /// - Parameter count: Number of cards to generate.
    /// - Returns: An array of ``CFCard``.
    func generateCards(for count: Int) -> [CFCard] {
        var generatedCards = [CFCard]()
        for _ in 0..<count  {
            generatedCards.append(createCard())
        }
        return generatedCards
    }
    
    /// Generate an array of transactions.
    /// - Parameters:
    ///   - maxCount: The maximum number of transactions to generate between 1 to ``maxCount``
    ///   - cardNumber: The associated card number that the transactions belong to.
    /// - Returns: An array of ``CFTransactions``.
    private func generateTransactions(withMax maxCount: Int, for cardNumber: String) -> [CFTransaction] {
        var generatedTransactions = [CFTransaction]()
        let randomCount = Int.random(in: 1...maxCount)
        for _ in 0...randomCount {
            let transactionTypes = CFTransaction.CFTransactionType.allCases
            let randomTransactionType = transactionTypes[Int.random(in: 0..<transactionTypes.count)]
            let date10000DaysAgo = Date(timeIntervalSinceNow: -86400 * 10000)
            let newTransaction = CFTransaction(type: randomTransactionType, changeAmount: Int.random(in: -10000...10000), date: randomDateInRange(startDate: date10000DaysAgo, endDate: Date()), associatedCardNumber: cardNumber)
            generatedTransactions.append(newTransaction)
        }
        return generatedTransactions
    }
    
    /// Generate a random date between a given interval.
    /// - Parameters:
    ///   - startDate: The start date (inclusive).
    ///   - endDate: The end date (inclusive)
    /// - Returns: The random ``Date``.
    private func randomDateInRange(startDate: Date, endDate: Date) -> Date {
        let timeInterval = TimeInterval.random(in: startDate.timeIntervalSince1970...endDate.timeIntervalSince1970)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    //MARK: - IMPLEMENT Cards Management Logic >>>>>>
    
    /// Create and return a new card.
    /// - Card's `cardNumber` uses a function in ``CardManager`` (already implemented)
    /// - Card's `ownerName` is randomly selected from `personNames` list
    /// - Card's `balance` is a random `Int` ranging between the values -10,000 and 10000 (both inclusive)
    /// - Card's `transactions` uses a function in ``CardManager`` with maximum amount of `10` (already implemented)
    /// - Returns: A ``CFCard``.
    func createCard() -> CFCard {
        //TODO: Implement createCard()
        let cNum = createCreditCardNumber()
        let card = CFCard(cardNumber: cNum , ownerName: personNames[Int.random(in: 0...personNames.count - 1)], balance: Int.random(in: -10000 ... 10000), transactions: generateTransactions(withMax: 10, for: cNum))
        return card
    }
    
    /// Add a given or new card to CardManager
    /// - Parameter card: A given ``CFCard`` to add.
    func addCard(for card: CFCard) {
        //TODO: Implement addCard()
        cards.append(card)
    }
    
    /// Calculate the total balance across all cards currently in ``CardManager``. For example, if there are 3 cards with balances of -100, 50, and 200, `getTotalBalanceAcrossAllCards` returns 150 (-100 + 50 + 200).
    /// - Returns: The total balance across all cards.
    func getTotalBalanceAcrossAllCards() -> Int {
        //TODO: Implement getTotalBalanceAcrossAllCards()
        return cards.reduce(0) { $0 + $1.balance }
    }
    
    /// Filters cards into two groups: those with positive and negative balances
    /// - Returns: A ``CFCardBalances`` struct with the appropriate initialized properites (`cardsWithPositiveBalances` & `cardsWithNegativeBalances`)
    func getCardsPositiveAndNegativeBalances() -> CFCardBalances {
        //TODO: Implement getCardsPositiveAndNegativeBalances(
        let positiveBalances = cards.filter { $0.balance >= 0 }
        let negativeBalances = cards.filter { $0.balance < 0 }
        return CFCardBalances(cardsWithPositiveBalances: positiveBalances, cardsWithNegativeBalances: negativeBalances)
    }
    
    //MARK: - <<<<<< END IMPLEMENTATION
    
    /// Given a card, remove it from CardManager.
    /// - Parameter cardToRemove: The card to be removed.
    func removeCard(for cardToRemove: CFCard) {
        if let index = cards.firstIndex(of: cardToRemove) {
            cards.remove(at: index)
        }
    }
    
    //MARK: - Credit Card Number Logic
    //https://gist.github.com/sagaya/1d1be4c7afbca2f681bb2a7d9cb2c882
    private func make_random_number(num:Int) -> [Int]{
        var result = [Int]()
        for _ in 0...num {
            result.append(Int(arc4random_uniform(9)))
        }
        return result
    }
    
    /// Creates a new valid credit card number using Luhn's Algorithm (introduced in CS61A!).
    /// - Returns: A `String` of the credit card number.
    func createCreditCardNumber() -> String {
        var card_number = ""
        
        var random_master_int = make_random_number(num: 12)
        //Add random master card numbers here [51,52,53,54]
        random_master_int.insert(5, at: 0)
        random_master_int.insert(4, at: 1)
        print(random_master_int)
        
        for (index, _) in random_master_int.enumerated(){
            if index % 2 != 0 {
                let r = random_master_int[index]  * 2
                let characters = String(r).compactMap{Int(String($0))}
                let sum = characters.reduce(0, +)
                print(sum)
            }
        }
        
        
        let sum = random_master_int.reduce(0, +) * 9
        random_master_int.append(sum % 10)

        let random_master_string = random_master_int.map {String($0)}
        
        let first4 = "\(random_master_string[0...3].compactMap({$0}).joined())"
        let second4 = "\(random_master_string[4...7].compactMap({$0}).joined())"
        let third4 = "\(random_master_string[8...11].compactMap({$0}).joined())"
        let fourth4 = "\(random_master_string[12...15].compactMap({$0}).joined())"
        card_number.append(first4)
        card_number.append(second4)
        card_number.append(third4)
        card_number.append(fourth4)

        return card_number
    }
}
