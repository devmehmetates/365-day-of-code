# Day 76 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day75-76/Day75-76"> Project </a>

## Developing on CoreLocation
### Important Note
I'm not sure if the Codes work as I haven't been able to test it. I apologize in advance if there is a mistake somewhere in the code. And in this case please contact me. 

**Since I am not sure about the codes, it would not be correct to explain. That's why I'm just sharing bits of code.**


## Challenges
+ Write code that shows a UIAlertController when your beacon is first detected. Make sure you set a Boolean to say the alert has been shown, so it doesn’t keep appearing.
+ Go through two or three other iBeacons in the Detect Beacon app and add their UUIDs to your app, then register all of them with iOS. Now add a second label to the app that shows new text depending on which beacon was located.
+ Add a circle to your view, then use animation to scale it up and down depending on the distance from the beacon – try 0.001 for unknown, 0.25 for far, 0.5 for near, and 1.0 for immediate. You can make the circle by adding an image, or by creating a view that’s 256 wide by 256 high then setting its layer.cornerRadius to 128 so that it’s round.


## Write code that shows a UIAlertController when your beacon is first detected. Make sure you set a Boolean to say the alert has been shown, so it doesn’t keep appearing.
```swift
var alertWasTriggered: Bool = false


if let beacon = beacons.first {
    // add here
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
```

## Go through two or three other iBeacons in the Detect Beacon app and add their UUIDs to your app, then register all of them with iOS. Now add a second label to the app that shows new text depending on which beacon was located.

```swift
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
```
```swift
update(distance: beacon.proximity, beaconID: Int(truncating: beacon.major))

func update(distance: CLProximity, beaconID: Int) {
        UIView.animate(withDuration: 0.8) {
            self.beaconLabel.text = (beaconID == 123) ? "First Beacon" : (beaconID == 153) ? "Second Beacon" : (beaconID == 163) ? "Thirt Beaon" : "Beacon Not Found"
```

## Add a circle to your view, then use animation to scale it up and down depending on the distance from the beacon – try 0.001 for unknown, 0.25 for far, 0.5 for near, and 1.0 for immediate. You can make the circle by adding an image, or by creating a view that’s 256 wide by 256 high then setting its layer.cornerRadius to 128 so that it’s round.

```swift
@IBOutlet var circleImage: UIImageView!
 

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
```



## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

