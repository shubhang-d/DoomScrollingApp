import SwiftUI
import AVFoundation

// Breath Timer Logic
class BreathTimer: ObservableObject {
    @Published var timeRemaining = 0
    @Published var isActive = false
    @Published var currentPhase: BreathPhase = .inhale
    var timer: Timer? = nil
    
    enum BreathPhase {
        case inhale, hold, exhale
    }
    
    private let inhaleDuration: Int = 4
    private let holdDuration: Int = 7
    private let exhaleDuration: Int = 8
    
    func start() {
        isActive = true
        timeRemaining = inhaleDuration
        
        // Start breathing cycle
        startBreathingCycle()
    }
    
    func stop() {
        isActive = false
        timer?.invalidate()
    }
    
    private func startBreathingCycle() {
        currentPhase = .inhale
        startPhaseTimer(duration: inhaleDuration)
    }
    
    private func startPhaseTimer(duration: Int) {
        timer?.invalidate()
        timeRemaining = duration
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.nextPhase()
            }
        }
    }
    
    private func nextPhase() {
        switch currentPhase {
        case .inhale:
            currentPhase = .hold
            startPhaseTimer(duration: holdDuration)
        case .hold:
            currentPhase = .exhale
            startPhaseTimer(duration: exhaleDuration)
        case .exhale:
            currentPhase = .inhale
            startPhaseTimer(duration: inhaleDuration)
        }
    }
}

// Meditation Voice Instructions
class MeditationVoice: ObservableObject {
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    func speakInstruction(phase: BreathTimer.BreathPhase) {
        var message = ""
        
        switch phase {
        case .inhale:
            message = "Focus on your breath. Inhale slowly for 4 seconds."
        case .hold:
            message = "Hold your breath now for 7 seconds."
        case .exhale:
            message = "Exhale slowly for 8 seconds."
        }
        
        let utterance = AVSpeechUtterance(string: message)
        let voices = AVSpeechSynthesisVoice.speechVoices()
        print(voices)
        if let rishiVoice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-IN.Rishi") {
                    utterance.voice = rishiVoice
                } else {
                    // Fallback to a default voice if the desired one is not available
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Default English
                }
        utterance.rate = 0.6
        utterance.pitchMultiplier = 1.1
        
        speechSynthesizer.speak(utterance)
    }
}

struct BreathableScreen: View {
    @StateObject private var breathTimer = BreathTimer()
    @StateObject private var meditationVoice = MeditationVoice()
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Text("\(breathTimer.timeRemaining)")
                .font(.system(size: 120, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 250, height: 250)
                .background(Circle().fill(Color.blue))
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .opacity(isAnimating ? 0.7 : 1.0)
                .onAppear {
                    startBreathingAnimation()
                }
                .onChange(of: breathTimer.currentPhase) { phase in
                    meditationVoice.speakInstruction(phase: phase)
                    withAnimation {
                        isAnimating.toggle()
                    }
                }
            
            
            Button(action: {
                if breathTimer.isActive {
                    breathTimer.stop()
                } else {
                    breathTimer.start()
                }
            }) {
                Text(breathTimer.isActive ? "Stop" : "Start")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Capsule().fill(Color.green))
            }
            .padding([.top], 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures full screen coverage
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func startBreathingAnimation() {
        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            isAnimating.toggle()
        }
    }
}

