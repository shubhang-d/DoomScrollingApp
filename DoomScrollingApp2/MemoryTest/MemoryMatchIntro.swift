//
//  MemoryMatchIntro.swift
//  doomScrolling
//
//  Created by Shubhang Dixit on 19/02/25.
//

import SwiftUI

struct MemoryMatchIntroView: View {
    @State private var isGameStarted = false

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    // Background Color (Light Gray for better readability)
                    Color(.systemGray6).edgesIgnoringSafeArea(.all)

                    VStack {
                        // Title and Subtitle
                        Text("Memory Match Game")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        Text("Test Your Working Memory and Focused Attention")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.bottom, 30)

                        // Description
                        Text("In this test, a sequence of numbers, colors, or shapes will be shown for a few seconds. Then, you need to recall and replicate the sequence in the correct order.")
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
                            
                            Text("You will be shown a sequence of numbers, colors, or shapes for a few seconds.")
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("After that, the sequence will disappear, and you must recall and replicate it in the correct order.")
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("Your goal is to memorize and repeat the sequence as quickly and accurately as possible.")
                                .font(.body)
                                .foregroundColor(.black)
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
                            
                            Text("Working Memory: How much information can you hold and recall in the correct order?")
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("Focused Attention: Can you stay focused on the sequence without distractions?")
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
                        NavigationLink(destination: MemoryMatchGameViewController()) {
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

