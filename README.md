# FlickrAppGarden

A sample app that introduces some iOS development techniques.

## Objective

The main objective of the project is to build a visually functional application that uses good user experience practices following the [Human Interface Guidelines (HIG)](https://developer.apple.com/design/human-interface-guidelines), using the latest technologies for iOS development and a solid architecture capable of scaling according to project needs.

## Tech Stack

This project uses the following technologies:
- SwiftUI
- Clean Architecture
- VIP Pattern with State
- Network layer using [async/await](https://developer.apple.com/videos/play/wwdc2021/10132/)
- Swift Package Manager
    - [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)

The project also has support for:
- Landscape orientation
- Localization
- Voice Control
- Dynamic Text
- Dark mode

## Technical explanation

### Architecture

Clean architecture is a very famous architecture used in several projects today. It is a very solid architecture with great expandability, we can also add to its qualities the ease of testing it and its fragmentation makes it easier to divide responsibilities within the project.

Something taken into consideration was that due to its pervasiveness in projects, if new developers contribute to the project in the future, this will reduce the cognitive load of the project on them.

### VIP Pattern
![](https://raw.githubusercontent.com/nalexn/blob_files/master/images/swiftui_arc_001_d.png)

VIP's biggest difference is the division of responsibilities, as in the image above it is possible to better observe this division between the layers. Another attractive point here is that this pattern works in a unidirectional way, that is, the information will always be passed on and will never be returned without having first been processed by other entities.

> There is a section in this [article](https://nalexn.github.io/clean-architecture-swiftui/) that talks about SwiftUI being based on the ELM concept.
It's well worth reading to compare with the one-way concept of VIP.

## Some Results

### Tests and Coverage
![](/screenshots/unit_tests.png)
![](/screenshots/coverage.png)

### Memory Usage
![](/screenshots/memory_use.png)

### Leak Checks
![](/screenshots/leak_instruments.png)

## References
[The Clean Code Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

[Clean Architecture for SwiftUI](https://nalexn.github.io/clean-architecture-swiftui/)
