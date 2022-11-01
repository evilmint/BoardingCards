import SwiftUI

struct Card<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer().frame(width: 0, height: 6)
            content()
            Spacer().frame(width: 0, height: 6)
        }
        .background(Color.white)
        .border(BoardingCardsColor.primary, width: 2)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Card {
                Text("Hello")
            }
            Spacer()
        }.frame(width: .infinity, height: 0)
    }
}
