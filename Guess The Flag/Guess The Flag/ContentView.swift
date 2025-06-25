//
//  ContentView.swift
//  Guess The Flag
//
//  Created by David Guffre on 5/24/25.
//

import SwiftUI

struct ContentView: View {
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0 ... 2)
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var score = 0
	@State private var gameOver = false
	@State private var alertTitle = ""
	@State private var qCount = 0

	var body: some View {
		ZStack {
			RadialGradient(stops: [
				.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
				.init(color: Color(red: 0.76, green: 0.16, blue: 0.2), location: 0.3),
				.init(color: Color(red: 0.1, green: 0.3, blue: 0.45), location: 5)

			], center: .top, startRadius: 200, endRadius: 700)
				.ignoresSafeArea()

			VStack {
				Spacer()
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundStyle(.white)

				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of:")
							.foregroundStyle(.secondary)
							.font(.subheadline.weight(.semibold))

						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
					}
					ForEach(0 ..< 3) { number in
						Button {
							flagTapped(number)
							number == correctAnswer ? score += 1 : print("Wrong")

						} label: {
							Image(countries[number])
								.clipShape(.capsule)
								.shadow(radius: 5)
						}
					}
				}

				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(.rect(cornerRadius: 20))

				Spacer()
				Spacer()
				Text("Score: \(score)")
					.foregroundStyle(.white)
					.font(.title.bold())
				Spacer()		
			}
			.padding(25)
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text("You score is: \(score)")
		}
		.alert(alertTitle, isPresented: $gameOver) {
			Button("New Game", action: restart)
		} message: {
			Text("Congrats, you won!")
		}
	}

	func flagTapped(_ number: Int) {
		scoreTitle = number == correctAnswer ? "Correct" : "Wrong, that flag is: \(countries[correctAnswer])"
		showingScore = true
		qCount += 1

		if qCount >= 3 {
			alertTitle = "Woohoo!"
			gameOver = true
		}
	}

	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0 ... 2)
	}

	func restart() {
		qCount = 0
		score = 0
		askQuestion()
	}
}

#Preview {
	ContentView()
}
