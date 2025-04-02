//
//  FocusBubbleIntro.swift
//  doomScrolling
//
//  Created by Shubhang Dixit on 19/02/25.
//

import SwiftUI

struct FocusBubbleIntroView: View {
    @State private var isGameStarted = false

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    // Background Color (Light Gray for better readability)
                    Color(.systemGray6).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        // Title and Subtitle
                        Text("Focus Bubble")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        Text("Test Your Divided Attention and Task-Switching Skills")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.bottom, 30)
                            .multilineTextAlignment(.center)

                        // Description
                        Text("In this test, bubbles will appear on the screen with numbers or letters. Your task is to pop them in a specific order (e.g., ascending numbers or alphabetical order).")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 25)
                            .foregroundColor(.black)
                            .opacity(0.8)
                            .padding(.bottom, 30)

                        // Content Card (How It Works Section)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("How It Works:")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.bottom, 10)
                            
                            Text("Bubbles with numbers or letters will appear on the screen. You need to pop them in a specific order, for example:")
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                            
                            Text("1, 2, 3... (ascending order) or A, B, C... (alphabetical order).")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                            
                            Text("Your goal is to tap the bubbles in the correct order as quickly as possible.")
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                        
                        // Content Card (What It Measures Section)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("What It Measures:")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.bottom, 10)
                            
                            Text("Divided Attention: Can you manage multiple tasks at once (e.g., identifying and popping bubbles in order)?")
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                            
                            Text("Task-Switching Ability: How well can you switch between tasks, such as identifying numbers or letters and popping them in the right order?")
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)

                        Spacer()

                        // Continue Button
                        NavigationLink(destination: BubbleGameView()) {
                            Text("Continue")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue) // Solid blue color for the button
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 40)
                        }
                    }
                    .padding()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}


