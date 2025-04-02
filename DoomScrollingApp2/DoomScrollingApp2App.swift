//
//  DoomScrollingApp2App.swift
//  DoomScrollingApp2
//
//  Created by Shubhang Dixit on 02/04/25.
//

import SwiftUI
import SwiftData

@main
struct DoomScrollingApp2App: App {
    @Environment(\.modelContext) var modelContext
    var body: some Scene {
        WindowGroup {
//            ContentView().environment(\.managedObjectContext,
//                                       dataController.container.viewContext)
//            ReactionTimeViewController()
//            ReactionTimeViewControllerWrapper()
//            SpriteKitView().edgesIgnoringSafeArea(.all)
//            MemoryMatchGameViewController()
//            BubbleGameView()
//            StroopTest()
            StroopTestIntroView()
//            FocusBubbleIntroView()
//            MemoryMatchIntroView()
//            ReactionTimeIntroView()
//            HomeScreen()
//            BreathableScreen()
        }
        .modelContainer(for: CircleTestModel.self)
    }
}
