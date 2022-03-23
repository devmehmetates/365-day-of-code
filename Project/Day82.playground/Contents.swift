//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.animateBounce(duration: 3)
        label.textColor = .black
        
        let number = 5
        number.times {
            print("Hello world")
        }
        
        var array = ["Deneme", "deneme2", "deneme3" ,"deneme2"]
        print(array)
        array.remove(item: "deneme2")
        print(array)
        
        view.addSubview(label)
        self.view = view
    
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

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
