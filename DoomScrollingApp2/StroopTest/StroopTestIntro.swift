import SwiftUI

struct StroopTestIntroView: View {
    @State private var isGameStarted = false

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    // Background Color (Light Gray for better readability)
                    Color(.systemGray6).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        // Title and Subtitle
                        Text("Stroop Test")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        Text("Measure Your Cognitive Control")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.bottom, 30)

                        // Description
                        Text("Welcome to the Stroop Test, where we measure your attention span and cognitive control!")
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
                            
                            Text("In this test, you'll see words that represent colors, but the color of the word may not match the word itself. For example:")
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("The word 'RED' might appear in the blue color.")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("Your task is to tap the color of the text you see, not the word itself.")
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
                            
                            Text("Cognitive Control: This test checks your ability to suppress automatic responses (like reading the word) and focus on the task of identifying the color of the text.")
                                .font(.body)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            
                            Text("Attention Span: Your ability to maintain focus while suppressing distractions will help us gauge your attention span.")
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
                        NavigationLink(destination: StroopTest()) {
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

