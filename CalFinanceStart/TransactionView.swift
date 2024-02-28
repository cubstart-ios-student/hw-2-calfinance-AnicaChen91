//
//  TransactionView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View for a ``CFTransaction``. Shown as a list in ``MyCardsView``.
/// - Each ``CFTransaction`` has three types: transfer, deposit, and purchase. Depending on the type, `TransactionView` will show the appropriate UI.
struct TransactionView: View {
    var transaction: CFTransaction
    let birthday = Date()
    var body: some View {
            HStack() {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                    .overlay(
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            creditCardNumberSection
                            Spacer()
                            HStack (spacing: 20){
                                imageSection
                            Spacer()
                                transactionNameSection
                                Spacer()
                                infoSection
                            }
                            
                        }
                    )
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                        )
            }
    
            .frame(height: 200)
        }
   
    
    //Credit card number at the top
    private var creditCardNumberSection: some View {
        //TODO: Implement creditCardNumberSection
        Text(transaction.associatedCardNumber)
    }
    
    //Transaction type image
    private var imageSection: some View {
        //TODO: Implement imageSection
        Image(systemName: getTransactionImageName())
        .foregroundColor(getTransactionColor())
        .padding()
        .background(getTransactionColor().opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    //"Transfer", "Deposit", "Purchase"
    private var transactionNameSection: some View {
        //TODO: Implement transactionNameSection
        switch transaction.type {
            case .transfer:
                Text("Transfer")
            case .deposit:
                Text("Deposit")
            case .purchase:
                Text("Purchase")
        }
    }
    
    //Right hand side transaction information
    //HINT: Use BalanceAmountView here!
    private var infoSection: some View {
        //TODO: Implement infoSection
        VStack {
            Text("\(transaction.changeAmount)")
                .foregroundColor(getTransactionColor())
                .padding(.bottom, 4)
                .bold()
            Text(transaction.date.formatted(date: .abbreviated, time: .standard))
                .font(.caption)
                .foregroundColor(.gray)
                }
                .padding()
    }
    
    
    //MARK: - Helper Functions
    //Don't forget to use these functions!! They are indeed quite handy.
    //💡 TIP: To view these function's documentation in a more prettier way, <Option> click on the function names.
    
    /// For the current transaction, get the associated color. For example, if the transaction is of type `transfer`, &nbsp; `getTransactionColor()` returns `Color.green`.
    /// - Returns: The associated transaction color.
    private func getTransactionColor() -> Color {
        switch transaction.type {
        case .transfer:
            return .green
        case .deposit:
            return .gray
        case .purchase:
            return .red
        }
    }
    
    /// For the current transaction, get the associated system SF Symbols image name which is a `String`. Use it with `Image`.
    /// - Returns: The associated transaction SF Symbols image name.
    private func getTransactionImageName() -> String {
        switch transaction.type {
        case .transfer:
            return "tray.and.arrow.up.fill"
        case .deposit:
            return "tray.and.arrow.down.fill"
        case .purchase:
            return "dollarsign.square.fill"
        }
    }
}

/*private func formatted(
    date: Date.FormatStyle.DateStyle,
    time: Date.FormatStyle.TimeStyle
) -> String{}*/


struct TransactionViewPreviewProvider: PreviewProvider {
    static var cardManager = CardManager()
    static var previews: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading){
                Text("Purchase Transaction View:")
                    .bold()
                TransactionView(transaction: CFTransaction(type: .purchase, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
            }
            
            VStack(alignment: .leading) {
                Text("Transfer Transaction View:")
                    .bold()
                TransactionView(transaction: CFTransaction(type: .transfer, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
            }
            
            VStack(alignment: .leading) {
                Text("Deposit Transaction View:")
                    .bold()
                TransactionView(transaction: CFTransaction(type: .deposit, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
            }
        }
        .padding()
    }
}

