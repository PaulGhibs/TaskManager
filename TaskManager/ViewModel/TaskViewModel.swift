//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Paul Ghibeaux on 13/01/2022.
//

import Foundation
import SwiftUI

//
class TaskViewModel : ObservableObject {
    
    // MARK: - Sample Tasks
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Meeting", taskDescription: "Discuss team task fir the day", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "Icon Set", taskDescription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "Check asset", taskDescription: "Start checking the assets ", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "Team Party", taskDescription: "Make fun with team mates", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "Client Meeting", taskDescription: "Explain project to client", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "Next Project", taskDescription: "Discuss next steps with team", taskDate: .init(timeIntervalSince1970: 1642118400)), Task(taskTitle: "App Proposal", taskDescription: "Meet client for app proposal", taskDate: .init(timeIntervalSince1970: 1642118400))]
    
    
    // MARK: - Current Week Days
    @Published var currentWeek : [Date] = []
    // MARK: - Current Day
    @Published var currentDay: Date = Date()
    
    // tab filtered Today Tasks
    @Published var filteredTasks: [Task]?
    // MARK: - Init
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    // MARK: - Methods
    // Filtering Today Tasks
    
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    // fectch current week

    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekDay)
            }
                
        }
    }
    
    
    
    // MARK: - Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    // Check if current Date is Today
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
