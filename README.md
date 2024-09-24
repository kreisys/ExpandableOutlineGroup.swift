# ExpandableOutlineGroup

This is a workaround for the current native `OutlineGroup` from Apple, which doesn't support expanding all nodes by default.

## Installation

### Swift Package Manager

To install `ExpandableOutlineGroup` using Swift Package Manager, add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kreisys/ExpandableOutlineGroup.swift.git", from: "1.0.0")
]
```

Then, add `ExpandableOutlineGroup` as a dependency for your target:

```swift
.target(
    name: "YourTargetName",
    dependencies: ["ExpandableOutlineGroup"]
)
```

## Usage

### Basic Example

Here is a basic example of how to use `ExpandableOutlineGroup` in your SwiftUI application:

```swift
import SwiftUI
import ExpandableOutlineGroup

struct ContentView: View {
    var body: some View {
        ExpandableOutlineGroup(rootNodes, id: \.self, children: \.children) {
            Text(item.title)
        }
    }
}

struct Item: Identifiable {
    let title: String
    let children: [Item]?
}

let sampleData: [Item] = [
    Item(title: "Parent 1", children: [
        Item(title: "Child 1.1", children: nil),
        Item(title: "Child 1.2", children: nil)
    ]),
    Item(title: "Parent 2", children: [
        Item(title: "Child 2.1", children: nil)
    ])
]
```

## License

`ExpandableOutlineGroup` is released under the MIT License. See the `LICENSE` file for more information.

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.
