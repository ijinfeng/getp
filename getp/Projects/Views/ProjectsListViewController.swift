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
    }
    

    func setupUI() {
        // 设置action bar
        let actionBarViewController = ProjectsActionBarViewController(nibName: "ProjectsActionBarViewController", bundle: nil)
        let actionBarView = actionBarViewController.view
        addChild(actionBarViewController)
        actionBar.contentView = actionBarView
        actionBarView.setEdgeConstraints(equal: actionBar)
        
        // 设置tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NSNib(nibNamed: "ProjectCell", bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"))
        
        let cellMenu = NSMenu(title: "菜单")
        tableView.menu = cellMenu
        
        let deleteItem = NSMenuItem(title: "删除", action: #selector(onClickMenuDelete), keyEquivalent: "")
        cellMenu.addItem(deleteItem)
    }
    
    @objc private func onClickMenuDelete() {
        print("点击删除")
    }
}

extension ProjectsListViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 14
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: nil)
        return cell
    }
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        let row = tableView.selectedRow
        print("row: \(row)")
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
}

