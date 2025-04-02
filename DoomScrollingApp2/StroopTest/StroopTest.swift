import SwiftUI

struct StroopTest: View {
    @State private var score = 0
    @State private var correctScore = 0
    @State private var wrongScore = 0
    @State private var timeLeft = 2
    @State private var isGameOver = false
    @State private var currentWord = "RED"
    @State private var currentColor = Color.blue
    @State private var timer: Timer? = nil
    @State private var responseTimes: [Double] = [] // Store response times
    @State private var lastTapTime: Date? = nil // Track the time of the last tap

    let colorOptions: [Color] = [.red, .green, .blue, .yellow]
    let words: [String] = ["RED", "GREEN", "BLUE", "YELLOW"]
    
    func getRandomWordAndColor() {
        let randomWord = words.randomElement()!
        let randomColor = colorOptions.filter { $0 != getColor(for: randomWord) }.randomElement()!
        currentWord = randomWord
        currentColor = randomColor
    }

    func getColor(for word: String) -> Color {
        switch word {
        case "RED":
            return .red
        case "GREEN":
            return .green
        case "BLUE":
            return .blue
        case "YELLOW":
            return .yellow
        default:
            return .black
        }
    }

    func startTimer() {
        timer?.invalidate()
        timeLeft = 2
        isGameOver = false
        responseTimes.removeAll() // Reset response times
        lastTapTime = nil // Reset last tap time
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                timer?.invalidate()
                isGameOver = true
            }
        }
    }

    func handleUserChoice(selectedColor: Color) {
        // Calculate response time
        let currentTime = Date()
        if let lastTapTime = lastTapTime {
            let responseTime = currentTime.timeIntervalSince(lastTapTime)
            responseTimes.append(responseTime)
        }
        lastTapTime = currentTime // Update last tap time

        // Update score
        if selectedColor == currentColor {
            score += 1
            correctScore += 1
        }else{
            wrongScore += 1
        }
        
        getRandomWordAndColor()
    }

    func calculateAverageResponseTime() -> Double {
        guard !responseTimes.isEmpty else { return 0.0 }
        let totalResponseTime = responseTimes.reduce(0, +)
        return totalResponseTime / Double(responseTimes.count)
    }

    var body: some View {
        VStack {
            Text("Time: \(timeLeft)s")
                .font(.largeTitle)
                .padding()

            Text(currentWord)
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(currentColor)
                .padding()

            HStack {
                ForEach(colorOptions, id: \.self) { color in
                    Button(action: {
                        handleUserChoice(selectedColor: color)
                    }) {
                        Text(color == .red ? "RED" : color == .green ? "GREEN" : color == .blue ? "BLUE" : "YELLOW")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(color)
                            .cornerRadius(10)
                            .frame(maxWidth: 100, maxHeight: 100)
                    }
                    .frame(height: 100)
                }
            }

            Text("Score: \(score)")
                .font(.title)
                .padding()

            if isGameOver {
//                VStack {
//                    Text("Game Over!")
//                        .font(.largeTitle)
//                        .padding()
//
//                    Text("Your final score is: \(score)")
//                        .font(.title)
//                        .padding()
//
//                    Text(String(format: "Average Response Time: %.2f seconds", calculateAverageResponseTime()))
//                        .font(.caption2)
//                        .padding()
//
//                    Button(action: {
//                        score = 0
//                        startTimer()
//                        getRandomWordAndColor()
//                    }) {
//                        Text("Play Again")
//                            .font(.title)
//                            .padding()
//                            .background(Color.green)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//
//                    Button(action: {
//                        exit(0)
//                    }) {
//                        Text("Exit")
//                            .font(.title)
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                .padding()
//                .background(Color.black.opacity(0.8))
//                .cornerRadius(20)
//                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer()
            getRandomWordAndColor()
        }
    }
}
