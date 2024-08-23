import SwiftUI

struct CardView: View {
    
    let imageUrl: URL
    
    var body: some View {
        AsyncImage(url: imageUrl)
        { image in
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
        } placeholder: {
            /*ProgressView()
             .frame(maxWidth: .infinity, maxHeight: .infinity)
             .background(.gray)*/
            Image(uiImage: UIImage(named: "TestProfileImage")!)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
    }
}
