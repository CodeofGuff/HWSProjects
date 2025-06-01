//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by David Guffre on 5/31/25.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		Button("Hey there") {
			print("Hi!")
		}
		.frame(width: 200, height: 50)
		.background(.red)
	}
}

#Preview {
	ContentView()
}
