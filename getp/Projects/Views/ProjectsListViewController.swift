//
//  ProjectsListViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectsListViewController: NSViewController {
    
    @IBOutlet weak var actionBar: NSBox!
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupUI()
        listenViewDragging()
        loadProjects()
    }
    
    func loadProjects() {
        GetpManager.shared.projectHanlder.loadProjects { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func listenViewDragging() {
        if let dragableView = view as? ProjectsListView {
            dragableView.dragSuccessCallback = { [weak self] paths in
                self?.tableView.reloadData()
            }
        }
    }

    func setupUI() {
        // 设置action bar
        let actionBarViewController = ProjectsActionBarViewController(nibName: "ProjectsActionBarViewController", bundle: nil)
        actionBarViewController.dragSuccessCallback = { [weak self] _ in
            self?.tableView.reloadData()
        }
        let actionBarView = actionBarViewController.view
        addChild(actionBarViewController)
        actionBar.contentView = actionBarView
        actionBarView.setEdgeConstraints(equal: actionBar)
        
        // 设置tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.usesAutomaticRowHeights = true
        tableView.allowsTypeSelect = true
        tableView.register(NSNib(nibNamed: "ProjectCell", bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"))
        
        let cellMenu = NSMenu(title: "菜单")
        tableView.menu = cellMenu
        
        let deleteItem = NSMenuItem(title: "删除", action: #selector(onClickMenuDelete), keyEquivalent: "")
        cellMenu.addItem(deleteItem)
    }
    
    @objc private func onClickMenuDelete() {
        let needToDeleteIndex = tableView.clickedRow
        if let project = GetpManager.shared.projectHanlder.project(at: needToDeleteIndex) {
            GetpManager.shared.projectHanlder.deleteProject(project: project)
            tableView.reloadData()
        }
    }
}

extension ProjectsListViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return GetpManager.shared.projectHanlder.projectsCount
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: nil)
        if let projectCell = cell as? ProjectCell {
            projectCell.model = GetpManager.shared.projectHanlder.project(at: row)
        }
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let tableView = notification.object as? NSTableView {
            // 选中项: -1表示未选中
            findProjectsViewController()?.detailViewController.model = GetpManager.shared.projectHanlder.project(at: tableView.selectedRow)
        }
    }
}

