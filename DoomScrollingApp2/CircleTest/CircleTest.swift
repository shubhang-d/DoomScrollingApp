import SwiftUI

struct ReactionTimeView: View {
    @State private var currentShape: String = "circle"
    @State private var currentColor: Color = .red
    @State private var reactionStartTime: Date?
    @State private var correctTaps: Int = 0
    @State private var incorrectTaps: Int = 0
    @State private var totalReactionTime: Double = 0
    @State private var timerValue: Int = 30
    @State private var showingResult: Bool = false
    @State private var reactionTimes: [Double] = []
    @State private var shapePosition: CGPoint = CGPoint(x: 0, y: 0) // Track the position of the shape
    @State private var shapeSize: CGSize = CGSize(width: 100, height: 100) // Track the size of the shape
    
    let shapes = ["circle", "square", "triangle"]
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]
    
    var body: some View {
        VStack {
            Text("Reaction Time Test")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            if showingResult {
                VStack {
                    Text("Results")
                        .font(.title)
                        .padding()
                    Text("Correct Taps: \(correctTaps)")
                    Text("Incorrect Taps: \(incorrectTaps)")
                    Text("Average Reaction Time: \(averageReactionTime()) seconds")
                }
                .padding()
            } else {
                Text("Time Left: \(timerValue) seconds")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.gray)
                
                ZStack {
                    // Render the shape at a random position
                    renderShape()
                    
                    // Add tap gesture to detect incorrect taps
                    GeometryReader { geometry in
                        Color.clear
                            .onTapGesture { location in
                                handleTap(location: location, in: geometry.size)
                            }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            startTest()
        }
        .alert(isPresented: $showingResult) {
            Alert(title: Text("Test Over"),
                  message: Text("Correct Taps: \(correctTaps)\nIncorrect Taps: \(incorrectTaps)\nAverage Reaction Time: \(averageReactionTime()) seconds"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    func startTest() {
        var timeRemaining = 30
        self.timerValue = timeRemaining
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                self.timerValue = timeRemaining
            } else {
                timer.invalidate()
                self.showingResult = true
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                randomizeShapeAndColor()
            }
        }
    }
    
    func randomizeShapeAndColor() {
        let randomShape = shapes.randomElement()!
        let randomColor = colors.randomElement()!
        
        self.currentShape = randomShape
        self.currentColor = randomColor
        self.shapePosition = CGPoint(x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 100),
                                     y: CGFloat.random(in: 100...UIScreen.main.bounds.height - 200))
        
        reactionStartTime = Date()
    }
    
    func renderShape() -> some View {
        Group {
            if currentShape == "circle" {
                Circle()
                    .frame(width: shapeSize.width, height: shapeSize.height)
                    .foregroundColor(currentColor)
                    .position(shapePosition)
                    .onTapGesture {
                        handleCorrectTap()
                    }
            } else if currentShape == "square" {
                Rectangle()
                    .frame(width: shapeSize.width, height: shapeSize.height)
                    .foregroundColor(currentColor)
                    .position(shapePosition)
                    .onTapGesture {
                        handleCorrectTap()
                    }
            } else if currentShape == "triangle" {
                Triangle()
                    .frame(width: shapeSize.width, height: shapeSize.height)
                    .foregroundColor(currentColor)
                    .position(shapePosition)
                    .onTapGesture {
                        handleCorrectTap()
                    }
            }
        }
    }
    
    func handleCorrectTap() {
        if let startTime = reactionStartTime {
            let reactionTime = Date().timeIntervalSince(startTime)
            correctTaps += 1
            reactionTimes.append(reactionTime)
            randomizeShapeAndColor()
        }
    }
    
    func handleTap(location: CGPoint, in size: CGSize) {
        // Calculate shape's bounds
        let shapeRect = CGRect(x: shapePosition.x - shapeSize.width / 2,
                               y: shapePosition.y - shapeSize.height / 2,
                               width: shapeSize.width,
                               height: shapeSize.height)
        
        // Check if the tap is inside the shape's bounds
        if shapeRect.contains(location) {
            // Tap was on the shape, so count as a correct tap
            handleCorrectTap()
        } else {
            // Tap was outside the shape, count as an incorrect tap
            incorrectTaps += 1
        }
    }
    
    func averageReactionTime() -> String {
        if reactionTimes.isEmpty {
            return "N/A"
        }
        
        let totalTime = reactionTimes.reduce(0, +)
        let averageTime = totalTime / Double(reactionTimes.count)
        return String(format: "%.2f", averageTime)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

