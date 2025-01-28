//
//  ContentView.swift
//  PizzaCheckout

import SwiftUI

struct ContentView: View {
    
    @State var selectedPizza: Int = 0
    @State var pizzaQuantity: Int = 1
    
    @State var discountCode: String = ""
    var discountValue: Int {
        switch discountCode {
        case "PIZZA-10": 10
        case "PIZZA-15": 15
        default: 0
        }
    }
    
    var selectedPizzaPrice: Decimal {
        switch selectedPizza {
        case 0: 0
        case 1: 6
        case 2: 5.5
        case 3: 8
        case 4: 7.5
        default: 0
        }
    }
    
    var totalPriceNoDiscount: Decimal {
        selectedPizzaPrice * Decimal(pizzaQuantity)
    }
    
    var discountedValue: Decimal {
        totalPriceNoDiscount - totalPriceNoDiscount * Decimal(discountValue) / 100
    }
    
    var body: some View {
        Form {
            selectionSection
            discountSection
            paymentSection
        }
    }
    
    @ViewBuilder
    var paymentSection: some View {
        if(selectedPizza != 0){
            Section {
                HStack {
                    Text("Total")
                    Spacer()
                    Text(totalPriceNoDiscount, format: .currency(code: "EUR"))
                }
                HStack {
                    Text("Discount")
                    Spacer()
                    Text(discountValue, format: .percent)
                }
                HStack {
                    Text("Final Price")
                    Spacer()
                    Text(discountedValue, format: .currency(code: "EUR"))
                }
            } header: {
                Text("Checkout")
            }
        }
    }
    
    var selectionSection: some View {
        Section {
            Picker(
                selection: $selectedPizza,
                content: {
                    Text("")
                        .tag(0)
                    Text("Margherita")
                        .tag(1)
                    Text("Marinara")
                        .tag(2)
                    Text("Americana")
                        .tag(3)
                    Text("Prosciutto")
                        .tag(4)
                },
                label: {
                    Text("Pizza")
                }
            )
            
            if selectedPizza != 0 {
                Stepper(
                    value: $pizzaQuantity,
                    in: 1...10,
                    label: {
                        HStack {
                            Text("Quantity")
                            Spacer()
                            Text(pizzaQuantity, format: .number)
                        }
                    }
                )
            }
            
            } header: {
            Text("Choose your pizza")
        }
    }
    
    @ViewBuilder
    var discountSection: some View {
        if(selectedPizza != 0){
            Section {
                TextField("...", text: $discountCode)
            } header: {
                HStack {
                    Text("Discount Code")
                    Spacer()
                    if discountValue != 0 {
                        Text("Valid")
                            .foregroundStyle(.green)
                    }
                }
            } footer: {
                if discountValue == 0 && !discountCode.isEmpty {
                    Text("This coupon is invalid")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

#Preview ("Discount valid"){
    ContentView(selectedPizza: 1,
                pizzaQuantity: 1,
                discountCode: "PIZZA-15")
}
