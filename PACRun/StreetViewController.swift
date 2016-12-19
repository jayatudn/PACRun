//
//  ViewController.swift
//  PACRun
//
//  Created by 馮仰靚 on 09/12/2016.
//  Copyright © 2016 YC. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class StreetViewController: UIViewController ,GMSMapViewDelegate  {

    @IBOutlet weak var streetView: UIView!

    @IBOutlet weak var gotoMapButton: UIButton!

    //Google map
    var panoView : GMSPanoramaView?
    //用來儲存heading方線的變數：單位是“度” 0~360
    var heading : Double = 0
    //用來儲存座標的變數
    var coordinateValue : CLLocationCoordinate2D? = GPSManager.sharedInstance.GPSCoordinate
    override func viewDidLoad() {
        super.viewDidLoad()

        //建立notification來觀測GPS位置
        NotificationCenter.default.addObserver(self, selector: #selector(StreetViewController.didUpdateCoordinate(date:)), name: NSNotification.Name(rawValue: "updateCoordinate"), object: nil)
        //建立notification來觀測heading改變
        NotificationCenter.default.addObserver(self, selector: #selector(StreetViewController.didUpdateHeading(date:)), name: NSNotification.Name(rawValue: "updateHeading"), object: nil)
        //

    }

    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        self.panoView = GMSPanoramaView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        streetView.addSubview(panoView!)
        panoView?.camera = GMSPanoramaCamera(heading: heading, pitch: -10, zoom: 1)
        panoView?.moveNearCoordinate(coordinateValue!)
        self.view.addSubview(gotoMapButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func gotoMapButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapViewController.latitude = coordinateValue?.latitude
        mapViewController.longitude = coordinateValue?.longitude

        self.navigationController?.pushViewController(mapViewController, animated: true)
        //self.dismiss(animated: false, completion: nil)

    }

    //  若GPS座標更新就會執行
    func didUpdateCoordinate(date:Notification){
        if let dic = date.userInfo as? [String:CLLocationCoordinate2D]{
            self.coordinateValue = dic["GPSCoordinate"]
             panoView?.moveNearCoordinate(coordinateValue!)
        }
    }
    // 若Heading方向改變就會執行
    func didUpdateHeading(date:Notification){
        if let dic = date.userInfo as? [String:Double]{
            self.heading = dic["Heading"]!
            panoView?.camera = GMSPanoramaCamera(heading: self.heading, pitch: -10, zoom: 1)
        }
    }

}

