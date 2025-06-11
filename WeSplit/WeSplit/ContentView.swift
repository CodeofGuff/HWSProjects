//
//  ContentView.swift
//  WeSplit
//
//  Created by David Guffre on 5/21/25.
//
import SwiftUI

let darkBackground = Color(.black)
let cardBackground = Color(.systemGray5).opacity(0.85)

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
						.foregroundColor(.primary)
						.font(.callout)
						.padding(.vertical, 4)

					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100, id: \.self) {
							Text("\($0) people")
								.font(.footnote)
								.foregroundColor(.primary)
						}
					}
					.font(.callout)
				}
				.listRowBackground(cardBackground)
				.clipShape(RoundedRectangle(cornerRadius: 15))
				.padding(.vertical, 2)

				Section("How much would you like to tip?") {
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(1..<101, id: \.self) {
							Text($0, format: .percent)
								.font(.footnote)
								.foregroundColor(.primary)
						}
					}
					.pickerStyle(.automatic)
					.font(.callout)
				}
				.listRowBackground(cardBackground)
				.clipShape(RoundedRectangle(cornerRadius: 15))
				.padding(.vertical, 2)

				Section("How much each person pays:") {
					Text(
						totalPerPerson,
						format:
						.currency(code: Locale.current.currency?.identifier ?? "USD")
					)
					.font(.callout)
					.foregroundColor(.primary)
					.padding(.vertical, 4)
				}
				.listRowBackground(cardBackground)
				.clipShape(RoundedRectangle(cornerRadius: 15))
				.padding(.vertical, 2)

				Section("Total check amount") {
					Text(
						billAmount,
						format:
						.currency(code: Locale.current.currency?.identifier ?? "USD")
					)
					.font(.callout)
					.foregroundColor(.primary)
					.padding(.vertical, 4)
				}
				.listRowBackground(cardBackground)
				.clipShape(RoundedRectangle(cornerRadius: 15))
				.padding(.vertical, 2)
			}
			.scrollContentBackground(.hidden)
			.background(
				LinearGradient(
					colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
			)
			.navigationTitle("WeSplit")
			.toolbarColorScheme(.dark, for: .navigationBar)
			.toolbar {
				if amountIsFocused {
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
		.background(darkBackground.ignoresSafeArea())
	}
}

#Preview {
	ContentView()
}
