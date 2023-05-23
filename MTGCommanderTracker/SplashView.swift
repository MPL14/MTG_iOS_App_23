//
//  SplashView.swift
//  MTGCommanderTracker
//
//  Created by MPL on 4/5/23.
import SwiftUI

struct SplashView: View {
    @State private var animationCompleted = false
    
    var body: some View {
        ZStack {
            Image("ImageName")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Text("Commander Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)  // Change color as needed
                    .shadow(radius: 3) // Adding shadow for readability on the image
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animationCompleted = true
                }
            }
        }
        .opacity(animationCompleted ? 0 : 1)
    }
}
