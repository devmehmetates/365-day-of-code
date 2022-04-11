# Day 92 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day92-93/Day92-93"> Project </a>

## Developing on LocalAuthentication

## Subjects
+ Setting up
+ The basic text editor
+ Writing somewhere safe: the iOS keychain
+ Touch to activate: Touch ID, Face ID and LocalAuthentication

## The basic text editor 
We're adding a page of text that's a really classic thing we've done before. Still, I leave the codes to remind you.
```swift
let notificationCenter = NotificationCenter.default
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

...

@objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
        secret.contentInset = .zero
    } else {
        secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }

    secret.scrollIndicatorInsets = secret.contentInset

    let selectedRange = secret.selectedRange
    secret.scrollRangeToVisible(selectedRange)
}
```

## Writing somewhere safe: the iOS keychain
We continue with a section that allows us to encrypt our content.

```swift
func unlockSecretMessage() {
    secret.isHidden = false
    title = "Secret stuff!"

    secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
}

@objc func saveSecretMessage() {
    guard secret.isHidden == false else { return }

    KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
    secret.resignFirstResponder()
    secret.isHidden = true
    title = "Nothing to see here"
}
```
Don't you think it is similar to userdefaults? Absolutely. Userdefaults wraps this class. This is how to save and read operations. But they work so well that even when you suspend the application, your information is locked.

## Touch to activate: Touch ID, Face ID and LocalAuthentication
Here is our case. We have to access this information with facial recognition. Foreigners are not allowed in!

```swift
import LocalAuthentication

@IBAction func authenticateTapped(_ sender: Any) {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "Identify yourself!"

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
            [weak self] success, authenticationError in

            DispatchQueue.main.async {
                if success {
                    self?.unlockSecretMessage()
                } else {
                   let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                   ac.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(ac, animated: true)
                }
            }
        }
    } else {
        let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}
```
In fact, such simple integrations are gradually increasing my temperature towards apple. Incredibly good.


## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

