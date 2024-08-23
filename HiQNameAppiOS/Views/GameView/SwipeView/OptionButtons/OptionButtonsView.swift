import SwiftUI

struct OptionButtonsView: View {

    var options: [Employee]
    
    @Binding
    var swipeDirection: Direction?
    
    var onSelect: (Employee, Double,Double) -> ()
    
    var body: some View {
        HStack {
            if options.count >= 3 {
                ForEach(Direction.allCases, id: \.self) { direction in
                    OptionButtonView(
                        name: options[direction.rawValue].name,
                        isSwiped: swipeDirection == direction,
                        didPressButton: {
                            swipeDirection = direction
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if direction == .up {
                                    onSelect(options[direction.rawValue], 0, -1)
                                } else if direction == .left {
                                    onSelect(options[direction.rawValue], -1, 0)
                                } else if direction == .right {
                                    onSelect(options[direction.rawValue], 1, 0)
                                }
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .opacity((swipeDirection != nil && swipeDirection != direction) ? 0 : 1)
                }
            }
        }
        .padding(16)
    }
}
