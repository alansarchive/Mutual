//
//  Functions For Event Page.swift
//  mutual
//
//  Created by Marc Jiang on 6/14/25.
//
import UIKit
import UserNotifications
import CoreLocation
import MapKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    func substring(from : Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
extension CustomTabBar{
    func setup(){
        
        view.addSubview(Minimizable_View)
        Minimizable_View.addSubview(AI_Suggestion_Spacer)
        Minimizable_View.addSubview(AI_Suggestion1)
        Minimizable_View.addSubview(AI_Suggestion2)
        Minimizable_View.addSubview(mapImageView)
        Minimizable_View.addSubview(Yes_button)
        Minimizable_View.addSubview(No_button)
        Minimizable_View.addSubview(matchBT)
        
        Minimizable_View.addSubview(AI_Confirmation_Spacer)
        Minimizable_View.addSubview(AI_Confirmation1)
        Minimizable_View.addSubview(AI_Confirmation2)

        Minimizable_View.addSubview(Cancel_Event_Button)
        
        Minimizable_View.addSubview(timer_display)
        
        Minimizable_View.addSubview(notif0)
        Minimizable_View.addSubview(notif1)
        Minimizable_View.addSubview(notif2)
        

        
        enlarged_view_elements_0 = [AI_Suggestion1, AI_Suggestion2, AI_Suggestion_Spacer, Yes_button, No_button, mapImageView, matchBT]
        enlarged_view_elements_1 = [AI_Confirmation1, AI_Confirmation2, AI_Suggestion_Spacer, Cancel_Event_Button, mapImageView, matchBT]
        enlarged_view_elements_2 = [timer_display]

        minimized_view_elements_0 = [notif0]
        minimized_view_elements_1 = [notif1]
        minimized_view_elements_2 = [notif2]

        activity_type = UserDefaults.standard.integer(forKey: "Event Type")
        event_view_status = UserDefaults.standard.integer(forKey: "Event Status")
        print("0000", activity_type)
        print("0000", event_view_status)
//        UserDefaults.standard.set(0, forKey: "Event Status") //MARK: KEEP FOR TESTING PURPOSES
//        UserDefaults.standard.set(0, forKey: "Start Time")
        
        first_display_handler()

        
    }
    func generateMapSnapshot(address: String, size: CGSize, completion: @escaping (UIImage?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocode failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let location = placemarks?.first?.location else {
                print("No location found for address")
                completion(nil)
                return
            }
            
            let options = MKMapSnapshotter.Options()
            options.region = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: 500,
                                                longitudinalMeters: 500)
            options.size = size
            options.scale = UIScreen.main.scale
            
            let snapshotter = MKMapSnapshotter(options: options)
            snapshotter.start { snapshot, error in
                if let error = error {
                    print("Snapshot error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let snapshot = snapshot else {
                    completion(nil)
                    return
                }
                
                // Draw pin on snapshot image
                UIGraphicsBeginImageContextWithOptions(options.size, true, options.scale)
                snapshot.image.draw(at: .zero)
                
                let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                let pinImage = pin.image
                
                var point = snapshot.point(for: location.coordinate)
                let pinCenterOffset = pin.centerOffset
                point.x -= pin.bounds.size.width / 2
                point.y -= pin.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                
                pinImage?.draw(at: point)
                
                let finalImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                completion(finalImage)
            }
        }
    }
    @objc func Pressed_Yes(sender: UIButton){
        toggle_activity_type()
        sender.pressBT()
        UIView.animate(withDuration: 0.3) {
            [self] in
            for i in enlarged_view_elements_0{
                i.alpha = 0
            }
            for i in enlarged_view_elements_1{
                i.alpha = 1
            }
            for i in enlarged_view_elements_2{
                i.alpha = 0
            }
            event_view_status = 1
            UserDefaults.standard.set(AI_Suggestion1.text, forKey: "Saved Event1")
            UserDefaults.standard.set(AI_Suggestion2.text, forKey: "Saved Event2")
            UserDefaults.standard.set(AI_Suggestion2.text?.substring(from: 9), forKey: "Saved Address")

            AI_Confirmation1.text = AI_Suggestion1.text
            AI_Confirmation2.attributedText = AI_Suggestion2.attributedText
            LocalStorage.save_event_status(status: event_view_status, type: activity_type, time: "0")
        }
    }
    @objc func Pressed_No(sender: UIButton){
        toggle_activity_type()
        sender.pressBT()
        UIView.animate(withDuration: 0.3) {
            [self] in
            for i in enlarged_view_elements_0{
                i.alpha = 0
            }
            for i in enlarged_view_elements_1{
                i.alpha = 0
            }
            event_view_status = 2
            setup_timer()
        }
    }
    @objc func cancel_event(sender:UIButton){
        event_view_status = 2
        UIView.animate(withDuration: 0.3) {
            [self] in
            for i in enlarged_view_elements_1{
                i.alpha = 0
            }
        }
        setup_timer()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if time_until_reset > 0 {
                time_until_reset -= 1
                let time_txt = formatSecondsToTimeString(time_until_reset)
                notif2.text = "New Event in \(time_txt)"
                timer_display.text = "New Event in \(time_txt)"
            } else {
                timer?.invalidate()
                timer = nil
                
                LocalStorage.save_event_status(status: 0, type: activity_type, time: "0")
                event_view_status = 0
                
                locationManager.startUpdatingLocation( )
                UserDefaults.standard.set("", forKey: "Saved Address")
                minimized_display_handler()
            }
        }
    }
    func setup_timer(){
        UIView.animate(withDuration: 0.3){
            [self] in
            
            for i in enlarged_view_elements_2{
                i.alpha = 1
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            formatter.timeZone = TimeZone(abbreviation: "UTC") // Optional: match how you stored it
            let startTimeString = formatter.string(from: Date())
            
            
            LocalStorage.save_event_status(status: event_view_status, type: activity_type, time: startTimeString)
            
            time_until_reset = 86400
            
            
            
        }
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.body = "You have a new event!"
        content.sound = UNNotificationSound.default
        let time = 86400 //MARK: this will be in the timeInterval
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerAlert", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🚫 Error scheduling notification: \(error)")
            } else {
                print("🔔 Notification scheduled in \(1) second.")
            }
        }
        startTimer()
    }
    func promptAI(input: String){
        backend_manage.callDeepSeekAPI_for_events(userInput: input) { response in
            print(input)
            var context = ""
            DispatchQueue.main.async {
                if let reply = response {
                    self.AI_Suggestion1.text = reply
                    context = "Can you give me ONLY the address of the location mentioned in the following message: \(reply). I dont want any filler words. ONLY GIVE ME THE ADDRESS"
                } else {
                    print("error")
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1,){
                    
                    
                    backend_manage.callDeepSeekAPI_for_events(userInput: "\(context)") { response in
                        print(input)
                        DispatchQueue.main.async {
                            if let reply = response {
                                let fullText = "Address: \(reply)"
                                let boldText = "Address:"
                                
                                // Define fonts
                                let regularFont = UIFont.systemFont(ofSize: 30, weight: .regular)
                                let boldFont = UIFont.systemFont(ofSize: 30, weight: .bold)
                                
                                // Create attributed string with regular font for entire text
                                let attributedString = NSMutableAttributedString(string: fullText, attributes: [
                                    .font: regularFont
                                ])
                                
                                // Find the range of the bold text
                                if let boldRange = fullText.range(of: boldText) {
                                    let nsRange = NSRange(boldRange, in: fullText)
                                    // Apply bold font to "Address:"
                                    attributedString.addAttribute(.font, value: boldFont, range: nsRange)
                                }
                                
                                // Set attributed text to the label
                                self.AI_Suggestion2.attributedText = attributedString
                                
                                
                                self.generateMapSnapshot(address: reply, size: CGSize(width: 300, height: 200)) { image in
                                    DispatchQueue.main.async {
                                        if let image = image {
                                            self.mapImageView.image = image
                                        } else {
                                            print("Failed to generate map image")
                                        }
                                    }
                                }
                            }else {
                                print("error")
                            }
                        }
                    }
                }
                
            }
        }
    }

    
    @objc func handle_up_swipe(_:UISwipeGestureRecognizer){
        if event_view_enlarged{
            minimized_display_handler()
            event_view_enlarged.toggle()
        }
    }
    @objc func enlarge_event_view(_:UITapGestureRecognizer){
        if !event_view_enlarged{
            minimized_display_handler()
            event_view_enlarged.toggle()
        }
        
    }
    func getAddress(from location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                let number = placemark.subThoroughfare ?? ""
                let street = placemark.thoroughfare ?? ""
                let city = placemark.locality ?? ""
                let state = placemark.administrativeArea ?? ""
                let zip = placemark.postalCode ?? ""
                let country = placemark.country ?? ""
                
                let address = "\(number) \(street), \(city), \(state) \(zip), \(country)"
                completion(address)
            } else {
                completion(nil)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        getAddress(from: location) { address in
            if let address = address {
                print(address)
                
                self.promptAI(input: "I am at in the San Franciso/Silicon Valley area. Give me EXACTLY ONE suggesstion I can do with somebody nearby. \(EventPrompt_activity_specify). Simplify your answer (50 words maximum) and do not use any stylized text. Can you format your repsonse exactly as follows: Meet at (location) at (specified time) to (activity). Do not include the address in the response.")
                
            } else {
                print("❌ Failed to get address")
            }
        }

        manager.stopUpdatingLocation()
    }
    
    func first_display_handler(){
        if event_view_status == 0{
            for item in enlarged_view_elements_0{
                item.alpha = 1
                
                
            }
            for item in minimized_view_elements_0{
                item.alpha = 0
            }
        }
        else if event_view_status == 1{
            for item in enlarged_view_elements_1{
                item.alpha = 1
            }
            for item in minimized_view_elements_1{
                item.alpha = 0
            }
        }
        else{
            for item in enlarged_view_elements_2{
                item.alpha = 1
            }
            for item in minimized_view_elements_2{
                item.alpha = 0
            }
            
        }
    }
    func minimized_display_handler(){
        UIView.animate(withDuration: 0.3) {
            [self] in
            
            if event_view_enlarged{
                Minimizable_View.frame = CGRect(x: 40, y: 50, width: view_width - 80, height: 40)
                if event_view_status == 0{
                    for item in enlarged_view_elements_0{
                        item.alpha = 0
                    }
                    for item in minimized_view_elements_0{
                        item.frame = Minimizable_View.bounds
                        item.alpha = 1
                    }
                    
                }
                else if event_view_status == 1{
                    for item in enlarged_view_elements_1{
                        item.alpha = 0
                    }
                    for item in minimized_view_elements_1{
                        item.frame = Minimizable_View.bounds
                        item.alpha = 1
                    }
                }
                else{
                    for item in enlarged_view_elements_2{
                        item.alpha = 0
                    }
                    for item in minimized_view_elements_2{
                        item.frame = Minimizable_View.bounds
                        item.alpha = 1
                    }
                }
            }
            else{
                Minimizable_View.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - BarItemView.frame.height)
                if event_view_status == 0{
                    for item in enlarged_view_elements_0{
                        item.alpha = 1
                    }
                    for item in minimized_view_elements_0{
                        item.alpha = 0
                    }
                }
                else if event_view_status == 1{
                    for item in enlarged_view_elements_1{
                        item.alpha = 1
                    }
                    for item in minimized_view_elements_1{
                        item.alpha = 0
                    }
                }
                else{
                    for item in enlarged_view_elements_2{
                        item.alpha = 1
                    }
                    for item in minimized_view_elements_2{
                        item.alpha = 0
                    }
                    
                }
            }
        }
    }
}
