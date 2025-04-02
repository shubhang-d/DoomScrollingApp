////
////  JournalScreen.swift
////  doomScrollingApp
////
////  Created by Shubhang Dixit on 16/02/25.
////
//
//import SwiftUI
//import CoreData
//
//struct JournalScreen: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        entity: JournalEntry.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.timestamp, ascending: true)]
//    ) var journalEntries: FetchedResults<JournalEntry>
//    
//    // State variables for new notes
//    @State private var newNote: String = ""
//    @State private var selectedSection: String = "What My Goals Are"
//    
//    // Default sections
//    let defaultSections = ["What My Goals Are", "What I Am Doing Right Now", "What I Have Achieved"]
//    @State private var customSections: [String] = []
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 20) {
//                    // Section Picker
//                    Picker("Select Section", selection: $selectedSection) {
//                        ForEach(defaultSections + customSections, id: \.self) { section in
//                            Text(section).tag(section)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//                    .background(Color(.systemBackground))
//                    .cornerRadius(10)
//                    .shadow(radius: 3)
//                    
//                    // Text Field for New Note
//                    TextField("Write your thoughts here...", text: $newNote)
//                        .padding()
//                        .background(Color(.systemBackground))
//                        .cornerRadius(10)
//                        .shadow(radius: 3)
//                        .padding(.horizontal)
//                    
//                    // Add Note Button
//                    Button(action: addNote) {
//                        HStack {
//                            Image(systemName: "plus")
//                                .font(.system(size: 20, weight: .bold))
//                            Text("Add Note")
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue.opacity(0.1))
//                        .foregroundColor(.blue)
//                        .cornerRadius(10)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.blue, lineWidth: 1)
//                        )
//                    }
//                    .padding(.horizontal)
//                    
//                    // List of Notes for Selected Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Notes in \(selectedSection)")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                            .padding(.horizontal)
//                        
//                        ForEach(journalEntries.filter { $0.section == selectedSection }, id: \.self) { entry in
//                            VStack(alignment: .leading, spacing: 5) {
//                                Text(entry.note ?? "")
//                                    .font(.body)
//                                Text(entry.timestamp ?? Date(), style: .date)
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                            }
//                            .padding()
//                            .background(Color(.systemBackground))
//                            .cornerRadius(10)
//                            .shadow(radius: 3)
//                            .padding(.horizontal)
//                        }
//                    }
//                    
//                    // Add New Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Add New Section")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                            .padding(.horizontal)
//                        
//                        TextField("New Section Name", text: "")
//                            .padding()
//                            .background(Color(.systemBackground))
//                            .cornerRadius(10)
//                            .shadow(radius: 3)
//                            .padding(.horizontal)
//                        
//                        Button(action: addSection) {
//                            HStack {
//                                Image(systemName: "plus")
//                                    .font(.system(size: 20, weight: .bold))
//                                Text("Add Section")
//                                    .font(.headline)
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.green.opacity(0.1))
//                            .foregroundColor(.green)
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.green, lineWidth: 1)
//                            )
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.vertical)
//            }
//            .navigationTitle("Journal Your Thoughts")
//            .background(Color(.systemGray6))
//        }
//    }
//    
//    // Function to add a new note
//    private func addNote() {
//        guard !newNote.isEmpty else { return }
//        
//        let entry = JournalEntry(context: viewContext)
//        entry.section = selectedSection
//        entry.note = newNote
//        entry.timestamp = Date()
//        
//        do {
//            try viewContext.save()
//            newNote = "" // Clear the text field
//        } catch {
//            print("Error saving note: \(error)")
//        }
//    }
//    
//    // Function to add a new section
//    private func addSection() {
//        guard !newNote.isEmpty else { return }
//        
//        customSections.append(newNote)
//        newNote = "" // Clear the text field
//    }
//}
//
//// Preview
////struct JournalScreen_Previews: PreviewProvider {
////    static var previews: some View {
////        JournalScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
////    }
////}
//
//#Preview{
//    JournalScreen()
//}
