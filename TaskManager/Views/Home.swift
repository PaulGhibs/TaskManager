//
//  Home.swift
//  TaskManager
//
//  Created by Paul Ghibeaux on 13/01/2022.
//

import SwiftUI
// MARK: - Home VIEW
struct Home: View {
    
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
   
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: - Lazy stack with Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    // MARK: - Current week view
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(taskModel.currentWeek, id: \.self){ day in
                                
                                
                                VStack(spacing: 8) {
                                    // dd will return day as number
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd")).font(Font.custom("Avenir Next", size: 14)).fontWeight(.regular)
                                    
                                    // EEE will return day as MON, TUE
                                    Text(taskModel.extractDate(date: day, format: "EEE")).font(Font.custom("Avenir Next", size: 14)).fontWeight(.semibold)
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                           
                                }
                                
                                // MARK: - Foreground Style
                                
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary: .secondary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                // MARK: - Capsule Shape
                                .frame(width: 45, height: 90)
                            .background(
                                ZStack {
                                    
                                    // MARK: Matched Geometry Effect
                                    if taskModel.isToday(date: day){
                                        
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                    }
                                }
                        )
                                
                                .contentShape(Capsule())
                                .onTapGesture {
                                    // updating current day
                                    withAnimation {
                                        taskModel.currentDay = day }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    taskViews()
                } header: {
                    HeaderView()
                }
            }
        }
    }
    
    
    // - MARK: Task Views
    func taskViews() -> some View {
        LazyVStack(spacing: 18) {
            if let tasks = taskModel.filteredTasks {
                
                if tasks.isEmpty {
                    
                    Text("No tasks found !!")
                        .font(Font.custom("Avenir Next", size: 20))
                        .fontWeight(.semibold)
                        .offset(y: 100)
 
                } else {
                    
                    ForEach(tasks) { task in
                        
                        taskCardView(task: task)
                        
                    }
                }
                
            } else {
            // progress view
                ProgressView()
                    .offset(y: 100)
            }
        }
        
        // update tasks
        .onChange(of: taskModel.currentDay) { newValue in
            taskModel.filterTodayTasks()
        }
    }
    
    // - MARK: Task Card View
    func taskCardView(task: Task)-> some View {
        HStack{
            Text(task.taskTitle).font(Font.custom("Avenir Next", size: 22)).fontWeight(.semibold)
        }
    }
    
    // - MARK: Header
    func HeaderView()-> some View {
        HStack(spacing:10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray).font(Font.custom("Avenir Next", size: 15))
                Text("Today").font(Font.custom("Avenir Next", size: 30)).fontWeight(.bold)
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
            }
            
        }
        .padding()
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


