//
//  TabBar.swift
//  mutual
//
//  Created by Marc Jiang on 6/14/25.
//

import Foundation
import UIKit
import UserNotifications
import CoreLocation


let home_page = HomePage()
let chat_page = exampleAward()
let my_account = profilePage()




let v1 = UINavigationController(rootViewController: home_page)
let v2 = UINavigationController(rootViewController: chat_page)
let v3 = UINavigationController(rootViewController: my_account)


var vcs: [UINavigationController] = [v1,v2,v3]

class CustomTabBar : Base, CLLocationManagerDelegate{
    
    
    let BAR_COLOR : UIColor = UIColor.white
    let BAR_SELECTED_COLOR : UIColor = UIColor(displayP3Red: 69/255, green: 69/255, blue: 69/255, alpha: 0.25)
    let BAR_ITEM_BG_COLOR : UIColor = UIColor.clear
    let BAR_UNSELECTED_BG_COLOR : UIColor = UIColor.black
    let BAR_SELECTED_BG_COLOR : UIColor = UIColor.white
    let BAR_SELECTED_TINT_COLOR : UIColor = UIColor.black
    let BAR_UNSELECTED_TINT_COLOR : UIColor = UIColor.white
    
    
    
    let item_imgs = [ "house","medal.fill","person.crop.circle"]
    
    
    
