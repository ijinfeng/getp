//
//  TestViewController.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

import Cocoa

class TestViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    
    
    @IBAction func onClickExists(_ sender: NSButton) {
        do {
            try SupportedApps.terminal.app.open(in: "/Users/niren/Desktop")
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func onClickOpenApp(_ sender: NSButton) {
        let desktop = FinderManager.shared.getDesktopPath()
        print(desktop)
        let userpath = FinderManager.shared.getLoginUserPath()
        print(userpath)
    }
}
