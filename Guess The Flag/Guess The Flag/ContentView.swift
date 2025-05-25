//
//  ContentView.swift
//  Guess The Flag
//
//  Created by David Guffre on 5/24/25.
//

import SwiftUI

struct ContentView: View {
	@State private var counter = 0
	@State private var showingAlert = false
	@State private var showingAlert2 = false

	var body: some View {
		Spacer()
		Spacer()
		Button {
			counter += 1
			print("Button was tapped \(counter) times!")
			resetCounter()
		} label: {
			VStack {
				Text("Push me")
					.padding(-7)
				Image("US")
					.cornerRadius(10)
					.padding(10)
					.background(.blue)
					.cornerRadius(20)
			}
		}
		.alert("You did it! You reset the counter!", isPresented: $showingAlert2) {}

		Spacer()

		Text("You have pushed the button this many times:")
		Text(counter.description)
		Button(role: .destructive) {
			showingAlert = true
		} label: {
			Text("Reset Counter")
				.padding()
				.background(.black)
				.cornerRadius(20)
		}
		.alert("Reset clicks?!", isPresented: $showingAlert) {
			Button("Yeah...", role: .destructive) {
				counter = 0
				print("Button was reset to 0")
			}
			Button("UNDO!!!", role: .cancel) {}
		} message: {
			Text("Are you sure you want to reset the counter?")
		}
		Spacer()
	}

	func resetCounter() {
		if counter > 20 {
			counter = 0
			showingAlert2 = true
		}
	}
}

#Preview {
	ContentView()
}
