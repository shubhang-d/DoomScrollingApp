//
//  JournalEntry+CoreDataProperties.swift
//  doomScrolling
//
//  Created by Shubhang Dixit on 16/02/25.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var note: String?
    @NSManaged public var section: String?

}

extension JournalEntry : Identifiable {

}
