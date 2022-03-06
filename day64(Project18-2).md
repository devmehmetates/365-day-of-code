# Day 65 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day64-65/Day64-65"> Project </a>

## Developing on Debugging

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Temporarily try adding an exception breakpoint to project 1, then changing the call to instantiateViewController() so that it uses the storyboard identifier “Bad” – this will fail, but your exception breakpoint should catch it.
+ In project 1, add a call to assert() in the viewDidLoad() method of DetailViewController.swift, checking that selectedImage always has a value.
+ Go back to project 5, and try adding a conditional breakpoint to the start of the submit() method that pauses only if the user submits a word with six or more letters.

## Temporarily try adding an exception breakpoint to project 1, then changing the call to instantiateViewController() so that it uses the storyboard identifier “Bad” – this will fail, but your exception breakpoint should catch it.
In this part, our purpose is not to write code. Let's Debugging.

```swift
if let vc = storyboard?.instantiateViewController(withIdentifier: "Bad") as? DetailViewController{
```
It's a bad identifier. But we have an breakpoint this line.

## In project 1, add a call to assert() in the viewDidLoad() method of DetailViewController.swift, checking that selectedImage always has a value.
```swift
assert(selectedImage != "", "Photo Error!")
```
Do we have a picture name?

## Go back to project 5, and try adding a conditional breakpoint to the start of the submit() method that pauses only if the user submits a word with six or more letters.
<img width="632" alt="Ekran Resmi 2022-03-06 07 53 21" src="https://user-images.githubusercontent.com/74152011/156909772-cdec8c13-f135-415c-adcf-3e842a102bd6.png">

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>


