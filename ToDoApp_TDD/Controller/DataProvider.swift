//
//  DataProvider.swift
//  ToDoApp_TDD
//
//  Created by Macbook on 03.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

enum Section: Int, CaseIterable {
    case todo
    case done
}

class DataProvider: NSObject {
    var taskManager: TaskManager?
}

extension DataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .todo: return "Done"
        case .done: return "Undone"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .todo:
            let task = taskManager?.task(at: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name("DidSelectRow notification"), object: self, userInfo: ["task": task])
        case .done: break
        }
    }
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else {
            fatalError()}
        
        guard let taskManager = taskManager else { return 0 }
        switch section {
        case .todo: return taskManager.tasksCount
        case .done: return taskManager.doneTasksCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self ), for: indexPath) as! TaskCell
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()}
        
        var task: Task!
        switch section {
        case .todo: task = taskManager?.task(at: indexPath.row)
        case .done: task = taskManager?.doneTask(at: indexPath.row)
        }
        
        if let task = task {
            cell.configure(withTask: task)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .todo: taskManager?.checkTask(at: indexPath.row)
        case .done: taskManager?.unCheckTask(at: indexPath.row)
        }
        
        tableView.reloadData()
        
    }
}
