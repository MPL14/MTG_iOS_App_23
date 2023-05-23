//
//  Counterview.swift
//  MTGCommanderTracker
//
//  Created by MPL on 3/16/23.
//
import SwiftUI

struct CounterView: View {
    @Binding var counter: Counter

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(counter.title)
                    .font(.headline)
                Text("Value: \(counter.value)")
            }

            Spacer()

            HStack {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    counter.value -= 1
                }) {
                    Text("-")
                        .frame(width: 44, height: 44)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    counter.value += 1
                }) {
                    Text("+")
                        .frame(width: 44, height: 44)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
    }
}
