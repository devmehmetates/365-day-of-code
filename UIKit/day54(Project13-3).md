# Day 54 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day52-54/Day52-54"> Project </a>

## Developing on CoreImage

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Try making the Save button show an error if there was no image in the image view.
+ Make the Change Filter button change its title to show the name of the currently selected filter.
+ Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.


### Try making the Save button show an error if there was no image in the image view.
Let's create an alertcontroller as we always do. Let's trigger the alert if the photo is blank.
```swift
@IBAction func save(_ sender: Any) {
    if let image = imageView.image{
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }else{
        self.showErrorMessage(title: "An Error!", message: "You don't select any image.\nPlease try again after choice a image by photo library.")
    }
}
```
```swift
func showErrorMessage(title: String, message: String? = nil){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    present(ac,animated: true)
}
```

### Make the Change Filter button change its title to show the name of the currently selected filter.
This is easy section. All we have to do is do some editing. Try finding it from commits :)
```swift
func setFilter(_ action: UIAlertAction? = nil){

    guard let actionTitle = action?.title else { return }

    title = actionTitle.replacingOccurrences(of: "CI", with: "")

    guard currentImage != nil else { return }

    currentFilter = CIFilter(name: actionTitle)

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

    DispatchQueue.main.async {
        self.applyProcessing()
        self.radiusProcessing()
        self.scaleProcessing()
    }
}
```

### Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
Here is the hardest part. In this part, I experienced both auto layout and sliders. We added 2 more sliders and wrote 2 special functions for them. Of course, we also updated our existing function.
```swift
@IBOutlet var intensity: UISlider!
@IBOutlet var radiusSlider: UISlider!
@IBOutlet var scaleSlider: UISlider!
```

```swift
@IBAction func intensityChange(_ sender: Any) {
    DispatchQueue.main.async {
        self.applyProcessing()
    }
}


@IBAction func radiusChanged(_ sender: Any) {
    DispatchQueue.main.async {
        self.radiusProcessing()
    }
}

@IBAction func scaleChanged(_ sender: Any) {
    DispatchQueue.main.async {
        self.scaleProcessing()
    }

}
```
```swift
func applyProcessing(){
    guard let currentImage = currentImage else{ return }

    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
}

func radiusProcessing(){
    guard currentImage != nil else{ return }
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(radiusSlider.value * 200, forKey: kCIInputRadiusKey) }
    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }

}

func scaleProcessing(){
    guard currentImage != nil else{ return }
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(scaleSlider.value * 10, forKey: kCIInputScaleKey) }
    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
}
```

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>


