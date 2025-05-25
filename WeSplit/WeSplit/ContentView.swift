//
//  ContentView.swift
//  WeSplit
//
//  Created by David Guffre on 5/21/25.
//
import SwiftUI

struct ContentView: View {
	@State private var checkAmount: Double = 0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 15
	@FocusState private var amountIsFocused: Bool

	var billAmount: Double {
		let tipValue = (checkAmount / 100) * Double(tipPercentage)
		let total = checkAmount + tipValue
		return total
	}

	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople)
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection
		let total = checkAmount + tipValue
		let amountPerPerson = total / peopleCount
		return amountPerPerson
	}

	var body: some View {
		NavigationStack {
			Form {
				Section("Enter the bill total and amount of people") {
					TextField("Check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)

					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100, id: \.self) {
							Text("\($0) people")
						}
					}
				}

				Section("How much would you like to tip?") {
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(1..<101, id: \.self) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.automatic)
				}

				Section("How much each person pays:") {
					Text(
						totalPerPerson,
						format:
						.currency(code: Locale.current.currency?.identifier ?? "USD")
					)
				}

				Section("Total check amount") {
					Text(
						billAmount,
						format:
						.currency(code: Locale.current.currency?.identifier ?? "USD")
					)
				}
			}

			.background(
				LinearGradient(
					colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
			)
			.navigationTitle("WeSplit")
			.toolbar {
				if amountIsFocused {
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
		.background(Color(.blue))
	}
}

#Preview {
	ContentView()
}
