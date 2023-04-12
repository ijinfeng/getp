//
//  PreferenceViewController.swift
//  getp
//
//  Created by JinFeng on 2023/4/12.
//

import Cocoa

class PreferenceViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func onClickTest(_ sender: Any) {
        let finder = FinderManager.shared
        try? finder.open(at: finder.getLoginUserPath())
    }
}
