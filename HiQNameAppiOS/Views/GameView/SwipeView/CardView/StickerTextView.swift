import SwiftUI

struct StickerTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.hiQLightPink)
            .bold()
            .italic()
            /*.font(.custom(
            "AmericanTypewriter",
            fixedSize: 60))*/
            .font(.system(size: 50))
            .CustomStroke(color: .hiQDeepPink, width: 1.5)
            .CustomStroke(color: .hiQLightPink, width: 2.0)
            .CustomStroke(color: .white, width: 1)
    }
}

extension View {
    func CustomStroke(color: Color, width: Double) -> some View {
        modifier(StrokeModifier(strokeSize: width, strokeColor: color))
    }
}

#Preview {
    StickerTextView(text: "Hello")
}

struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1
    var strokeColor: Color = .blue
    
    func body(content: Content) -> some View {
        content
            .padding(strokeSize*2)
            .background(Rectangle()
                .foregroundColor(strokeColor)
                .mask({
                    outline(context: content)
                })
            )
    }
    
    func outline(context: Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { layer in
                if let text = context.resolveSymbol(id: id) {
                    layer.draw(text, at: .init(x: size.width/2, y: size.height/2))
                }
            }
        }
        symbols: {
            context.tag(id)
                .blur(radius: strokeSize)
        }
    }
}
