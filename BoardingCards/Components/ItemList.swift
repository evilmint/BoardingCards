import SwiftUI

fileprivate class ItemListStorage<Element> {
    var onItemTap: ((Element) -> Void)?
}

struct ItemList<Data, ID, Content> : View
    where
        Data : RandomAccessCollection,
        Data.Element : Identifiable,
        Content : View,
        ID == Data.Element.ID
{
    private let storage = ItemListStorage<Data.Element>()

    let data: Data
    let content: (Data.Element) -> Content

    public init(_ data: Data, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }

    var body: some View {
        List {
            ForEach(data) { data in
                VStack(alignment: .leading, spacing: 0) {
                    content(data)
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 8))

                    Spacer()

                    Divider()
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                        .background(BoardingCardsColor.primary)
                }
                .background(Color.white)
                .listRowInsets(EdgeInsets())
                .onTapGesture { self.storage.onItemTap?(data) }
            }.listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .border(BoardingCardsColor.primary, width: 2)
    }

    func onItemTap(_ onItemTap: @escaping (Data.Element) -> Void) -> Self {
        self.storage.onItemTap = onItemTap
        return self
    }
}

private struct PreviewData: Hashable, Identifiable {
    let id = UUID()
    let string: String
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        let strings = (1...10)
            .map(String.init)
            .map(PreviewData.init)

        ItemList(strings) { data in
            Text(data.string)
        }
    }
}
