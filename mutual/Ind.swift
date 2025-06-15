//
//  Ind.swift
//  mutual
//
//  Created by Marc Jiang on 6/14/25.
//

import UIKit
struct User : Encodable, Decodable{
    var Email : String?
    var Password : String?
    var Name: String?
    var ID: String?
    var JoinDate: String?
    var Organization: String?
    var PhoneNumber: String?
    var AccountPoints: String?
    var FirebaseToken: String?
    var SearchIsOn: String?
    var LatCoor: String?
    var LongCoor: String?
    var ProfileImage: String?
    var BackgroundInfo: String?
    init(Email: String? = nil, Password: String? = nil, Name: String? = nil, ID: String? = nil, JoinDate: String? = nil, Organization: String? = nil, PhoneNumber: String? = nil, AccountPoints: String? = nil, FirebaseToken: String? = nil, SearchIsOn: String? = nil, LatCoor: String? = nil, LongCoor: String? = nil, ProfileImage: String? = nil, BackgroundInfo: String? = nil) {
        self.Email = Email
        self.Password = Password
        self.Name = Name
        self.ID = ID
        self.JoinDate = JoinDate
        self.Organization = Organization
        self.PhoneNumber = PhoneNumber
        self.AccountPoints = AccountPoints
        self.FirebaseToken = FirebaseToken
        self.SearchIsOn = SearchIsOn
        self.LatCoor = LatCoor
        self.LongCoor = LongCoor
        self.ProfileImage = ProfileImage
        self.BackgroundInfo = BackgroundInfo
    }
    
    
}
