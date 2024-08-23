import SwiftUI

struct OptionButtonView: View {
    
    let name: String
    let isSwiped: Bool
    let didPressButton: () -> ()
    
    init(name: String, isSwiped: Bool, didPressButton: @escaping () -> ()) {
        self.name = name
        self.isSwiped = isSwiped
        self.didPressButton = didPressButton
    }
    
    var body: some View {
        Button(action: didPressButton, label: {
            Text(name)
                .padding()
        })
        .buttonStyle(BlueButton(isSwiped: isSwiped))
    }
}

struct BlueButton: ButtonStyle {
    
    let isSwiped: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .background(.hiQDeepPink)
            .cornerRadius(10)
            .shadow(radius: 10)
            .scaleEffect(isSwiped ? 1.2 : configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.5), value: isSwiped || configuration.isPressed)
    }
}
