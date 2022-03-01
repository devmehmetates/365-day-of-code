# Day 60 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day60-61/Day60-61"> Project </a>

## Developing on MapKit

## Subjects

+ Set-Up
+ Up and running with MapKit
+ Annotations and accessory views: MKPinAnnotationView

## Set-Up
We have defined a mapkitview on the storyboard and we have a map ready with everything working perfectly.

## Up and running with MapKit
```swift
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
```
Let's define an NSObject. This is a object for we created for our capitals.

```swift
let ankara = Capital(title: "Ankara", coordinate: CLLocationCoordinate2D(latitude: 39.925533, longitude: 32.866287), info: "The province with the Anıtkabir, where the tomb of Atatürk, the founder of Turkey, is located.")
let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

mapView.addAnnotations([ankara,london, oslo, paris, rome, washington])
```
Very well, now our capitals are marked on the mapkit.

## Annotations and accessory views: MKPinAnnotationView
```swift
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is Capital else { return nil }

    let identifier = "Capital"

    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

    if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
    } else {
        annotationView?.annotation = annotation
    }

    return annotationView
}

func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    let placeName = capital.title
    let placeInfo = capital.info

    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
We have two functions. Someone marks our point as the needle. And pressing it causes a popup to pop up :D.<br>
The second is what the pop up button that we defined in the first function will do. We also give a alert.

And I think it's better this way.
```swift
func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    let placeName = capital.title
    let placeInfo = capital.info

    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
## One photo :)

<img src="https://user-images.githubusercontent.com/74152011/156223024-8bd94c76-4110-4d2b-966f-3360fddd2381.png" width=255>

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

