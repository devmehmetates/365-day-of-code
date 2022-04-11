# Day 53 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day52-54/Day52-54"> Project </a>

## Developing on CoreImage

## Subjects

+ Applying filters: CIContext, CIFilter
+ Saving to the iOS photo library

## Applying filters: CIContext, CIFilter
```swift
import CoreImage

var context: CIContext!
var currentFilter: CIFilter!
```

```swift
// viewDidLoad
context = CIContext()
currentFilter = CIFilter(name: "CISepiaTone")
```

```swift
@IBAction func sliderChange(_ sender: Any) {
    applyProcessing()
}

func applyProcessing(){
    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(slider.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(slider.value * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(slider.value * 10, forKey: kCIInputScaleKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
}
```

```swift
@IBAction func changeFilter(_ sender: Any) {
    let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
}
```

```swift
func setFilter(_ action: UIAlertAction? = nil){
    guard currentImage != nil else { return }

    guard let actionTitle = action?.title else { return }

    currentFilter = CIFilter(name: actionTitle)

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

    applyProcessing()
}
```
Explaining these codes will take a really long time and I don't have that much energy today. But I can sum it up like this.
+ activate sepia effect on startup
+ Change the filters on the core image with the change filter button
+ take the filter property and apply it to the picture at every filter change

## Saving to the iOS photo library
This part is something we are more or less familiar with (from "UIActivityViewController"). There is only one small innovation.
```swift
@IBAction func save(_ sender: Any) {
    guard let image = imageView.image else { return }

    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil) // is new
}
```

```swift
@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) { // completely new
    if let error = error {
        let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } else {
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
```
We're using a New feature here and it really does the job perfectly. So nice!

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

