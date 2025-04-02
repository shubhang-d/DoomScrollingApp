import SwiftUI

struct TranslationScreen: View {
    @State private var selectedOption: String? = nil
    private let options = ["chat", "garçon", "et"]

    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("12:00")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button(action: {
                    // Action for close button
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                }
            }
            
            // Progress Bar
            HStack {
                ProgressBar(value: 0.7)
                    .frame(height: 10)
                Spacer()
                Text("1:56")
                    .padding(.leading)
                    .foregroundColor(.purple)
            }
            .padding()

            // Question Label
            Text("Select the correct translation")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            // Bear Image and Translation Text
            HStack {
                Image(systemName: "bear") // Placeholder for bear image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("boy")
                    .font(.headline)
                    .padding()
            }

            // Selection Options
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }

            // Check Button
            Button(action: {
                // Action for check button
            }) {
                Text("CHECK")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

// Dummy ProgressBar View
struct ProgressBar: View {
    var value: Double // Value should be between 0.0 and 1.0

    var body: some View {
        GeometryReader { geometry in
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .overlay(
                    Capsule()
                        .fill(Color.purple)
                        .frame(width: CGFloat(value) * geometry.size.width)
                )
        }
        .cornerRadius(5)
        .padding()
    }
}


