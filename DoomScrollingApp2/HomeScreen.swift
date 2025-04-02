import SwiftUI
import Charts

struct HomeScreen: View {
    // Sample data for the chart
    @State private var testResultsData: [TestResult] = [
        TestResult(day: "Mon", score: 3),
        TestResult(day: "Tue", score: 5),
        TestResult(day: "Wed", score: 4),
        TestResult(day: "Thu", score: 7),
        TestResult(day: "Fri", score: 6),
        TestResult(day: "Sat", score: 8),
        TestResult(day: "Sun", score: 9)
    ]
    
    // Sample exercises
    let exercises: [Exercise] = [
        Exercise(name: "5-Minute Meditation", icon: "brain.head.profile"),
        Exercise(name: "Read a Book", icon: "book"),
        Exercise(name: "Take a Walk", icon: "figure.walk"),
        Exercise(name: "Journal Your Thoughts", icon: "pencil")
    ]
    
    // State to control navigation to the test screen
    @State private var isShowingTestScreen = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hello, User!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("Let's make today productive and mindful.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Take a Test Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "pencil.and.list.clipboard")
                                .foregroundColor(.green)
                            Text("Take a Test")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        Text("Assess your current focus and mindfulness level.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // NavigationLink to the Test Screen
                        NavigationLink(destination: ReactionTimeIntroView(), isActive: $isShowingTestScreen) {
                            HStack {
                                Image(systemName: "plus")
                                    .font(.system(size: 20, weight: .bold))
                                Text("Start Test")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Test Results Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.blue)
                            Text("Your Test Results")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        Chart(testResultsData) { result in
                            BarMark(
                                x: .value("Day", result.day),
                                y: .value("Score", result.score)
                            )
                            .foregroundStyle(Color.blue.gradient)
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    
                    // Exercises Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "heart.text.square.fill")
                                .foregroundColor(.orange)
                            Text("Exercises to Reduce Doom Scrolling")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        ForEach(exercises, id: \.name) { exercise in
                            ExerciseCard(exercise: exercise)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Mindful Scroll")
            .background(Color(.systemGray6))
        }
    }
}


// Exercise Card View
struct ExerciseCard: View {
    let exercise: Exercise
    
    var body: some View {
        HStack {
            Image(systemName: exercise.icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            
            Text(exercise.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

// Data Models
struct TestResult: Identifiable {
    let id = UUID()
    let day: String
    let score: Int
}

struct Exercise {
    let name: String
    let icon: String
}


