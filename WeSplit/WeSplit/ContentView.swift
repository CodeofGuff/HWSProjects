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
			ZStack {
				// Background gradient with richer, deeper colors and multiple stops
				LinearGradient(
					gradient: Gradient(colors: [
						Color.black,
						Color(red: 0.05, green: 0.05, blue: 0.2), // deep indigo
						Color(red: 0.0, green: 0.15, blue: 0.18), // dark teal
						Color(red: 0.2, green: 0.0, blue: 0.25) // deep purple
					]),
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
				.ignoresSafeArea()
				// subtle glassy overlay for depth
				.overlay(
					Color.white
						.opacity(0.04)
						.blur(radius: 20)
						.ignoresSafeArea()
				)
				
				ScrollView {
					VStack(spacing: 28) {
						// Header Section
						VStack(spacing: 10) {
							Image(systemName: "creditcard.fill")
								.font(.system(size: 44, weight: .bold))
								.foregroundStyle(
									LinearGradient(
										colors: [.cyan, .blue],
										startPoint: .topLeading,
										endPoint: .bottomTrailing
									)
								)
								.shadow(color: .cyan.opacity(0.6), radius: 12, x: 0, y: 2)
							
							Text("WeSplit")
								.font(.largeTitle.weight(.heavy))
								.foregroundColor(.white)
								.shadow(color: .cyan.opacity(0.9), radius: 8, x: 0, y: 0)
							
							Text("Split bills effortlessly")
								.font(.subheadline.weight(.semibold))
								.foregroundColor(.gray.opacity(0.85))
						}
						.padding(.top, 28)
						HStack(spacing: 20) {
							// Bill Amount Section
							ModernSection(title: "Bill Amount", icon: "dollarsign.circle.fill") {
								VStack(spacing: 16) {
									TextField("Enter amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
										.font(.title2.weight(.semibold))
										.foregroundColor(.white)
										.multilineTextAlignment(.center)
										.keyboardType(.decimalPad)
										.focused($amountIsFocused)
										.padding(16)
										.background(
											ZStack {
												RoundedRectangle(cornerRadius: 16)
													.fill(.ultraThinMaterial)
													.background(Color.black.opacity(0.25))
													.clipShape(RoundedRectangle(cornerRadius: 16))
												RoundedRectangle(cornerRadius: 16)
													.stroke(Color.cyan.opacity(0.6), lineWidth: 1.5)
											}
										)
										.shadow(color: Color.cyan.opacity(0.3), radius: 12, x: 0, y: 4)
								}
							}
							
							// People Count Section
							ModernSection(title: "People", icon: "person.2.fill") {
								VStack(spacing: 14) {
									Text("\(numberOfPeople)")
										.font(.title.weight(.bold))
										.foregroundColor(.white)
										.shadow(color: .cyan.opacity(0.6), radius: 8, x: 0, y: 1)
									
									HStack(spacing: 24) {
										Button(action: {
											if numberOfPeople > 2 {
												numberOfPeople -= 1
											}
										}) {
											Image(systemName: "minus.circle.fill")
												.font(.title2.weight(.bold))
												.foregroundColor(numberOfPeople > 2 ? .cyan : .gray)
												.shadow(color: numberOfPeople > 2 ? Color.cyan.opacity(0.8) : .clear, radius: 10, x: 0, y: 0)
												.scaleEffect(numberOfPeople > 2 ? 1.05 : 1.0)
												.animation(.easeInOut(duration: 0.2), value: numberOfPeople)
										}
										.disabled(numberOfPeople <= 2)
										
										Slider(value: Binding(
											get: { Double(numberOfPeople) },
											set: { numberOfPeople = Int($0) }
										), in: 2...20, step: 1)
											.accentColor(.cyan)
											.shadow(color: .cyan.opacity(0.25), radius: 10, x: 0, y: 2)
										
										Button(action: {
											if numberOfPeople < 20 {
												numberOfPeople += 1
											}
										}) {
											Image(systemName: "plus.circle.fill")
												.font(.title2.weight(.bold))
												.foregroundColor(numberOfPeople < 20 ? .cyan : .gray)
												.shadow(color: numberOfPeople < 20 ? Color.cyan.opacity(0.8) : .clear, radius: 10, x: 0, y: 0)
												.scaleEffect(numberOfPeople < 20 ? 1.05 : 1.0)
												.animation(.easeInOut(duration: 0.2), value: numberOfPeople)
										}
										.disabled(numberOfPeople >= 20)
									}
								}
							}
						}
						
						// Tip Section
						ModernSection(title: "Tip", icon: "percent") {
							VStack(spacing: 18
							) {
								Text("\(tipPercentage)%")
									.font(.title.weight(.bold))
									.foregroundColor(.white)
									.shadow(color: .cyan.opacity(0.65), radius: 10, x: 0, y: 1)
								
								// Quick tip buttons
								HStack(spacing: 14) {
									ForEach([10, 15, 20, 25], id: \.self) { tip in
										Button(action: {
											tipPercentage = tip
										}) {
											Text("\(tip)%")
												.font(.system(size: 14, weight: .semibold))
												.foregroundColor(tipPercentage == tip ? .black : .white)
												.frame(width: 52, height: 38)
												.background(
													RoundedRectangle(cornerRadius: 10)
														.fill(tipPercentage == tip ? Color.cyan : Color.white.opacity(0.1))
														.shadow(color: tipPercentage == tip ? Color.cyan.opacity(0.8) : .clear, radius: 12, x: 0, y: 0)
												)
												.scaleEffect(tipPercentage == tip ? 1.1 : 1.0)
												.animation(.easeInOut(duration: 0.15), value: tipPercentage)
										}
									}
								}
								
								// Custom tip slider
								VStack(spacing: 10) {
									Text("Custom")
										.font(.caption.weight(.semibold))
										.foregroundColor(.gray.opacity(0.85))
									
									Slider(value: Binding(
										get: { Double(tipPercentage) },
										set: { tipPercentage = Int($0) }
									), in: 0...50, step: 1)
										.accentColor(.cyan)
										.shadow(color: .cyan.opacity(0.3), radius: 10, x: 0, y: 4)
								}
							}
						}
						
						// Results Section
						HStack(spacing: 20) {
							// Per Person
							ResultCard(
								title: "Per Person",
								amount: totalPerPerson,
								icon: "person.fill",
								color: .cyan
							)
							
							// Total Bill
							ResultCard(
								title: "Total Bill",
								amount: billAmount,
								icon: "receipt.fill",
								color: .purple
							)
						}
						
						Spacer(minLength: 120)
					}
					.padding(.horizontal, 24)
					.padding(.bottom, 40)
				}
			}
			.preferredColorScheme(.dark)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					if amountIsFocused {
						Button("Done") {
							amountIsFocused = false
						}
						.foregroundColor(.cyan)
						.fontWeight(.semibold)
						.shadow(color: .cyan.opacity(0.6), radius: 6, x: 0, y: 0)
					}
				}
			}
		}
	}
}

