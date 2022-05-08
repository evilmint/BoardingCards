import SwiftUI

struct LoadingView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Spacer()
                    VStack {
                        PieChartView(
                            values: [30, 60, 45, 225],
                            colors: [
                                Color.white,
                                Color.gray.opacity(0.3),
                                Color.gray.opacity(0.7),
                                Color.gray,
                            ]
                        ).frame(
                            width: proxy.size.width * 0.3,
                            height: proxy.size.width * 0.3,
                            alignment: .center
                        )
                        Text("Sorting...")
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
        }.background(BoardingCardsColor.background)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
