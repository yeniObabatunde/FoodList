# Food App iOS

A modern iOS application for managing and discovering food items, built with a combination of SwiftUI and UIKit. This app follows MVVM architecture and employs protocol-oriented programming with dependency injection for better testability and maintainability.

## Features

- **Food Dashboard**: Browse a collection of food items with image, title, calorie information, and tags
- **Add New Foods**: Take photos or upload images to add new food items with detailed information
- **Food Details**: View comprehensive details about selected food items
- **Category Filtering**: Filter food items by different meal categories
- **Image Caching**: Efficient image loading and caching system for better performance

### Demo
<div align="leading">
  <img src="https://github.com/user-attachments/assets/1454811b-5414-4e1a-960e-c513de1c66b9" alt="gif" width="200">
</div>

### Screenshots
<div style="display: flex; justify-content: space-between;">
 <img src="https://github.com/user-attachments/assets/adc8f235-26b8-462e-89cd-a007d2117f4a" width="200" alt="Food Recipe List">
 <img src="https://github.com/user-attachments/assets/1fd4dd40-8586-4a34-b643-cb6dad886593" width="200" alt="Food Recipe Details">
  <img src="https://github.com/user-attachments/assets/2e7a92ad-262f-4f0e-9aae-65553ca76e51" width="200" alt="Add Food Recipe">
</div>

## Architecture & Design Patterns

### MVVM (Model-View-ViewModel)
The app follows the MVVM architecture pattern for clean separation of concerns:
- **Models**: Data structures like `FoodModelDatum` for representing food items
- **Views**: SwiftUI views and UIKit controllers for UI representation
- **ViewModels**: Classes like `FoodListViewModel` that handle business logic

### Protocol-Oriented Programming
Interfaces are defined as protocols with concrete implementations, allowing for:
- Better testability through dependency injection
- Clearer contracts between components
- Easier maintenance and extension of functionality

```swift
protocol FoodListServiceProtocol {
    func fetchList() -> AnyPublisher<FoodModelWrapper, NetworkError>
    func updateFoodList(body: AddFoodRequest) -> AnyPublisher<AddFoodResponseModelWrapper, NetworkError>
}
```

### Dependency Injection
Services and dependencies are injected rather than hardcoded:

```swift
init(serviceDI: ServiceDIContainerProtocol) {
    self.serviceDI = serviceDI
}
```

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Installation

1. Clone the repository
2. Open the project in Xcode
3. Install dependencies with Swift Package Manager (if not automatically resolved)
4. Build and run the application

## UI Implementation

### SwiftUI
SwiftUI is used for the main dashboard and add food screens, taking advantage of:
- Declarative UI syntax
- Reactive updates with @State and @Published properties
- Composition with small, reusable view components

### UIKit
UIKit is used for the details page and some specialized components:
- Camera integration with UIImagePickerController
- Photo library access with PHPickerViewController
- Complex UI layouts where needed

### Hybrid Approach
The app demonstrates how to effectively combine SwiftUI and UIKit:
- UIViewControllerRepresentable for wrapping UIKit controllers in SwiftUI
- Navigation between SwiftUI and UIKit views

## Networking

### Combine Framework
Network requests are handled using Apple's Combine framework:
- AnyPublisher return types for asynchronous operations
- Error handling through publishers
- Clean cancellation with AnyCancellable sets

### Multipart Form Data
Support for uploading images through multipart/form-data:
- Custom multipart request builder
- File and field encoding
- Proper MIME type handling

## Image Handling

### Custom Image Caching
Efficient image loading and caching with custom implementation:

```swift
struct CachedAsyncImage: View {
    let url: URL?
    
    @State private var image: Image?
    @State private var isLoading = true
}
```

### Camera & Photo Library Integration
Full support for taking photos and selecting from the photo library:
- Camera access for taking photos directly in the app
- Photo library picker with multi-selection support
- Image processing for upload optimization

## Dependencies

- **IQKeyboardManager** (via Swift Package Manager): For handling keyboard interactions and text field focusing

## Custom Components

- **Custom Navigation Header**: Consistent navigation experience
- **Tag Input System**: Add and remove tags with visual feedback
- **Category Filter**: Horizontally scrollable category selection
- **Food Item Cards**: Visual display of food items with consistent styling

## Future Enhancements

- **List Caching**: Cache list data for offline access
- **Dark/Light Mode**: Support for system-wide appearance settings
- **Comprehensive Testing**: Unit and UI tests for all components
- **Localization**: Support for multiple languages
