//
//  ChannelVC.swift
//  chatapp
//
//  Created by Javid Poornasir on 7/18/17.
//  Copyright © 2017 Javid Poornasir. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwindSegue(segue: UIStoryboardSegue){ }
    @IBOutlet weak var userImg: CircleImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tv.delegate = self; tv.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
       listenForNotif()
        SocketService.instance.getChannel { (success) in
            if success {
                self.tv.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setupUserInfo()
    }

    func listenForNotif() {
         NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
       setupUserInfo()
    }
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            // show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            // show loginVC
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
            
        }
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }

    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tv.dequeueReusableCell(withIdentifier: "channelcell", for: indexPath) as? ChannelCell {
            
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count 
    }
    
    
    
}