    func setup_TabBar(n : Int) {
        for i in 0..<vcs.count {
            let item = vcs[i]
            addChild(item)
            item.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(item.view)
            item.view!.topAnchor.constraint(equalTo: view.topAnchor,constant: 0).isActive = true
            item.view!.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
            item.view!.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
            item.view!.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0).isActive = true
            item.didMove(toParent: self)
            if (i == 0) {
                item.view.isHidden = false
            }else{
                item.view.isHidden = true
            }
        }
        view.addSubview(BarItemView)
    }
    let items_n = vcs.count
    var bar_buttons = [UIButton]()
    func create_BarItem(n : Int) -> [UIView] {
        var res = [UIView]()
        let m : CGFloat = 10
        let left_m : CGFloat = 2
        let a : CGFloat = 1.01
        let vw = (view.frame.width - m)
        var w = view.frame.width / 5 - m
        let y : CGFloat = 5
        let h : CGFloat = w
        for i in 0..<n {
            let bt = UIButton()
            let iv = UIView()
            iv.backgroundColor = BAR_ITEM_BG_COLOR
            bt.backgroundColor = UIColor.black
            bt.setImage(UIImage(systemName: "camera"), for: .normal)
            bt.imageView?.contentMode = .scaleToFill
            bt.tag = i
            if n == 1 {
                let x_cor : CGFloat = CGFloat(i) * w
                w = vw / 1
                iv.frame = CGRect(x: x_cor * a + left_m , y: y, width: w , height: h)
            }
            if n == 2 {
                let x_cor : CGFloat = CGFloat(i) * w
                w = vw / 2
                iv.frame = CGRect(x: x_cor * a + left_m, y: y, width: w , height: h)
            }
            if n == 3 {
                let x_cor : CGFloat = CGFloat(i) * w
                w = vw / 3
                iv.frame = CGRect(x: x_cor * a + left_m, y: y, width: w , height: h)
            }
            if n == 4 {
                let x_cor : CGFloat = CGFloat(i) * w
                w = vw / 4
                iv.frame = CGRect(x: x_cor * a + left_m, y: y, width: w , height: h)
                
            }
            if n == 5 {
                let x_cor : CGFloat = CGFloat(i) * w
                w = vw / 5
                iv.frame = CGRect(x: x_cor * a + left_m, y: y, width: w , height: h)
            }
            if n == 6 {
                let x_cor : CGFloat = CGFloat(i) * w
                w = vw / 6
                iv.frame = CGRect(x: x_cor * a + left_m, y: y, width: w , height: h)
            }
            
            res.append(iv)
        }
        return res
    }
    
    lazy var BarItemView : UIView = {
        let iv = UIView()
        let m : CGFloat = 10
        let y = view.frame.height - 78
        let w = view.frame.width / 5 - m
        iv.frame = CGRect(x: 0, y: y, width: view.frame.width, height: w + m)
        iv.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.8
        iv.layer.shadowOffset = CGSize(width: 3, height: 3)
        let items = create_BarItem(n: items_n)
        let bt_w : CGFloat = 42
        
        
        for i in 0..<items.count {
            let bt = UIButton()
            bt.tag = i
            let x_cor : CGFloat = CGFloat(i) * 36
            bt.backgroundColor = BAR_UNSELECTED_BG_COLOR
            //bt.setTitle(bts_name[i], for: .normal)
            bt.clipsToBounds = true
            bt.layer.cornerRadius = 8
            bt.setImage(UIImage(systemName : item_imgs[i]), for: .normal)
            bt.setTitleColor(BAR_UNSELECTED_TINT_COLOR, for: .normal)
            bt.tintColor = BAR_UNSELECTED_TINT_COLOR
            bt.frame = CGRect(x:items[i].frame.width / 2 - bt_w / 2, y: 5, width: bt_w , height: bt_w)
            bt.isSelected = false
            bt.addTarget(self, action: #selector(handle_barButton(sender: )), for: .touchUpInside)
            items[i].addSubview(bt)
            iv.addSubview(items[i])
            bar_buttons.append(bt)
        }
        return iv
    }()
    
    var i : Int = 0
    @objc func tapped() {
        i += 1
        print("Running \(i)")
        
        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
    }
    @objc func handle_barButton(sender : UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        for i in 0..<bar_buttons.count {
            let item = bar_buttons[i]
            if item.isSelected == true {
                item.backgroundColor = BAR_SELECTED_BG_COLOR
                item.setTitleColor(BAR_SELECTED_TINT_COLOR, for: .normal)
                item.tintColor = BAR_SELECTED_TINT_COLOR
                vcs[i].view.isHidden = false;
            }else{
                item.backgroundColor = BAR_UNSELECTED_BG_COLOR
                item.setTitleColor(BAR_UNSELECTED_TINT_COLOR, for: .normal)
                item.tintColor = BAR_UNSELECTED_TINT_COLOR
                vcs[i].view.isHidden = true;
            }
        }
        for i in 0..<bar_buttons.count {
            print(sender.titleLabel?.text ,  bar_buttons[i].isSelected)
            bar_buttons[i].isSelected = false
        }
        
    }
    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted.")
            } else {
                print("❌ Notification permission denied.")
            }
        }
    }
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationPermission()
        setup_TabBar(n : vcs.count)
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true

        v1.isNavigationBarHidden = true
        view.backgroundColor = .black
        setup()
        locationManager.requestWhenInUseAuthorization() // or requestAlwaysAuthorization()
        
        Minimizable_View.isUserInteractionEnabled = true
        let swipe_up = UISwipeGestureRecognizer(target: self, action: #selector(handle_up_swipe))
        swipe_up.direction = .up
        let tap = UITapGestureRecognizer(target: self, action: #selector(enlarge_event_view))
        
        Minimizable_View.addGestureRecognizer(swipe_up)
        Minimizable_View.addGestureRecognizer(tap)
        for _ in 0..<2{
            toggle_activity_type()
        }
        let leftover_time = UserDefaults.standard.string(forKey: "Start Time")
        time_until_reset = getRemainingTimeInSeconds(initialTime: leftover_time ?? "")
        
        if time_until_reset != 0{
            startTimer()
            
        }
        AI_Confirmation1.text = UserDefaults.standard.string(forKey: "Saved Event1")
        AI_Confirmation2.text = UserDefaults.standard.string(forKey: "Saved Event2")

        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // or requestAlwaysAuthorization()
        
        if let saved_address = UserDefaults.standard.string(forKey: "Saved Address"){
            if saved_address == ""{
                locationManager.startUpdatingLocation()
            }
            else{
                self.generateMapSnapshot(address: saved_address, size: CGSize(width: 300, height: 200)) { image in
                    DispatchQueue.main.async {
                        if let image = image {
                            self.mapImageView.image = image
                        } else {
                            print("Failed to generate map image")
                        }
                    }
                }
            }
        }
        else{
            locationManager.startUpdatingLocation()
        }
        
        
        
    }

    
    
    //MARK: Enlarged ----------------------------------------------
    var enlarged_view_elements_0: [UIView] = []
    var enlarged_view_elements_1: [UIView] = []
    var enlarged_view_elements_2: [UIView] = []
    
    var minimized_view_elements_0: [UIView] = []
    var minimized_view_elements_1: [UIView] = []
    var minimized_view_elements_2: [UIView] = []
    lazy var Minimizable_View: UIView = {
        let uv = UIView()
        uv.backgroundColor = textColor
        uv.layer.cornerRadius = 13
        uv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - BarItemView.frame.height)
        return uv
    }()
    lazy var view_width: CGFloat = Minimizable_View.frame.width
    lazy var view_height: CGFloat = Minimizable_View.frame.height
    lazy var AI_Suggestion_Spacer: UIView = {
        let tx = UIView()
        tx.backgroundColor = .clear
        tx.layer.cornerRadius = 13
        tx.frame = CGRect(x: 20, y: 80, width: view_width - 40, height: view_height/2 + 80)

        tx.alpha = 0
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var AI_Suggestion1: UILabel = {
        let tx = UILabel()
        tx.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        tx.frame = CGRect(x: AI_Suggestion_Spacer.frame.minX + 10, y: AI_Suggestion_Spacer.frame.minY + 5, width: AI_Suggestion_Spacer.frame.width - 20, height: AI_Suggestion_Spacer.frame.height/2)
        tx.text = "Using AI to find your match..."
        tx.backgroundColor = .clear
        tx.textColor = bgColor
        tx.numberOfLines = 0
        tx.adjustsFontSizeToFitWidth = true
        tx.textAlignment = .left
        tx.alpha = 0
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var AI_Suggestion2: UILabel = {
        let tx = UILabel()
        tx.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        tx.frame = CGRect(x: AI_Suggestion_Spacer.frame.minX + 10, y: AI_Suggestion_Spacer.frame.maxY - 40, width: AI_Suggestion_Spacer.frame.width - 20, height: 30)
        tx.text = "Finding geniuses like you nearby..."
        tx.backgroundColor = .clear
        tx.textColor = bgColor
        tx.numberOfLines = 1
        tx.adjustsFontSizeToFitWidth = true
        tx.textAlignment = .left
        tx.alpha = 0
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var Yes_button: UIButton = {
        let bt = UIButton()
        bt.frame = CGRect(x: view_width/2 + 40, y: AI_Suggestion_Spacer.frame.maxY + 50, width: 80, height: 80)
        bt.backgroundColor = textColor
        bt.layer.cornerRadius = 40
        bt.tintColor = bgColor
        bt.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.contentHorizontalAlignment = .fill
        bt.contentVerticalAlignment = .fill
        bt.addTarget(self, action: #selector(Pressed_Yes), for: .touchUpInside)
        bt.alpha = 0
        return bt
    }()
    lazy var No_button: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = textColor
        bt.frame = CGRect(x: view_width/2 - 120, y: AI_Suggestion_Spacer.frame.maxY + 50, width: 80, height: 80)
        bt.layer.cornerRadius = 40
        bt.tintColor = bgColor
        bt.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.contentHorizontalAlignment = .fill
        bt.contentVerticalAlignment = .fill
        bt.addTarget(self, action: #selector(Pressed_No), for: .touchUpInside)
        bt.alpha = 0
        return bt
    }()
    lazy var matchBT: UIButton = {
       let bt = UIButton()
        bt.tintColor = .black
        bt.setImage(UIImage(systemName: "person"), for: .normal)
        bt.contentHorizontalAlignment = .fill
        bt.contentVerticalAlignment = .fill
        bt.imageView?.contentMode = .scaleAspectFill
        bt.backgroundColor = .clear
        bt.alpha = 0
        bt.frame = CGRect(x: view.frame.maxX - 50, y: 70, width: 36, height: 36)
        bt.layer.cornerRadius = 18
        bt.addTarget(self, action: #selector(handle_alert), for: .touchUpInside)
        return bt
    }()
    @objc func handle_alert(sender: UIButton){
        let input = "Using my background info (\(user1.BackgroundInfo)) and the other person's background info (\(user2.BackgroundInfo)), explain in less than 80 characters why it would be beneficial for us to become friends. Please start the response with something along the lines of: Since you and (Random Name) both _______,.... Make the entire response coherent sentences. no parenthesis/directly stating 'Reason:'"
        backend_manage.callDeepSeekAPI_for_events(userInput: input) { response in
            DispatchQueue.main.async {
                if let reply = response {
                    let alert = UIAlertController(title: "Match Found", message: reply, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    print("error")
                }
            }
        }
    }
    lazy var mapImageView: UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .clear
        img.frame = CGRect(x: AI_Suggestion1.frame.minX, y: AI_Suggestion1.frame.maxY + 5, width: AI_Suggestion1.frame.width, height: AI_Suggestion2.frame.minY - AI_Suggestion1.frame.maxY - 10 )
        img.clipsToBounds = true
        img.layer.cornerRadius = 13
        img.backgroundColor = buttonColor
        img.alpha = 0
        return img
    }()
    
    lazy var AI_Confirmation_Spacer: UIView = {
        let tx = UIView()
        tx.backgroundColor = .clear
        tx.layer.cornerRadius = 13
        tx.frame = CGRect(x: 20, y: 80, width: view_width - 40, height: view_height/2 + 80)
        tx.alpha = 0
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var AI_Confirmation1: UILabel = {
        let tx = UILabel()
        tx.text = "You are confrimed for event"
        tx.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        tx.frame = CGRect(x: AI_Suggestion_Spacer.frame.minX + 10, y: AI_Suggestion_Spacer.frame.minY + 5, width: AI_Suggestion_Spacer.frame.width - 20, height: AI_Suggestion_Spacer.frame.height/2)
        tx.backgroundColor = .clear
        tx.textColor = bgColor
        tx.numberOfLines = 0
        tx.adjustsFontSizeToFitWidth = true
        tx.textAlignment = .center
        tx.alpha = 0
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var AI_Confirmation2: UILabel = {
        let tx = UILabel()
        tx.text = ""
        tx.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        tx.frame = CGRect(x: AI_Suggestion_Spacer.frame.minX + 10, y: AI_Suggestion_Spacer.frame.maxY - 40, width: AI_Suggestion_Spacer.frame.width - 20, height: 30)
        tx.backgroundColor = .clear
        tx.textColor = bgColor
        tx.numberOfLines = 0
        tx.adjustsFontSizeToFitWidth = true
        tx.textAlignment = .center
        tx.alpha = 0
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var Cancel_Event_Button: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .black
        bt.setTitle("Cancel", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        bt.frame = CGRect(x: view_width/2 - 100, y: AI_Confirmation_Spacer.frame.maxY + 80, width: 200, height: 50)
        bt.layer.borderColor = UIColor.black.cgColor
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 13
        bt.addTarget(self, action: #selector(cancel_event), for: .touchUpInside)
        bt.alpha = 0
        return bt
    }()
    
    lazy var timer_display: UILabel = {
        let tx = UILabel()
        tx.text = "New Event in: 1:00:00"
        tx.textColor = .black
        tx.font = UIFont(name: mainFont, size: 20)
        tx.backgroundColor = .clear
        tx.numberOfLines = 1
        tx.textAlignment = .center
        tx.alpha = 0
        tx.frame = Minimizable_View.bounds
        tx.isUserInteractionEnabled = false
        return  tx
    }()

    //MARK: Minimized ------------------------
    lazy var notif0: UILabel = {
        let tx = UILabel()
        tx.text = "New Event"
        tx.textColor = .black
        tx.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tx.backgroundColor = .clear
        tx.numberOfLines = 1
        tx.textAlignment = .center
        tx.alpha = 0
        tx.frame = Minimizable_View.bounds
        tx.isUserInteractionEnabled = false
        return tx
    }()
    lazy var arrow1: UIImageView = {
        let im = UIImageView(image: UIImage(named: "chevron.down"))
        im.contentMode = .scaleAspectFill
        im.alpha = 0
        im.tintColor = .black
        im.backgroundColor = .clear
        return im
    }()
    lazy var arrow2: UIImageView = {
        let im = UIImageView(image: UIImage(named: "chevron.down"))
        im.contentMode = .scaleAspectFill
        im.alpha = 0
        im.tintColor = .black
        im.backgroundColor = .clear
        return im
    }()
    lazy var notif1: UILabel = {
        let tx = UILabel()
        tx.text = "Event Confirmed"
        tx.textColor = .black
        tx.font = UIFont.systemFont(ofSize:15, weight: .semibold)
        tx.backgroundColor = .clear
        tx.numberOfLines = 1
        tx.textAlignment = .center
        tx.alpha = 0
        tx.frame = Minimizable_View.bounds
        tx.isUserInteractionEnabled = false
        return tx
    }()
    
    
    lazy var notif2: UILabel = {
        let tx = UILabel()
        tx.text = "New Event in: 1:00:00"
        tx.textColor = .black
        tx.font = UIFont(name: mainFont, size: 20)
        tx.backgroundColor = .clear
        tx.numberOfLines = 1
        tx.textAlignment = .center
        tx.alpha = 0
        tx.frame = Minimizable_View.bounds
        tx.isUserInteractionEnabled = false
        return tx
    }()
}
