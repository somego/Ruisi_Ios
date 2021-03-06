//
//  SettingViewController.swift
//  Ruisi
//
//  Created by yang on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

import UIKit

// 设置
class SettingViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var networkChangeSwitch: UISegmentedControl!
    @IBOutlet weak var networkNoticeLabel: UILabel!
    
    @IBOutlet weak var tailContentTextVIew: UITextView!
    @IBOutlet weak var showZhidingSwitch: UISwitch!
    @IBOutlet weak var enableTailSwitch: UISwitch!
    
    private let defaultTail = "[size=1][color=Gray]-----来自[url=\(Urls.getPostUrl(tid: App.POST_ID))]手机睿思IOS版[/url][/color][/size]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        showZhidingSwitch.isOn = Settings.showZhiding
        enableTailSwitch.isOn = Settings.enableTail
        tailContentTextVIew.text = Settings.tailContent
        tailContentTextVIew.isEditable = enableTailSwitch.isOn
        tailContentTextVIew.text = Settings.tailContent ?? defaultTail
        
        //CFBundleVersion
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "当前版本:\(version) Build:\(Bundle.main.infoDictionary?["CFBundleVersion"] ?? "1")"
        } else {
            versionLabel.text = "获取版本号出错"
        }
        
        networkChangeSwitch.selectedSegmentIndex = Settings.networkType
        setNetworkTypeText()
    }
    
    private func setNetworkTypeText() {
        if networkChangeSwitch.selectedSegmentIndex == 0 {
            networkNoticeLabel.text = "判断类型为:\(App.isSchoolNet ? "校园网" : "外网")"
        } else if networkChangeSwitch.selectedSegmentIndex == 1 {
            networkNoticeLabel.text = "当前选择:外网"
        } else {
            networkNoticeLabel.text = "当前选择:校园网"
        }
    }
    
    // 是否显示置顶帖
    @IBAction func showZhidingValueChange(_ sender: UISwitch) {
        print("hide zhiding \(sender.isOn)")
        Settings.showZhiding = sender.isOn
    }
    
    
    // 切换网络类型
    @IBAction func networkValueChange(_ sender: UISegmentedControl) {
        Settings.networkType = sender.selectedSegmentIndex
        setNetworkTypeText()
        
        if sender.selectedSegmentIndex == 1 {
            showAlert(title: "提示", message: "网络类型已切换为外网,此设置校园网也可访问,如校园网没流量可设置为自动或校园网")
            App.isSchoolNet = false
        } else if sender.selectedSegmentIndex == 2 {
            showAlert(title: "提示", message: "网络类型已切换为校园网,此设置不在校园网是无法访问的(如4G流量),如果无法访问请设回自动或者外网")
            App.isSchoolNet = true
        } else {
            showAlert(title: "提示", message: "网络类型已切换为自动判断,下次重启后开始生效")
        }

        print("chnage network, auro:\(sender.selectedSegmentIndex == 0) is school net:\(App.isSchoolNet)")
    }
    
    
    // 是否允许小尾巴
    @IBAction func showTailValueChane(_ sender: UISwitch) {
        Settings.enableTail = sender.isOn
        tailContentTextVIew.isEditable = enableTailSwitch.isOn
    }
    
    // 小尾巴编辑结束
    override func viewWillDisappear(_ animated: Bool) {
        Settings.tailContent = tailContentTextVIew.text
    }
    
    
    @IBAction func viewOnGitHubClick(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/freedom10086/Ruisi_Ios") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func cleanCacheClick(_ sender: UIButton) {
        showAlert(title: "还没做", message: "待以后完成，欢迎提供你的建议")
    }
    
}
