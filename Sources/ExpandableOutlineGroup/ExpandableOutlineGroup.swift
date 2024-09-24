//
//  ExpandableOutlineGroup.swift
//
//
//  Created by Kaï-Zen Berg-Šæmañn on 2024-09-24.
//

import SwiftUI

public struct ExpandableOutlineGroup<DataElement: Hashable, Content: View>: View {
  private let data: [DataElement]
  private let idKeyPath: KeyPath<DataElement, DataElement>
  private let childrenKeyPath: KeyPath<DataElement, [DataElement]?>
  private let content: (DataElement) -> Content

  @State private var isExpanded: Bool = true

  public init(_ data: [DataElement], id: KeyPath<DataElement, DataElement>, children: KeyPath<DataElement, [DataElement]?>, isExpanded: Bool = true, content: @escaping (DataElement) -> Content) {
    self.data = data
    self.idKeyPath = id
    self.childrenKeyPath = children
    self.isExpanded = isExpanded
    self.content = content
  }

  public var body: some View {
    ForEach(data, id: idKeyPath) {
      Node(node: $0, id: idKeyPath, children: childrenKeyPath, isExpanded: isExpanded, content: content)
    }
  }
}

private extension ExpandableOutlineGroup {
  struct Node: View {
    let dataElement: DataElement
    let idKeyPath: KeyPath<DataElement, DataElement>
    let childrenKeyPath: KeyPath<DataElement, [DataElement]?>
    @State var isExpanded: Bool = true
    let content: (DataElement) -> Content

    init(node: DataElement, id: KeyPath<DataElement, DataElement>, children: KeyPath<DataElement, [DataElement]?>, isExpanded: Bool = true, content: @escaping (DataElement) -> Content) {
      self.dataElement = node
      self.idKeyPath = id
      self.childrenKeyPath = children
      self.isExpanded = isExpanded
      self.content = content
    }

    var body: some View {
      if let children = dataElement[keyPath: childrenKeyPath] {
        DisclosureGroup(isExpanded: $isExpanded) {
          ForEach(children, id: idKeyPath) { childNode in
            Node(node: childNode, id: idKeyPath, children: childrenKeyPath, isExpanded: isExpanded, content: content)
          }
        } label: {
          content(dataElement)
        }
      } else {
        content(dataElement)
      }
    }
  }
}

#if DEBUG
private struct Node: Hashable {
  let data: String
  let children: [Self]?
}

#Preview {
  @Previewable @State var selection: Node?
  @Previewable @State var rootNodes: [Node] = [
    Node(data: "A", children: [
      Node(data: "A1", children: nil),
      Node(data: "A2", children: nil),
    ]),
    Node(data: "B", children: [
      Node(data: "B1", children: nil),
      Node(data: "B2", children: nil),
    ]),
  ]

  List(selection: $selection) {
    ExpandableOutlineGroup(rootNodes, id: \.self, children: \.children) {
      Text("\($0.data)")
    }
  }
}
#endif // DEBUG
