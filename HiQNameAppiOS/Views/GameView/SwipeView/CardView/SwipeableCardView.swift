import SwiftUI

struct SwipableCardView: View {
    
    @ObservedObject
    var viewModel: SwipeViewModel
    
    var body: some View {
        CardView(imageUrl: viewModel.currentImageUrl)
            .overlay(
                NameOverlayView(
                    options: viewModel.options,
                    swipeDirection: viewModel.swipeDirection,
                    offset: viewModel.offset
                )
            )
            .offset(x: viewModel.offset.width, y: viewModel.offset.height)
            .gesture(
                DragGesture()
                    .onChanged(viewModel.swipeChanged)
                    .onEnded(viewModel.swipeEnded)
            )
    }
}
