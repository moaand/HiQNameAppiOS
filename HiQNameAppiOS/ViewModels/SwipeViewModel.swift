import SwiftUI

class SwipeViewModel : ObservableObject {
    
    @Published
    var swipeDirection: Direction? = nil
    
    @Published 
    var offset: CGSize = CGSize.zero
    
    var options: [Employee]
    let currentImageUrl: URL
    let nextImageUrl: URL
    let onSwipe: (Employee) -> ()
    
    init(options: [Employee], currentImageUrl: URL, nextImageUrl: URL, onSwipe: @escaping (Employee) -> ()) {
        self.options = options
        self.currentImageUrl = currentImageUrl
        self.nextImageUrl = nextImageUrl
        self.onSwipe = onSwipe
    }
    
    func swipeChanged(gesture: DragGesture.Value) {
        offset = gesture.translation
        
        withAnimation {
            swipeDirection = nil
            if (options.count >= 3 && max(abs(offset.height), abs(offset.width)) > 10) {
                
                if abs(offset.height) > abs(offset.width) {
                    if(offset.height < 0) {
                        swipeDirection = .up
                    }
                } else {
                    if (offset.width < 0) {
                        swipeDirection = .left
                    } else {
                        swipeDirection = .right
                    }
                }
            }
        }
    }
    
    func swipeEnded(gesture: DragGesture.Value) {
        
        if (max(abs(offset.height), abs(offset.width)) > 75 && swipeDirection != nil) {
            let selectedEmployee = options[swipeDirection!.rawValue]
            swipeDirection = nil
            
            let translationWidth = gesture.translation.width;
            let translationHeigth = gesture.translation.height;
            
            let xVelocity = (abs(translationWidth)/(abs(translationWidth)+abs(translationHeigth))) * (translationWidth < 0 ? -1 : 1)
            
            let yVelocity = (abs(translationHeigth)/(abs(translationWidth)+abs(translationHeigth))) * ( translationHeigth < 0 ? -1 : 1)
            
            selectOption(selectedEmployee, slideOutXVelocity: xVelocity, slideOutYVelocity: yVelocity)
            
        } else {
            swipeDirection = nil
            withAnimation {
                offset = CGSize.zero
            }
        }
    }
    
    func selectOption(_ selectedEmployee: Employee, slideOutXVelocity: Double = 0.0, slideOutYVelocity: Double = 0.0) {
        swipeDirection = nil
        slideOutImage(xVelocity: slideOutXVelocity, yVelocity: slideOutYVelocity)
        onSwipe(selectedEmployee)
    }
    
    func slideOutImage(xVelocity: Double, yVelocity: Double) {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            
            self.offset.width += 10 * xVelocity
            self.offset.height += 10 * yVelocity
            
            if (abs(self.offset.width) > UIScreen.main.bounds.width || abs(self.offset.height) > UIScreen.main.bounds.height) {
                self.offset = CGSize.zero;
                timer.invalidate()
            }
            
        })
        
        timer.fire()
    }
}
