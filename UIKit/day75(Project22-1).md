# Day 75 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day75-76/Day75-76"> Project </a>

## Developing on CoreLocation

## Subjects

+ Set-Up
+ Requesting location: Core Location
+ Hunting the beacon: CLBeaconRegion

## Set-Up
We create an application as we always do. Besides, this time we are adding 2 permissions. These are privacy-location permissions. We carry out this process on the info plist and continue.

## Requesting location: Core Location
```swift
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    @IBOutlet var distanceLabel: UILabel!
    var locationManager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
```
Let's work things out. The first thing we will do, of course, is to get permission.

```swift
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
                startScanning()
            }
        }
    }
}
```
In this section, we look at the event that will occur as a result of the permit. No scan here yes but we'll add it later. The trick here is if we're allowed, if our location is measurable, start the scan.

## Hunting the beacon: CLBeaconRegion
### Important note
There are parts here that are deprecated. I couldn't check if it works as I don't have multiple iOS devices. It probably won't work. Therefore, these sections may vary.

### OLD
```swift
func startScanning() {
    let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")

    locationManager?.startMonitoring(for: beaconRegion)
    locationManager?.startRangingBeacons(in: beaconRegion)
}
```
### NEW
```swift
func startScanning() {
    let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!

    let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
    locationManager?.startMonitoring(for: beaconRegion)
    locationManager?.startRangingBeacons(satisfying: CLBeaconIdentityConstraint.init(uuid: uuid, major: 123, minor: 456))
}
```

```swift
func update(distance: CLProximity) {
    UIView.animate(withDuration: 0.8) {
        switch distance {
        case .far:
            self.view.backgroundColor = UIColor.blue
            self.distanceLabel.text = "FAR"

        case .near:
            self.view.backgroundColor = UIColor.orange
            self.distanceLabel.text = "NEAR"

        case .immediate:
            self.view.backgroundColor = UIColor.red
            self.distanceLabel.text = "RIGHT HERE"

        default:
            self.view.backgroundColor = UIColor.gray
            self.distanceLabel.text = "UNKNOWN"
        }
    }
}

func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if let beacon = beacons.first {
        update(distance: beacon.proximity)
    } else {
        update(distance: .unknown)
    }
}
```
The codes are very simple but I have no idea if they really work. All we do is change the screen when the distance changes.



## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

