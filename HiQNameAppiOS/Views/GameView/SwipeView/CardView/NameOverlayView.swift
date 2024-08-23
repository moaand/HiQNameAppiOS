import SwiftUI

struct NameOverlayView: View {
    
    let options: [Employee]
    let swipeDirection: Direction?
    let offset: CGSize
    
    var body: some View {
        ZStack {
            ForEach(Direction.allCases, id: \.self) { direction in
                NameOverlayItemView(
                    name: options[direction.rawValue].name,
                    swipeDirection: direction
                )
                .opacity(swipeDirection == direction ? offset == CGSize.zero ? 1 : max(abs(offset.width), abs(offset.height))/75.0 : 0)
            }
        }
        .padding()
        .padding(.bottom, 48)
    }
}
