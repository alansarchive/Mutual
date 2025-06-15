//
//  Base.swift
//  mutual
//
//  Created by Marc Jiang on 6/14/25.
//

import UIKit
//MARK: this class will contain functions that can be used by all others
class Base: UIViewController{
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        backend_manage.fetchData()        
    }
    func getRemainingTimeInSeconds(initialTime: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let savedDate = formatter.date(from: initialTime) {
            let elapsed = Date().timeIntervalSince(savedDate)
            let totalDuration = 24 * 60 * 60
            let timeLeft = max(0, totalDuration - Int(elapsed))
            return Int(timeLeft)
        } else {
            print("🚫 Failed to convert saved string to Date")
            return 0
        }
    }
    func formatSecondsToTimeString(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }


    func toggle_activity_type(){
        activity_type = UserDefaults.standard.integer(forKey: "Event Type")
        if activity_type == 0{
            EventPrompt_activity_specify = "The event has to be for a casual gathering (i.e. dinner, study session, etc.)."
            UserDefaults.standard.set(1, forKey: "Event Type")
        }
        else{
            EventPrompt_activity_specify = "The event has to be an active activity (sports game, hiking, hangouts basically)"
            UserDefaults.standard.set(0, forKey: "Event Type")
        }
        
    }
}
extension UIView {
    public func M_feedback() { //MARK: haptic feedback; call when you want the user to feel a bump
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    public func pressBT(){
        M_feedback()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.8)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
let backend_manage = Data_Management()
let root_folder = Secrets.backendBaseURL
let EventPrompt = "Give me a formal greeting"
var EventPrompt_activity_specify = ""

var Confirmation_Prompt = "" //MARK: ex.) You are going to (activity name) + (time specifier)



var event_view_status = 0 //MARK: 0 -> idle, 1 -> confirmed, 2 -> rejected
var event_view_enlarged = true

var timer: Timer?

var all_users: [User] = []

var loggedIn: Bool?
var activity_type: Int = 0 //0 = casual 1 = active
var time_until_reset: Int = 0

let fontBold = "SFPro-Bold"
let TextSize: CGFloat = 10
let mainFont = "Arial"
let buttonColor = UIColor(red: 198/255, green: 172/255, blue: 143/255, alpha: 1)
let textColor: UIColor = .white
let bgColor: UIColor = .black


let user1: User = User(
    Email: "alice@example.com",
    Password: "password123",
    Name: "Alice Johnson",
    ID: "user001",
    JoinDate: "2024-06-01",
    Organization: "GreenTeam",
    PhoneNumber: "555-123-4567",
    AccountPoints: "150",
    FirebaseToken: "abc123xyzToken",
    SearchIsOn: "true",
    LatCoor: "37.7749",
    LongCoor: "-122.4194",
    ProfileImage: "",
    BackgroundInfo: "Recently moved to SF to pursue a career in software development. Looking for mentorship, portfolio feedback, and opportunities to collaborate on real-world projects."
)

let user2: User = User(
    Email: "bob@example.com",
    Password: "securePass456",
    Name: "Bob Martinez",
    ID: "user002",
    JoinDate: "2024-05-20",
    Organization: "FoodShare Network",
    PhoneNumber: "555-987-6543",
    AccountPoints: "230",
    FirebaseToken: "def456uvwToken",
    SearchIsOn: "false",
    LatCoor: "37.7765",
    LongCoor: "-122.4172",
    ProfileImage: "",
    BackgroundInfo: "10+ years in full-stack development. Passionate about helping junior devs break into the tech scene. Open to mentoring and possibly partnering on side projects or hackathons."
)

let user_BgInfo: [String:[String]] = [
    "user001" : [
    "Aspiring software developer",
    "Recently relocated to San Francisco",
    "Interested in mentorship",
    "Building a portfolio",
    "Open to collaboration on projects",
    "Looking for networking opportunities",
    "Eager to gain real-world experience"
    ],
    "user002" : [
    "Senior full-stack engineer",
     "10+ years experience in tech",
     "Based in San Francisco",
     "Passionate about mentoring",
     "Enjoys helping junior developers",
     "Open to side projects and hackathons",
     "Interested in community involvement"
    ]
]
enum ServiceError: Error {
  case invalidURL
  case invalidResponseCode(Int)
  case invalidResponse
}
