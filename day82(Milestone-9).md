# Day 82 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day82.playground"> Project </a>

## Extension 

## Challenge.
Hey. Actually this is a not a hard challenge day. So I don't need to explain and explain at length. Let's look at the codes

```swift
extension UIView{
    func animateBounce(duration: CGFloat){
        UIView.animate(withDuration: duration, delay: 0) {
            self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }
    }
}

extension Int{
    func times(_ anyFunc: () -> Void ){
        guard self > 0 else { return }
        
        for _ in 0..<self{
            anyFunc()
        }
    }
}

extension Array where Element: Comparable{
    mutating func remove(item: Element){
        guard let elementIndex = (self.firstIndex { return $0 == item }) else { return }
        self.remove(at: elementIndex)
        
    }
}
```
We wrote 3 extensions. All tasks are available in hacking with swift. These are my own solutions. That's what it really was today.



