//
//  ContentView.swift
//  WeSplit
//
//  Created by Shridhar Sukhani on 6/23/20.
//  Copyright © 2020 Shridhar Sukhani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var tipPercentage = 2
    @State private var numberOfPeople = "2"
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    private var totalPerPerson: Double {
        let splitBetween = Double.maximum(Double(numberOfPeople) ?? 1, 1)
        let tipFraction = Double(tipPercentages[tipPercentage]) / 100
        guard let amount = Double(checkAmount) else {
            return 0
        }
        return amount * (1 + tipFraction) / splitBetween
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: self.$checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: self.$numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: self.$tipPercentage) {
                        ForEach (0..<tipPercentages.count) { index in
                            Text("\(self.tipPercentages[index])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(self.totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
