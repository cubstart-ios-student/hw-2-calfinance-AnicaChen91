//
//  MyCardsView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/13/24.
//

import SwiftUI

/// NOT NEEDED IN HW
/// - This is the main view titled `Cards`. From here, we present ``ManageCardsView`` and ``AddNewCardView``. We also display the scrolling list of ``CreditCardView``s at the top and all ``CFCard``'s ``CFTransaction``s at the bottom.
struct MyCardsView: View {
    @Namespace private var animation
    @State private var cardManager = CardManager()
    @State private var isPresentingManageCardsSheet = false
    @State private var isPresentingAddNewCardView = false
    @State private var isTransactionsListExpanded = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                creditCardsView
                transactionsView
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .navigationTitle("Cards")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        isPresentingManageCardsSheet.toggle()
                    }) {
                        Image(systemName: "rectangle.stack")
                    }
                    
                    Button(action: {
                        isPresentingAddNewCardView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingManageCardsSheet) {
                ManageCardsView(cardManager: cardManager)
            }
            .fullScreenCover(isPresented: $isTransactionsListExpanded) {
                transactionsView
                    .padding()
            }
            .sheet(isPresented: $isPresentingAddNewCardView) {
                AddNewCardView(cardManager: cardManager)
            }
        }
    }
    
    private var creditCardsView: some View {
        TabView {
            ForEach(cardManager.getCards(), id: \.id) { card in
                CreditCardView(card: card)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode:.always))
        .safeAreaPadding(.horizontal, 10)
        .frame(height: 290)
    }
    
    @ViewBuilder
    private var transactionsView: some View {
        HStack {
            Text("Transactions")
                .font(.title)
                .bold()
                .multilineTextAlignment(.leading)
            Spacer()
            Button(action: {
                withAnimation {
                    isTransactionsListExpanded.toggle()
                }
            }) {
                Image(systemName: "rectangle.expand.vertical")
                    .foregroundStyle(.green)
                    .font(.system(size: 20))
            }
        }
        
        Spacer()
        
        List {
            ForEach(cardManager.getAllTransactions()) { transaction in
                TransactionView(transaction: transaction)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .padding(EdgeInsets(top: 0, leading: -30, bottom: 0, trailing: -30))
        .scrollContentBackground(.hidden)
        .matchedGeometryEffect(id: "transactions-list", in: animation)
    }
}

#Preview {
    MyCardsView()
}
