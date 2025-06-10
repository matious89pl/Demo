# Demo - Pinch to Zoom & Drag

This is a demonstration app showcasing simultaneous pinch-to-zoom and drag gestures.

## Features

- **Pinch to Zoom**: Scale content using pinch gestures
- **Drag**: Move content around the screen with drag gestures
- **Simultaneous Gestures**: Both pinch and drag work at the same time for smooth, intuitive interaction

## How to Use

1. Use two fingers to pinch in/out to zoom the content
2. Use one or more fingers to drag the content around
3. Both gestures can be performed simultaneously for fluid navigation

## Build & Run

1. Open `Demo.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press `Cmd + R` to build and run

## SwiftUI Usage

The demo includes a `UIKitPinchPanImage` wrapper view that bridges UIKit's powerful gesture handling with SwiftUI. Here's how to use it:

### Basic Usage

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        UIKitPinchPanImage(imageName: "YourImageName")
    }
}
```

### Wrapper View Features

The `UIKitPinchPanImage` view provides:

- **Pinch to Zoom**: Zoom range from 1x to 5x scale
- **Pan/Drag**: Smooth dragging with automatic centering
- **Double Tap**: Reset to original size and position
- **Simultaneous Gestures**: Pinch and pan work together seamlessly
- **Bounce Animation**: Natural bounce effects when zooming
- **Auto-centering**: Image stays centered when smaller than container

### Customization

```swift
// Use default image named "Image"
UIKitPinchPanImage()

// Use custom image
UIKitPinchPanImage(imageName: "MyCustomImage")
```

### Integration Tips

1. Make sure your image is added to the app bundle
2. The wrapper automatically handles aspect ratio fitting
3. Gestures work on both simulator and device
4. The view respects SwiftUI layout constraints

## Requirements

- iOS 13.0+
- Xcode 12.0+ 