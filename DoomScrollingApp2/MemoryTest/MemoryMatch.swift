import SwiftUI

// Example icon data
let iconImages = ["circle.fill", "triangle.fill", "square.fill", "star.fill", "moon.fill", "heart.fill", "diamond.fill", "sun.max.fill", "cloud.fill", "flame.fill", "leaf.fill", "bolt.fill"]

// Game View
struct MemoryMatchGameViewController: View {
    @State private var sequence: [String] = []
    @State private var userSequence: [String] = []
    @State private var isFeedbackVisible = false
    @State private var feedbackMessage = ""
    @State private var timer: Timer?
    @State private var timeLeft = 30
    @State private var gameOver = false
    @State private var isSequenceDisplayed = false
    @State private var gameStarted = false
    @State private var displayedIconsCount = 0 // Track the number of displayed icons
    @State private var gameStartTime: Date? // Track the time when the game starts
    @State private var totalGamesPlayed = 0
    @State private var totalWins = 0
    @State private var totalLosses = 0
    @State private var totalTimeToEnterSequence: Double = 0 // Track total time spent entering sequences
    @State private var sequenceGenerated = false // Flag to track if the sequence has been generated

    let sequenceLength = 5
    
    var body: some View {
        VStack {
            // Super Timer
            Text("Time Left: \(timeLeft)s")
                .font(.headline)
                .padding()
                .background(timeLeft < 5 ? Color.red : Color.green)
                .cornerRadius(8)
                .foregroundColor(.white)
            
            // Sequence Display (Appears one by one)
            if isSequenceDisplayed {
                HStack(spacing: 20) {
                    ForEach(0..<displayedIconsCount, id: \.self) { index in
                        Image(systemName: sequence[index])
                            .font(.system(size: 30)) // Make the icons smaller but still visible
                            .padding()
                            .transition(.opacity)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Spacer()
            
            // User Input Sequence Display
            HStack {
                ForEach(0..<userSequence.count, id: \.self) { index in
                    Image(systemName: userSequence[index])
                        .font(.largeTitle)
                        .padding()
                }
            }
            .padding()
            
            Spacer()
            
            // Icon Buttons (12 buttons)
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(0..<iconImages.count, id: \.self) { index in
                    Button(action: {
                        if userSequence.count < sequenceLength {
                            userSequence.append(iconImages[index])
                        }
                    }) {
                        Image(systemName: iconImages[index])
                            .font(.largeTitle)
                            .padding()
                            .background(Circle().fill(Color.blue.opacity(0.2)))
                            .foregroundColor(.blue)
                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                    }
                    .disabled(userSequence.count >= sequenceLength || gameOver || !sequenceGenerated) // Disable until sequence is generated
                }
            }
            .padding()
            
            // Feedback Message
            if isFeedbackVisible {
                Text(feedbackMessage)
                    .font(.title)
                    .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)
                    .bold()
                    .padding()
                    .transition(.opacity)
            }
            
            // Show Result
            if gameOver {
                NavigationLink(destination: StroopTestIntroView(), isActive: $gameOver) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
//                VStack {
//                    Text("Game Over!")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//                    
//                    Text("Games Played: \(totalGamesPlayed)")
//                    Text("Games Won: \(totalWins)")
//                    Text("Games Lost: \(totalLosses)")
//                    Text("Average Time to Enter Correct Sequence: \(averageTimeToEnterSequence(), specifier: "%.2f") seconds")
//                        .padding(.top)
//                }
//                .padding()
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(radius: 10)
//                .transition(.opacity)
            }
        }
        .padding([.top], 20)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer() // Start the timer when the view appears
            startNewGame()
        }
        .onChange(of: timeLeft) { newValue in
            if newValue == 0 {
                gameOver = true
                stopTimer()
                showFinalResult() // Show the result when time is over
            }
        }
        .onChange(of: userSequence) { newSequence in
            // Auto-check the sequence when user has entered the correct number of icons
            if newSequence.count == sequenceLength {
                checkSequence()
            }
        }
    }
    
    // Start a new game (showing sequence)
    func startNewGame() {
        resetGame()
        showSequence()
        gameStarted = true
        gameStartTime = Date() // Track the start time of the game
        sequenceGenerated = false // Mark sequence as not generated yet
    }
    
    func resetGame() {
        sequence = []
        userSequence = []
        feedbackMessage = ""
        isFeedbackVisible = false
        gameOver = false
        isSequenceDisplayed = false
        displayedIconsCount = 0
    }
    
    // Show a random sequence to the user
    func showSequence() {
        // Generate random sequence
        for _ in 0..<sequenceLength {
            let randomIcon = iconImages.randomElement()!
            sequence.append(randomIcon)
        }
        
        // Animate sequence display
        withAnimation {
            isSequenceDisplayed = true
        }
        
        // Display each icon with a delay
        for index in 0..<sequence.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.0) { // 1 second delay for each icon
                displayedIconsCount = index + 1
            }
        }
        
        // After the sequence is shown, allow user input
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(sequence.count) * 1.0 + 1.0) {
            // After all icons are displayed, let the user start entering their sequence
            isSequenceDisplayed = false
            sequenceGenerated = true // Mark the sequence as fully displayed
            incrementGamesPlayed() // Now count this game as played
        }
    }
    
    // Start countdown timer
    func startTimer() {
        if timer != nil {
            // Timer is already running, no need to start it again
            return
        }
        
        timer?.invalidate() // Invalidate any previous timer to avoid duplicates
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeLeft > 0 && !gameOver {
                timeLeft -= 1
            }
        }
    }
    
    // Stop the timer
    func stopTimer() {
        timer?.invalidate()
    }
    
    // Check if the user’s sequence matches the original sequence
    func checkSequence() {
        // Ensure user entered exactly the correct number of icons
        if userSequence.count == sequenceLength {
            let gameTime = Date().timeIntervalSince(gameStartTime!) // Calculate time taken to enter sequence
            totalTimeToEnterSequence += gameTime
            
            if userSequence == sequence {
                feedbackMessage = "Correct!"
                totalWins += 1
            } else {
                feedbackMessage = "Incorrect"
                totalLosses += 1
            }
            
            isFeedbackVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                startNewGame()
            }
        } else {
            feedbackMessage = "Please enter \(sequenceLength) icons"
            isFeedbackVisible = true
        }
    }

    // Show final result when time is over
    func showFinalResult() {
        if userSequence == sequence {
            feedbackMessage = "You won!"
            totalWins += 1
        } else {
            feedbackMessage = "You lost!"
            totalLosses += 1
        }
        isFeedbackVisible = true
    }
    
    // Increment games played count when a new game starts
    func incrementGamesPlayed() {
        if sequenceGenerated {  // Only increment if the sequence is fully generated
            totalGamesPlayed += 1
        }
    }
    
    // Calculate average time to enter correct sequence
    func averageTimeToEnterSequence() -> Double {
        return totalGamesPlayed > 0 ? totalTimeToEnterSequence / Double(totalGamesPlayed) : 0
    }
}


