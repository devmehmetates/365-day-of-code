# Day 83 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day83-84/Day83-84"> Project </a>

## Developing on Extensions

## Subjects
+ Setting up
+ Importing photos again
+ Going peer to peer: MCSession, MCBrowserViewController
+ Invitation only: MCPeerID

## Note:
Greetings again. Some of the code we wrote today is repeating itself, which will stretch the file. So I'm skipping some of the same parts.

## Importing photos again (Passed)

## Going peer to peer: MCSession, MCBrowserViewController

```swift
import MultipeerConnectivity

var peerID = MCPeerID(displayName: UIDevice.current.name)
var mcSession: MCSession?
var mcAdvertiserAssistant: MCAdvertiserAssistant?

mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
mcSession?.delegate = self

func startHosting(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
    mcAdvertiserAssistant?.start()
}

func joinSession(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
    mcBrowser.delegate = self
    present(mcBrowser, animated: true)
}
```

Here are some new codes. It serves to publish or join a room. They have their own delegates and classes for them, of course.

## Invitation only: MCPeerID
There is a lot of unused and unnecessary code here. Let's make it as short as possible and make it look nice.

```swift
func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true)
}

func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true)
}
```
For example, these two codes only render the page in cancellation and termination operations. is closing.

```swift
func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch state {
    case .connected:
        print("Connected: \(peerID.displayName)")

    case .connecting:
        print("Connecting: \(peerID.displayName)")

    case .notConnected:
        print("Not Connected: \(peerID.displayName)")

    @unknown default:
        print("Unknown state received: \(peerID.displayName)")
    }
}
```

```swift
method, just after the call to reloadData():

guard let mcSession = mcSession else { return }
if mcSession.connectedPeers.count > 0 {
    if let imageData = image.pngData() {
        do {
            try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
        } catch {
            // 5
            let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
```
Now our case here is almost the most important part. The first code just shows our connection status. The second code is if there is a device we are connected to, if a picture is added to this device, it adds it to our table. That's all.


## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

