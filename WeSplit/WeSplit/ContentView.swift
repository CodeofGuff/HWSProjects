//
//  ContentView.swift
//  WeSplit
//
//  Created by David Guffre on 5/21/25.
//
import SwiftUI


struct ContentView: View {
	@State private var tapCount: Int = 0
	@State private var name = ""
	@State private var restrauntName = ""
	@State private var menuItems = ["Harry", "Ron", "Chester"]
	@State private var currentMenuItem: String = "Harry"
	
	
	var body: some View {
		NavigationStack {
			Form {
				Picker("Select your student", selection: $currentMenuItem) {
					ForEach(menuItems, id: \.self) {
						Text($0)
					}
				}
			}
			.navigationTitle(Text("Menu Items"))
		}
	}
}


#Preview {
	ContentView()
}
