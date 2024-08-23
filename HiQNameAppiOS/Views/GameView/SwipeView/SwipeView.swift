import SwiftUI

struct SwipeView: View {
    
    @StateObject 
    var viewModel: SwipeViewModel
    
    init(viewModel: SwipeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            CardView(imageUrl: viewModel.nextImageUrl)
                .padding(16*getPaddingMultiplier())

            SwipableCardView(viewModel: viewModel)
            
            VStack {
                Spacer()
                OptionButtonsView(
                    options: viewModel.options,
                    swipeDirection: $viewModel.swipeDirection,
                    onSelect: viewModel.selectOption
                )
            }
        }
    }
    
    func getPaddingMultiplier() -> Double {
        let heightPercentage = abs(viewModel.offset.height)/(UIScreen.main.bounds.height*0.4)
        let widthPercentage = abs(viewModel.offset.width)/(UIScreen.main.bounds.width*0.4)
        return 1.0 - min(max(widthPercentage, heightPercentage), 1)
    }
}
