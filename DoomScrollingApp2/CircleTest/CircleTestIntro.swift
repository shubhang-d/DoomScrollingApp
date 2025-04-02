//
//  CircleTestIntro.swift
//  doomScrolling
//
//  Created by Shubhang Dixit on 19/02/25.
//

import SwiftUI

struct ReactionTimeIntroView: View {
    @State private var isGameStarted = false

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color(.systemGray6).edgesIgnoringSafeArea(.all)

                    VStack {
                        // Title and Subtitle
                        Text("Reaction Time Test")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        Text("Test Your Sustained and Selective Attention")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.bottom, 30)

                        // Description
                        Text("In this test, a random color or shape will appear on the screen, and your task is to tap it as quickly as possible. The faster and more accurately you tap, the better your result.")
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
                            
                            Text("A random color or shape will appear on the screen for a brief moment.")
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                            
                            Text("Your task is to tap the correct color or shape as quickly as possible.")
                                .font(.body)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(0.8)
                            
                            Text("The quicker and more accurate your response, the better your score.")
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
                            
                            Text("Sustained Attention: Can you stay focused long enough to react quickly to the random stimuli?")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("Selective Attention: Can you ignore distractions (e.g., other shapes/colors) and tap the correct one?")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)

                        Spacer()

                        // Continue Button
                        NavigationLink(destination: ReactionTimeView()
                            .navigationBarBackButtonHidden()) {
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
            .navigationBarBackButtonHidden(true)
        }
    }
}
