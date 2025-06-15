//
//  home.swift
//  mutual
//
//  Created by Marc Jiang on 6/14/25.
//

import UIKit




class HomePage: Base, UITableViewDelegate, UITableViewDataSource {
    let temp_names: [String] = ["Liam", "Ava", "Noah", "Sophia", "Ethan"]
    let temp_messages = [
        "I'm near the fountain now...",
        "Are you wearing the red hat...",
        "Just parked, walking over...",
        "You said by the coffee shop...",
        "I think I see you coming..."
    ]
    let dates = [
        "1 hour ago",
        "Yesterday",
        "Tuesday",
        "May 10",
        "January 5, 2022"
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = exampleChat()
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: false)
        nav.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true)
        self.present(nav, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let img = UIImageView()
        img.backgroundColor = .white
        img.tintColor = .black
        img.image = UIImage(systemName: "person.crop.circle")
        img.contentMode = .scaleAspectFill
        img.frame = CGRect(x: 10, y: 15, width: 50, height: 50)
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.borderWidth = 1
        img.layer.cornerRadius = 25
        
        let name_label = UILabel()
        name_label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        name_label.textColor = .white
        name_label.backgroundColor = .clear
        name_label.textAlignment = .left
        name_label.text = temp_names[indexPath.row]
        name_label.numberOfLines = 1
        name_label.adjustsFontSizeToFitWidth = true
        name_label.frame = CGRect(x: img.frame.maxX + 10, y: 15, width: cell.contentView.frame.width/3, height: 25)
        let msg = UILabel()
        msg.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        msg.textColor = .white
        msg.backgroundColor = .clear
        msg.textAlignment = .left
        msg.text = temp_messages[indexPath.row]
        msg.numberOfLines = 1
        msg.adjustsFontSizeToFitWidth = true
        msg.frame = CGRect(x: img.frame.maxX + 10, y: 40, width: cell.contentView.frame.width/3, height: 30)
        
        cell.contentView.addSubview(img)
        cell.contentView.addSubview(name_label)
        cell.contentView.addSubview(msg)
        
        let d = UILabel()
        d.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        d.textColor = .white
        d.backgroundColor = .clear
        d.textAlignment = .right
        d.text = dates[indexPath.row]
        d.numberOfLines = 1
        d.adjustsFontSizeToFitWidth = true
        d.frame = CGRect(x: cell.contentView.frame.maxX - 90, y: 15, width: 80, height: 30)
        
        cell.contentView.addSubview(img)
        cell.contentView.addSubview(name_label)
        cell.contentView.addSubview(msg)
        cell.contentView.addSubview(d)
        return cell
    }
    
    lazy var table : UITableView = {
       let tb = UITableView()
        tb.delegate = self
        tb.frame = view.bounds
        tb.dataSource = self
        tb.backgroundColor = .black
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tb.separatorColor = .white
        
        return tb
    }()
    func setup() {
        view.addSubview(table)
    }

    
    override func viewDidLoad() {
        setup()
        view.backgroundColor = .black
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true
    }
}

class profilePage: Base{
    lazy var profileView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.frame = view.bounds
        img.image = UIImage(named: "Profile_Example")
        img.contentMode = .scaleAspectFit
        return img
    }()
    override func viewDidLoad() {
        view.addSubview(profileView)
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true
    }
}
class exampleChat: Base{
    lazy var image: UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .clear
        img.image = UIImage(named: "Chat_Example")
        img.contentMode = .scaleAspectFit
        img.frame = view.bounds
        img.clipsToBounds = true
        return img
    }()
    lazy var returnBT: UIButton = {
       let bt = UIButton()
        bt.frame = CGRect(x: 30, y: 50, width: 36, height: 36)
        bt.setImage(UIImage(systemName: "arrowshape.backward.circle"), for: .normal)
        bt.tintColor = .black
        bt.imageView?.contentMode = .scaleAspectFill
        bt.contentHorizontalAlignment = .fill
        bt.contentVerticalAlignment = .fill
        bt.addTarget(self, action: #selector(handle_dismiss), for: .touchUpInside)
        return bt
    }()
    override func viewDidLoad() {
        view.addSubview(image)
        view.addSubview(returnBT)
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }
    @objc func handle_dismiss(sender: UIButton){
        sender.pressBT()
        self.dismiss(animated: true)
    }
}


class exampleAward: Base{
    lazy var image: UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .clear
        img.image = UIImage(named: "Award_Example")
        img.contentMode = .scaleAspectFit
        img.frame = view.bounds
        img.clipsToBounds = true
        return img
    }()
    lazy var returnBT: UIButton = {
       let bt = UIButton()
        bt.frame = CGRect(x: 30, y: 50, width: 36, height: 36)
        bt.setImage(UIImage(systemName: "arrowshape.backward.circle"), for: .normal)
        bt.tintColor = .black
        bt.imageView?.contentMode = .scaleAspectFill
        bt.contentHorizontalAlignment = .fill
        bt.contentVerticalAlignment = .fill
        bt.addTarget(self, action: #selector(handle_dismiss), for: .touchUpInside)
        return bt
    }()
    override func viewDidLoad() {
        view.addSubview(image)
        view.addSubview(returnBT)
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
    }
    @objc func handle_dismiss(sender: UIButton){
        sender.pressBT()
        self.dismiss(animated: true)
    }
}
