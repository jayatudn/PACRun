//
//  PofileManager.swift
//  PACRun
//
//  Created by 馮仰靚 on 20/12/2016.
//  Copyright © 2016 YC. All rights reserved.
//

import Foundation
import CoreLocation

class ProfileManager{
    var name : String?
    var id : String?
    var email : String?
    var distance : Double?
    var image : URL?
}
class RunRecordManager{
    var startLocation : CLLocationCoordinate2D?
    var endLocation : CLLocationCoordinate2D?
    var runMap: Int?
    var allCoordinate : [CLLocationCoordinate2D]?
}
