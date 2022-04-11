//
//  ViewController.swift
//  Day75-76
//
//  Created by Mehmet Ateş on 16.03.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var beaconLabel: UILabel!
    
    var locationManager: CLLocationManager?
    var alertWasTriggered: Bool = false
    
    @IBOutlet var circleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            self.circleImage.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        } completion: { finished in
            //
        }
        
       
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let uuid2 = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7EA")!
        let uuid3 = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E7")!
        
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: CLBeaconIdentityConstraint.init(uuid: uuid, major: 123, minor: 456))
        
        let secondBeaconRegion = CLBeaconRegion(uuid: uuid2, major: 153, minor: 456, identifier: "MyBeacon2")
        locationManager?.startMonitoring(for: secondBeaconRegion)
        locationManager?.startRangingBeacons(satisfying: CLBeaconIdentityConstraint.init(uuid: uuid, major: 153, minor: 456))
        
        let thirtBeaconRegion = CLBeaconRegion(uuid: uuid3, major: 163, minor: 456, identifier: "MyBeacon3")
        locationManager?.startMonitoring(for: thirtBeaconRegion)
        locationManager?.startRangingBeacons(satisfying: CLBeaconIdentityConstraint.init(uuid: uuid, major: 163, minor: 456))
    }
    
    func update(distance: CLProximity, beaconID: Int) {
        UIView.animate(withDuration: 0.8) {
            self.beaconLabel.text = (beaconID == 123) ? "First Beacon" : (beaconID == 153) ? "Second Beacon" : (beaconID == 163) ? "Thirt Beaon" : "Beacon Not Found"
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                switch distance {
                case .far:
                    self.view.backgroundColor = UIColor.blue
                    self.distanceLabel.text = "FAR"
                    self.circleImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                    
                case .near:
                    self.view.backgroundColor = UIColor.orange
                    self.distanceLabel.text = "NEAR"
                    self.circleImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    
                    
                case .immediate:
                    self.view.backgroundColor = UIColor.red
                    self.distanceLabel.text = "RIGHT HERE"
                    self.circleImage.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                    
                    
                default:
                    self.view.backgroundColor = UIColor.gray
                    self.distanceLabel.text = "UNKNOWN"
                    self.circleImage.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                }
                
            } completion: { finished in
                //
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if !self.alertWasTriggered{
                self.alertWasTriggered = true
                let ac = UIAlertController(title: "Yeeyyy!", message: "You find the first beacon.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: nil, style: .cancel))
                present(ac, animated: true)
            }
            update(distance: beacon.proximity, beaconID: Int(truncating: beacon.major))
        } else {
            update(distance: .unknown, beaconID: 0)
        }
    }
}

