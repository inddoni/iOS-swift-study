//
//  mapViewController.swift
//  iOS_Study_0521
//
//  Created by 최인정 on 2020/05/21.
//  Copyright © 2020 indoni. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var lbllocationInfo1: UILabel!
    @IBOutlet weak var lbllocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbllocationInfo1.text = ""
        lbllocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //위치데이터 승인 요청
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        myMap.showsUserLocation = true
        
        setAnnotation(latitudeValue: 37.556876, logitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
        locationManager.stopUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spandValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spandValue)
        
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    
    func setAnnotation(latitudeValue: CLLocationDegrees, logitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle: String) {
        //map에 설치하는 pin 만들어주기
        let annotation = MKPointAnnotation()
        
        //annotation에 들어가는 값은 CLLocationCoordinate2D 형식이어야함 (
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: logitudeValue, delta: span)
        
        //핀 찍기
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality! //도시
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare! //도로
            }
            
            self.lbllocationInfo1.text = "현재 위치"
            self.lbllocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
