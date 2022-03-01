//
//  ViewController.swift
//  Day60-61
//
//  Created by Mehmet Ateş on 1.03.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(changeMapMethod))
        
        let ankara = Capital(title: "Ankara", coordinate: CLLocationCoordinate2D(latitude: 39.925533, longitude: 32.866287), info: "The province with the Anıtkabir, where the tomb of Atatürk, the founder of Turkey, is located.")
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

        
        mapView.addAnnotations([ankara,london, oslo, paris, rome, washington])
    }
    
    @objc func changeMapMethod(){
        let ac = UIAlertController(title: "Change map style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standart", style: .default, handler: changeMethod))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: changeMethod))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: changeMethod))
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: changeMethod))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac,animated: true)
    }
    
    func changeMethod(action: UIAlertAction? = nil){
        guard let actionTitle = action?.title else{
            return
        }

        switch actionTitle{
        case "Satellite":
            self.mapView.mapType = .satellite
        case "Hybrid":
            self.mapView.mapType = .hybrid
        case "Hybrid Flyover":
            self.mapView.mapType = .hybridFlyover
        default:
            self.mapView.mapType = .standard
        }
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = UIColor.black
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Web") as? WebViewController else{ return }
        guard let capital = view.annotation as? Capital else { return }
        guard let capitalTitle = capital.title else { return }
    
        
        vc.countryName = capitalTitle.replacingOccurrences(of: " ", with: "%20")
        
        navigationController?.pushViewController(vc, animated: true)
    }


}

