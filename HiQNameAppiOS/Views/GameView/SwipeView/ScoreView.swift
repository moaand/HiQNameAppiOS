import SwiftUI
struct ScoreView: View {
    
    var score: Int
    
    var body: some View {
        VStack {
            Label(
                title: { Text("\(score)") },
                icon: { Image(systemName: "star")}
            )
            .foregroundStyle(.black)
            .bold()
            .padding(8)
            .tint(.hiQDeepPink)
        }
        .background(.hiQLightPink)
        .cornerRadius(5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 2)
                .padding(3)
        }
        .padding(.top,8)
    }
}
