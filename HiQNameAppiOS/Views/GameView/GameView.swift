import SwiftUI

struct GameView: View {

    @ObservedObject var viewModel: EmployeeViewModel

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {

            if 
                let currentImageUrl = URL(string: /*viewModel.getCurrentEmployee().imageUrl*/"https://www.google.com/"),
                let nextImageUrl = URL(string: /*viewModel.getNextEmployee().imageUrl*/"https://www.google.com/")
            {
                SwipeView(
                    viewModel:
                        SwipeViewModel(
                            options: viewModel.getEmployeeOptions(),
                            currentImageUrl: currentImageUrl,
                            nextImageUrl: nextImageUrl,
                            onSwipe: viewModel.handleSwipe
                        )
                )
            }

            ScoreView(score: viewModel.score)
        }
        .padding(.bottom)
    }
}
