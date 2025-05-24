//
//  ContentView.swift
//  WeSplit
//
//  Created by David Guffre on 5/21/25.
//
import SwiftUI


struct ContentView: View {
	@State private var checkAmount: Double = 0
	@State private var numberOfPeople = 1
	@State private var tipPercentage = 15
	@FocusState private var amountIsFocused: Bool

	let tipPercentages = [0, 10, 15, 20, 25]
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople)
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection
		let total = checkAmount + tipValue
		let amountPerPerson = total / peopleCount
		return amountPerPerson
	}
	
	
	var body: some View {
		NavigationStack{
			Form {
				Section("Enter the bill total and amount of people") {
					TextField("Check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
						
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(1..<100, id: \.self) {
							Text("\($0) people")
						}
					}
				}
				
				Section("How much would you like to tip?" ){
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) { percentage in
							Text("\(percentage)%")
						}
					}
					.pickerStyle(.segmented)
				}
				
				Section("How much each person pays:") {
					Text(
						totalPerPerson,
						format:
								.currency(
									code: Locale.current.currency?.identifier ?? "USD"
								)
					)
				}
				
			}
			.navigationTitle("WeSplit")
			.toolbar {
				if amountIsFocused {
					Button("Done") {
						amountIsFocused = false
					}
				}
			}

		}
		
		
	}
}


#Preview {
	ContentView()
}

