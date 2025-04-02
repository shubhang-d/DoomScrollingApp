import SwiftUI
import SwiftData

struct BubbleGameView: View {
    @State private var bubbles: [Bubble] = []
    @State private var timerValue = 2
    @State private var gameActive = true
    @State private var score = 0
    @State private var correctscore = 0 // Track correct taps
    @State private var wrongscore = 0 // Track wrong taps
    @State private var gameOver = false
    @State private var lastTappedValue: String? = nil
    @State private var isNumberGame = Bool.random()
    @State private var isStarted = false
    
    // Track round times and calculate average time per round
    @State private var roundStartTime: Date? = nil
    @State private var roundTimes: [TimeInterval] = []
    @State private var averageRoundTime: TimeInterval = 0
    
    let totalBubbles = 5 // Number of bubbles in the game
    
    
    @Environment(\.modelContext) private var modelContext
    @Query private var result: [CircleTestModel]
    
    var body: some View {
        ZStack {
            // Gradient background for a vibrant look
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header Section: Score, Time Left, Correct, Wrong
                HStack {
                    Text("Time Left: \(timerValue)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()

                    Spacer()

                    Text("Score: \(score)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()

                    Spacer()

                    Text("Correct: \(correctscore)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()

                    Spacer()

                    Text("Wrong: \(wrongscore)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
                   
                }
                
                Spacer()

                // Bubbles Section: Displaying bubbles to pop
                ZStack {
                    ForEach(bubbles) { bubble in
                        BubbleView(bubble: bubble) {
                            handleBubbleTapped(bubble: bubble)
                        }
                    }
                }
                .padding()

                Spacer()
                

                // Game Over Screen
                if gameOver {
                    NavigationLink(destination: MemoryMatchIntroView(), isActive: $gameOver) {
                        EmptyView()
                    }
                    .navigationBarBackButtonHidden(true)
//                    VStack {
//                        Text("Game Over")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 10)
//
//                        Text("Your Score: \(score)")
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 5)
//
//                        Text("Correct Taps: \(correctscore)")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 5)
//
//                        Text("Wrong Taps: \(wrongscore)")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 5)
//
//                        Text("Average Round Time: \(String(format: "%.2f", averageRoundTime)) seconds")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding(.bottom, 20)
//
//                        Button(action: resetGame) {
//                            Text("Play Again")
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.green)
//                                .cornerRadius(10)
//                                .shadow(radius: 5)
//                        }
//                        .padding(.horizontal, 40)
//                    }
//                    .padding()
//                    .background(Color.black.opacity(0.7))
//                    .cornerRadius(15)
//                    .shadow(radius: 10)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startGame()
        }
        .onChange(of: timerValue) { newValue in
            if newValue <= 0 {
                gameActive = false
                gameOver = true
                endRound() // Round ended
            }
        }
    }
    
    // Game Starting Logic
    func startGame() {
        score = 0
        correctscore = 0
        wrongscore = 0
        gameActive = true
        gameOver = false
        isStarted = false
        lastTappedValue = nil
        bubbles = generateBubbles()
        roundStartTime = nil // Reset round start time
        startTimer()
    }
    
    // Timer
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timerValue > 0 {
                timerValue -= 1
            } else {
                timer.invalidate()
                gameActive = false
                gameOver = true
                endRound() // Round ended
            }
        }
    }
    
    func generateBubbles() -> [Bubble] {
        var generatedBubbles: [Bubble] = []
        lastTappedValue = nil
        roundStartTime = Date()
        
        let randomBubbles = generateRandomValues()
        
        for value in randomBubbles {
            generatedBubbles.append(Bubble(id: UUID(), value: value, position: randomPosition()))
        }
        
        return generatedBubbles
    }
    
    func randomPosition() -> CGPoint {
        let x = CGFloat.random(in: 50...350)
        let y = CGFloat.random(in: 100...500)
        return CGPoint(x: x, y: y)
    }
    
    func generateRandomValues() -> [String] {
        var randomValues: [String] = []
        var generatedNumbers: Set<Int> = Set()
        var generatedLetters: Set<Character> = Set()

        if isNumberGame { // Use numbers
            while randomValues.count < totalBubbles {
                let randomNumber = Int.random(in: 1...1000)
                if !generatedNumbers.contains(randomNumber) {
                    generatedNumbers.insert(randomNumber)
                    randomValues.append("\(randomNumber)")
                }
            }
        } else { // Use letters
            while randomValues.count < totalBubbles {
                let randomLetter = Character(UnicodeScalar(Int.random(in: 65...90))!) // Random letter (A-Z)
                if !generatedLetters.contains(randomLetter) {
                    generatedLetters.insert(randomLetter)
                    randomValues.append("\(randomLetter)")
                }
            }
        }

        return randomValues
    }

    func handleBubbleTapped(bubble: Bubble) {
        // If the game hasn't started yet, initialize the game
        if !isStarted {
            isStarted = true
            lastTappedValue = "0" // Set the initial value for comparison
        }

        // Check for foul (user presses a bubble out of sequence)
        let isCorrectSequence = isNextBubbleLarger(current: bubble.value)
        
        // Pop the bubble regardless of whether it's correct or a foul
        if !isCorrectSequence {
            // Deduct points for foul
            score -= 1
            wrongscore += 1
        } else {
            // Correct tap
            correctscore += 1
            score += 1
        }
        
        // Update lastTappedValue with the current bubble's value if it's correct
        if isCorrectSequence {
            lastTappedValue = bubble.value
        }

        // Remove the bubble from the list
        removeBubble(bubble)
        
        // Check if all bubbles are popped and generate new ones
        if bubbles.isEmpty {
            endRound() // End the round
            bubbles = generateBubbles() // Start a new round
        }
    }

    func isNextBubbleLarger(current: String) -> Bool {
        // Check if the last tapped value exists
        if let lastTapped = lastTappedValue {
            // Numeric comparison if it's a number game
            if isNumberGame {
                if let currentValue = Int(current), let lastValue = Int(lastTapped) {
                    // The current value should be strictly larger than the last one tapped
                    if currentValue <= lastValue {
                        return false
                    }
                }
            } else { // Alphabetical comparison if it's a letter game
                if current <= lastTapped {
                    return false
                }
            }
        }
        return true
    }

    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
        }
    }

    func endRound() {
        // Only calculate round time if it's a new round
        if let startTime = roundStartTime {
            let roundTime = Date().timeIntervalSince(startTime)
            roundTimes.append(roundTime)
            
            // Calculate average round time
            let totalTime = roundTimes.reduce(0, +)
            averageRoundTime = totalTime / Double(roundTimes.count)
        }
    }

    func resetGame() {
        timerValue = 30
        score = 0
        correctscore = 0
        wrongscore = 0
        gameActive = true
        gameOver = false
        isStarted = false
        lastTappedValue = nil
        isNumberGame = Bool.random() // Randomly decide whether to use numbers or letters
        roundTimes = [] // Clear round times for the new game
        averageRoundTime = 0 // Reset average time
        startGame() // Start a new game
    }
}

struct Bubble: Identifiable {
    var id: UUID
    var value: String
    var position: CGPoint
}

struct BubbleView: View {
    var bubble: Bubble
    var onTap: () -> Void
    
    var body: some View {
        Text("\(bubble.value)")
            .font(.subheadline)
            .fontWeight(.bold)
            .frame(width: 80, height: 80)
            .background(Circle().fill(Color.blue).shadow(radius: 5))
            .foregroundColor(.white)
            .position(bubble.position)
            .onTapGesture {
                onTap()
            }
            .scaleEffect(1.1) // Slight zoom-in effect for interaction
            .animation(.easeInOut(duration: 0.3))
    }
}
