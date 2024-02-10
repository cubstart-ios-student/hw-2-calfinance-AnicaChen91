//
//  ManageCardsView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// NOT NEEDED IN HW: View for managing our credit cards. Presented as a `fullScreenCover` in ``MyCardsView``.
/// - Upon tapping/selecting on a credit card, `SelectedCreditCardView` will be shown.
struct ManageCardsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var cardManager: CardManager
    @Namespace private var animation
    @State private var selectedCard: CFCard? = nil
    @State private var isShowingSelectedView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let selectedCard = selectedCard, isShowingSelectedView {
                    SelectedCreditCardView(cardManager: cardManager, selectedCard: selectedCard, isShowingSelectedView: $isShowingSelectedView, animation: animation)
                } else {
                    creditCardsView
                }
            }
                .navigationTitle("Manage Cards")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    backAndCloseButton
                }
        }
    }
    
    @ToolbarContentBuilder
    private var backAndCloseButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                if !isShowingSelectedView {
                    dismiss()
                } else {
                    withAnimation {
                        selectedCard = nil
                        isShowingSelectedView = false
                    }
                }
            }) {
                Image(systemName:
                        selectedCard == nil ? "xmark.circle.fill" : "chevron.left.circle.fill")
                    .foregroundStyle(.gray)
                    .font(.system(size: 25))
            }
        }
    }
    
    private var creditCardsView: some View {
        VStack {
            HStack {
                Text("^[\(cardManager.getCards().count) Card](inflect: true)")
                    .applyIndigoBackground()
                BalanceAmountView(amount: cardManager.getTotalBalanceAcrossAllCards())
                    .applyIndigoBackground()
            }
            
            ScrollView {
                ForEach(Array(cardManager.getCards().enumerated()), id: \.offset) { idx, card in
                        CreditCardView(card: card)
                            .offset(y: CGFloat(idx * 50))
                            .onTapGesture {
                                withAnimation {
                                    selectedCard = card
                                    isShowingSelectedView = true
                                }
                            }
                            .listRowSeparator(.hidden)
                            .frame(height: 50)
                            .matchedGeometryEffect(id: "card", in: animation)
                }
                .padding(.top, 100)
            }
            .scrollContentBackground(.hidden)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(10)
    }
}

//MARK: - SelectedCreditCardView
/// View that is presented when the user selects a credit card.
/// - Users can delete the credit card upon pressing the delete button.
/// - `fileprivate` is one of the access levels that Swift provides along with `private` and `public`. Here `SelectedCreditCardView` is only accessible or "can be seen" within this current file (`ManageCardsView.swift`).
struct SelectedCreditCardView: View {
    var cardManager: CardManager
    var selectedCard: CFCard
    @Binding var isShowingSelectedView: Bool
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            creditCardViewWithShadow
            deleteCardButton
            Spacer()
        }
        .padding(10)
    }
    
    private var creditCardViewWithShadow: some View {
        CreditCardView(card: selectedCard)
        .applyCreditCardBottomShadow()
        .matchedGeometryEffect(id: "card", in: animation)
    }
    
    private var deleteCardButton: some View {
        Button(action: {
            //Delete card action
            withAnimation {
                cardManager.removeCard(for: selectedCard)
                isShowingSelectedView = false
            }
        }) {
            Circle()
                .fill(.red)
                .frame(width: 60, height: 60)
                .overlay(
                   Image(systemName: "trash")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                )
        }
    }
}

#Preview("ManageCardsView") {
    ManageCardsView(cardManager: CardManager())
}