struct ModernSection<Content: View>: View {
	let title: String
	let icon: String
	let content: Content
	
	init(title: String, icon: String, @ViewBuilder content: () -> Content) {
		self.title = title
		self.icon = icon
		self.content = content()
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			HStack(spacing: 14) {
				Image(systemName: icon)
					.foregroundColor(.cyan)
					.font(.title3.weight(.semibold))
					.shadow(color: Color.cyan.opacity(0.7), radius: 6, x: 0, y: 0)
				
				Text(title)
					.font(.headline.weight(.bold))
					.foregroundColor(.white)
					.shadow(color: Color.cyan.opacity(0.7), radius: 8, x: 0, y: 0)
				
				Spacer()
			}
			
			content
		}
		.padding(14)
		.background(
			ZStack {
				RoundedRectangle(cornerRadius: 20)
					.fill(.ultraThinMaterial)
					.background(Color.black.opacity(0.3))
					.clipShape(RoundedRectangle(cornerRadius: 20))
				
				RoundedRectangle(cornerRadius: 20)
					.stroke(Color.cyan.opacity(0.25), lineWidth: 1.5)
					.shadow(color: Color.cyan.opacity(0.4), radius: 12, x: 0, y: 0)
				
				RoundedRectangle(cornerRadius: 20)
					.stroke(Color.purple.opacity(0.12), lineWidth: 0.8)
			}
		)
		.shadow(color: Color.cyan.opacity(0.09), radius: 8, x: 0, y: 4)
	}
}

struct ResultCard: View {
	let title: String
	let amount: Double
	let icon: String
	let color: Color
	
	var body: some View {
		VStack(spacing: 8) {
			Image(systemName: icon)
				.font(.title3.weight(.semibold))
				.foregroundStyle(
					LinearGradient(
						colors: [color, color.opacity(0.75)],
						startPoint: .topLeading,
						endPoint: .bottomTrailing
					)
				)
				.shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 1)
			
			Text(title)
				.font(.caption.weight(.medium))
				.foregroundColor(.gray.opacity(0.85))
			
			Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
				.font(.headline.weight(.bold))
				.foregroundColor(.white)
				.shadow(color: color.opacity(0.35), radius: 4, x: 0, y: 1)
				.minimumScaleFactor(0.9)
		}
		.frame(maxWidth: .infinity)
		.padding(14)
		.background(
			ZStack {
				RoundedRectangle(cornerRadius: 20)
					.fill(.ultraThinMaterial)
					.background(color.opacity(0.10))
					.clipShape(RoundedRectangle(cornerRadius: 20))
				
				RoundedRectangle(cornerRadius: 20)
					.stroke(color.opacity(0.35), lineWidth: 1.5)
					.shadow(color: color.opacity(0.14), radius: 6, x: 0, y: 0)
			}
		)
		.shadow(color: color.opacity(0.10), radius: 10, x: 0, y: 4)
	}
}

#Preview {
	ContentView()
}
