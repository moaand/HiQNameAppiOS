import SwiftUI

struct NameOverlayItemView: View {
    
    let name: String
    let swipeDirection: Direction
    
    init(name: String, swipeDirection: Direction) {
        let separators = CharacterSet(charactersIn: "_. \n\t")
        self.name = name.components(separatedBy: separators).first?.uppercased() ?? ""
        self.swipeDirection = swipeDirection
    }

    var body: some View {
        VStack {
            
            if swipeDirection == .up {
                Spacer()
            }
            
            HStack {
                
                if swipeDirection == .left {
                    Spacer()
                }

                StickerTextView(text: name)

                if swipeDirection == .right {
                    Spacer()
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            
            if swipeDirection == .left || swipeDirection == .right {
                Spacer()
            }
        }
    }
}
