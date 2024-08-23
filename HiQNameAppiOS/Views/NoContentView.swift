import SwiftUI

struct NoContentView: View {
    
    var body: some View {
        VStack {
            Text(Image(systemName: "photo.stack")).foregroundStyle(.hiQDeepPink) + Text("No employees found")
        }
    }
}
