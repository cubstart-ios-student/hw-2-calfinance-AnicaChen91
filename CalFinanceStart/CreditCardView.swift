//
//  CreditCardView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View for a `CFCard` (BLOOOO credit card)
struct CreditCardView: View {
    var card: CFCard
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .stroke(.white, lineWidth: 2)
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    headerSection
                    Spacer()
                    balanceSection
                    visaSection
                    Spacer()
                }
                    .bold()
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 40, leading: 10, bottom: 40, trailing: 20))
            )
            .frame(height: 200)
    }
    
    private var headerSection: some View {
        //TODO: Implement headerSection
        VStack(alignment: .leading, spacing: 10
        ){
            Text(card.ownerName)
                .font(.title2)
            Text(card.cardNumber)
                .font(.headline)
        }

    }
    
    private var balanceSection: some View {
        //TODO: Implement balanceSection
        //HINT: Use BalanceAmountView here!
        VStack(alignment: .leading, spacing: 10
        ){
                Text("Balance")
            Text("$1222")
                .font(.title2)
                
        }
       
    }
    
    private var visaSection: some View {
        //TODO: Implement visaSection
        HStack{Spacer()
            Text("VISA")
                .italic()
        }
        
    }
}

#Preview {
    CreditCardView(card: CFCard(cardNumber: CardManager().createCreditCardNumber(), ownerName: "Johnny Appleseed", balance: 1000, transactions: []))
        .padding()
}
