//
//  TaskListController.swift
//  To-Do Manager
//
//  Created by Даниил Асташов on 18.12.2024.
//

import UIKit

class TaskListController: UITableViewController {
    // порядок отображения задач по их статусу
    var tasksStatusPosition: [TaskStatus] = [.planned, .completed]
    // хранилище задач
    var tasksStorage: TasksStorageProtocol = TasksStorage()
    // коллекция задач
    var tasks: [TaskPriority:[TaskProtocol]] = [:] {
        didSet {
            for (tasksGroupPriority, tasksGroup) in tasks {
                tasks[tasksGroupPriority] = tasksGroup.sorted { task1, task2 in
                    let task1Position = tasksStatusPosition.firstIndex(of: task1.status) ?? 0
                    let task2Position = tasksStatusPosition.firstIndex(of: task2.status) ?? 0
                    return task1Position < task2Position
                }
            }
            
            // Сохраняем задачи после изменения
            var savingArray: [TaskProtocol] = []
            tasks.forEach { _, value in
                savingArray += value
            }
            print("Tasks to be saved: \(savingArray)") // Логирование перед сохранением
            tasksStorage.saveTasks(savingArray) // Сохраняем в хранилище
        }
    }

    // порядок отображения секций по типам
    // индекс в массиве соответствует индексу секции в таблице
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //можно установить программно
//        // Установка стиля таблицы программно (если это нужно)
//            if tableView.style != .grouped {
//                tableView = UITableView(frame: tableView.frame, style: .grouped)
//            }
//        // Настройка разделителей
//            tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//            tableView.separatorStyle = .singleLine
        // кнопка активации режима редактирования
         navigationItem.leftBarButtonItem = editButtonItem
        // загрузка задач
        loadTasks()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // получение списка задач, их разбор и установка в свойство tasks
    func setTasks(_ tasksCollection: [TaskProtocol]) {
        // подготовка коллекции с задачами
        // будем использовать только те задачи, для которых определена секция
        sectionsTypesPosition.forEach { taskType in
            tasks[taskType] = []
        }
        // загрузка и разбор задач из хранилища
        tasksCollection.forEach { task in
            tasks[task.type]?.append(task)
        }
    }
    private func loadTasks() {
        // подготовка коллекции с задачами
        // будем использовать только те задачи, для которых определена секция в таблице
        sectionsTypesPosition.forEach { taskType in
            tasks[taskType] = []
        }
        // загрузка и разбор задач из хранилища
        tasksStorage.loadTasks().forEach { task in
            tasks[task.type]?.append(task)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateScreen" {
            let destination = segue.destination as! TaskEditController
            destination.doAfterEdit = { [unowned self] title, type, status in
                let newTask = Task(title: title, type: type, status: status)
                tasks[type]?.append(newTask)
                tableView.reloadData()
            }
        }
    }
    // ручная сортировка списка задач
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // секция, из которой происходит перемещение
        let taskTypeFrom = sectionsTypesPosition[sourceIndexPath.section]
        // секция, в которую происходит перемещение
        let taskTypeTo = sectionsTypesPosition[destinationIndexPath.section]
        // безопасно извлекаем задачу, тем самым копируем ее
        guard let movedTask = tasks[taskTypeFrom]?[sourceIndexPath.row] else {
            return
        }
        // удаляем задачу с места, от куда она перенесена
        tasks[taskTypeFrom]!.remove(at: sourceIndexPath.row)
        // вставляем задачу на новую позицию
        tasks[taskTypeTo]!.insert(movedTask, at: destinationIndexPath.row)
        // если секция изменилась, изменяем тип задачи в соответствии с новой позицией
        if taskTypeFrom != taskTypeTo {
            tasks[taskTypeTo]![destinationIndexPath.row].type = taskTypeTo
        }
        // обновляем данные
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        // удаляем задачу
        tasks[taskType]?.remove(at: indexPath.row)
        // удаляем строку, соответствующую задаче
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->UISwipeActionsConfiguration? {
//         // получаем данные о задаче, которую необходимо перевести в статус "запланирована"
//         let taskType = sectionsTypesPosition[indexPath.section]
//         guard let _ = tasks[taskType]?[indexPath.row] else {
//             return nil
//         }
//         // проверяем, что задача имеет статус "выполнено"
//         guard tasks[taskType]![indexPath.row].status == .completed else {
//             return nil
//         }
//
//         // создаем действие для изменения статуса
//         let actionSwipeInstance = UIContextualAction(style: .normal, title: "Невыполнена") { _,_,_ in
//             self.tasks[taskType]![indexPath.row].status = .planned
//             self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
//         }
//         // возвращаем настроенный объект
//         return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
//    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     // получаем данные о задаче, по которой осуществлен свайп
     let taskType = sectionsTypesPosition[indexPath.section]
     guard let _ = tasks[taskType]?[indexPath.row] else {
         return nil
     }
     // действие для изменения статуса на "запланирована"
     let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполнена") { _,_,_ in
     self.tasks[taskType]![indexPath.row].status = .planned
     self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
     // действие для перехода к экрану редактирования
     let actionEditInstance = UIContextualAction(style: .normal, title: "Изменить") { _,_,_ in
         // загрузка сцены со storyboard
         let editScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TaskEditController") as!TaskEditController
         // передача значений редактируемой задачи
         editScreen.taskText = self.tasks[taskType]![indexPath.row].title
         editScreen.taskType = self.tasks[taskType]![indexPath.row].type
         editScreen.taskStatus = self.tasks[taskType]![indexPath.row].status
         // передача обработчика для сохранения задачи
         editScreen.doAfterEdit = { [self] title, type, status in
             let editedTask = Task(title: title, type: type, status: status)
             tasks[taskType]![indexPath.row] = editedTask
             tableView.reloadData()
         }
         // переход к экрану редактирования
         self.navigationController?.pushViewController(editScreen, animated: true)
     }
     // изменяем цвет фона кнопки с действием
     actionEditInstance.backgroundColor = .darkGray

     // создаем объект, описывающий доступные действия
     // в зависимости от статуса задачи будет отображено 1 или 2 действия
     let actionsConfiguration: UISwipeActionsConfiguration
     if tasks[taskType]![indexPath.row].status == .completed {
        actionsConfiguration = UISwipeActionsConfiguration(actions:
        [actionSwipeInstance, actionEditInstance])
     } else {
        actionsConfiguration = UISwipeActionsConfiguration(actions:
        [actionEditInstance])
     }
        return actionsConfiguration
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     // 1. Проверяем существование задачи
     let taskType = sectionsTypesPosition[indexPath.section]
     guard let _ = tasks[taskType]?[indexPath.row] else {
         return
     }
     // 2. Убеждаемся, что задача не является выполненной
     guard tasks[taskType]![indexPath.row].status == .planned else {
         // снимаем выделение со строки
         tableView.deselectRow(at: indexPath, animated: true)
         return
     }
     // 3. Отмечаем задачу как выполненную
     tasks[taskType]![indexPath.row].status = .completed
     // 4. Перезагружаем секцию таблицы
     tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    // количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    // количество строк в определенной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // определяем приоритет задач, соответствующий текущей секции
        let taskType = sectionsTypesPosition[section]
        guard let currentTasksType = tasks[taskType] else {
            return 0
        }
        return currentTasksType.count
    }
    // ячейка для строки таблицы
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        // ячейка на основе констрейнтов
        //return getConfiguredTaskCell_constraints(for: indexPath)
        // ячейка на основе стека
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    // ячейка на основе ограничений
    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstraints", for: indexPath)
        // получаем данные о задаче, которую необходимо вывести в ячейке
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell
        }
        // текстовая метка символа
        let symbolLabel = cell.viewWithTag(1) as? UILabel
        // текстовая метка названия задачи
        let textLabel = cell.viewWithTag(2) as? UILabel
        // изменяем символ в ячейке
        symbolLabel?.text = getSymbolForTask(with: currentTask.status)
        // изменяем текст в ячейке
        textLabel?.text = currentTask.title
        // изменяем цвет текста и символа
        if currentTask.status == .planned {
            textLabel?.textColor = .black
            symbolLabel?.textColor = .black
        } else {
            textLabel?.textColor = .lightGray
            symbolLabel?.textColor = .lightGray
        }
        return cell
    }
    // возвращаем символ для соответствующего типа задачи
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planned {
            resultSymbol = "\u{25CB}"
        } else if status == .completed {
            resultSymbol = "\u{25C9}"
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypesPosition[section]
        if tasksType == .important {
            title = "Важные"
        } else if tasksType == .normal {
            title = "Текущие"
        }
            return title
        }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 70 // Высота заголовка секции
//    }

    // ячейка на основе стека
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
     // загружаем прототип ячейки по идентификатору
         let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
         // получаем данные о задаче, которые необходимо вывести в ячейке
         let taskType = sectionsTypesPosition[indexPath.section]
         guard let currentTask = tasks[taskType]?[indexPath.row] else {
             return cell
         }

         // изменяем текст в ячейке
         cell.title.text = currentTask.title
         // изменяем символ в ячейке
         cell.symbol.text = getSymbolForTask(with: currentTask.status)

         // изменяем цвет текста
         if currentTask.status == .planned {
             cell.title.textColor = .black
             cell.symbol.textColor = .black
         } else {
             cell.title.textColor = .lightGray
             cell.symbol.textColor = .lightGray
         }
            return cell
    }
}
