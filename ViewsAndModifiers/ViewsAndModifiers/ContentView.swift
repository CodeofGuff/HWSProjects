//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by David Guffre on 5/31/25.
//

import SwiftUI

struct GridStack<Content: View>: View {
	let columns: Int
	let rows: Int
	@ViewBuilder let content: (Int, Int) -> Content

	var body: some View {
		VStack {
			ForEach(0..<rows, id: \.self) { row in
				HStack {
					ForEach(0..<columns, id: \.self) { column in
						content(row, column)
					}
				}
			}
		}
	}
}

struct ContentView: View {
	var body: some View {
		GridStack(columns: 4, rows: 4) { col, row in
			Image(systemName: "\(row * 4 + col).circle")
			Text("R\(row) C\(col)")
		}
	}
}

#Preview {
	ContentView()
}
