# Day 93 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day92-93/Day92-93"> Project </a>

## Developing on LocalAuthentication

## Subjects
+ Wrap Up
+ Challenges

## Challenges
+ Add a Done button as a navigation bar item that causes the app to re-lock immediately rather than waiting for the user to quit. This should only be shown when the app is unlocked.
+ Create a password system for your app so that the Touch ID/Face ID fallback is more useful. You'll need to use an alert controller with a text field like we did in project 5, and I suggest you save the password in the keychain!
+ Go back to project 10 (Names to Faces) and add biometric authentication so the user’s pictures are shown only when they have unlocked the app. You’ll need to give some thought to how you can hide the pictures – perhaps leave the array empty until they are authenticated?

## Add a Done button as a navigation bar item that causes the app to re-lock immediately rather than waiting for the user to quit. This should only be shown when the app is unlocked.
Don't think it's that long. One of the easiest challenges I've ever seen in my life.

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
...
navigationItem.rightBarButtonItem = nil
```
Indeed this produces the completely desired result. But where you place it matters. Where did we place it? Check it on project codes 🙂

## Create a password system for your app so that the Touch ID/Face ID fallback is more useful. You'll need to use an alert controller with a text field like we did in project 5, and I suggest you save the password in the keychain!
Hmm. Looking nice. Truly a challenge to beat. But it was still easy.

```swift
DispatchQueue.main.async {
    if success {
        self?.unlockSecretMessage()
    }else{
        let ac = UIAlertController(title: "Login unsuccessful!", message: "Do you wanna use password?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Use password", style: .default, handler: self?.unlockWithPassword))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self?.present(ac, animated: true)
    }
}
```

```swift
func unlockWithPassword(_ action: UIAlertAction? = nil){
  let passwordAc = UIAlertController(title: "Enter Your password", message: nil, preferredStyle: .alert)
  passwordAc.addTextField()

  let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak passwordAc] _ in
      guard let field = passwordAc?.textFields?[0].text else { return }
      self?.checkPassword(password: field)
  }

  passwordAc.addAction(submitAction)
  present(passwordAc, animated: true)
}

func checkPassword(password: String){
  let appPassword = KeychainWrapper.standard.string(forKey: "Password") ?? ""
  if password == appPassword{
      unlockSecretMessage()
  }else{
      let errorAc = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
      errorAc.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: unlockWithPassword))
      errorAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      present(errorAc, animated: true)
  }
}
```
What do our phones ask us after a failed biometric authentication? Of course whether we want to use a password or not. The flow is exactly the same. Oh, by the way. Our password is also encrypted.

## Go back to project 10 (Names to Faces) and add biometric authentication so the user’s pictures are shown only when they have unlocked the app. You’ll need to give some thought to how you can hide the pictures – perhaps leave the array empty until they are authenticated?
We flew to project 10 all of a sudden. Identity hiding service!!!

```swift
@objc func triggerAuth(){
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
        let reason = "Identfy yourself!"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, AuthError in
            if success{
                self?.loadPeoples()
            }else{
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Login unsuccessful!", message: "Do you wanna use password?", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Use password", style: .default, handler: self?.unlockWithPassword))
                    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    self?.present(ac, animated: true)
                }
            }
        }
    }
}

func unlockWithPassword(_ action: UIAlertAction? = nil){
    let passwordAc = UIAlertController(title: "Enter Your password", message: nil, preferredStyle: .alert)
    passwordAc.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak passwordAc] _ in
        guard let field = passwordAc?.textFields?[0].text else { return }
        self?.checkPassword(password: field)
    }

    passwordAc.addAction(submitAction)
    present(passwordAc, animated: true)
}

func checkPassword(password: String){
    let appPassword = "123456"
    if password == appPassword{
        self.loadPeoples()
    }else{
        let errorAc = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
        errorAc.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: unlockWithPassword))
        errorAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(errorAc, animated: true)
    }
}
```
It is exactly the same system we used above. Really! You may have seen that I only write some things async.

```swift
func loadPeoples(){
let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    let jsonDecoder = JSONDecoder()

    do {
        people = try jsonDecoder.decode([Person].self, from: savedPeople)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

    } catch {
        print("Failed to load people")
    }
}
```
I functionalized the operation we did at the beginning. Thus, users will not be filled until we run it. Never! In this way, we have the control and now we can manage the flow as we want. We ask for authentication as soon as the app is opened and when verified we fill in the data.


## You are best 🚀
<img src="https://i.pinimg.com/originals/25/63/8c/25638ca8b85cccc2d210923f86f3368b.gif">

