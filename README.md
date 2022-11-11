# Number and Date Trivia App

Flutter project built using Clean Architecture and Test Driven Development. The project is an up-to-date version of Reso Coder's [TDD course.](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech)

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Architecture

The project is build using Clean Architecture as described by Uncle Bob. The image below gives a high level overview of the structure used 👇🏾

TODO: Add image

The project consists of three distinct layers. The Presentation layer, Domain layer and Data layer. Let's start from the layer farthest from our UI.

### Data Layer

This layer consists of three main components - `Datasources`, `Models` and `Repositories`. The ` datasources` communicate with external data providers such as an API, a database or a device feature (e.g. battery, location). It receives raw data in the form of JSON, xml or binary and converts them `models`. `Models` are basically pure dart objects. `Repositories` allow interaction between the Domain layer and Data layer.

### Domain Layer

This layer consists of `Repositories`, `Entities` and `Usecases`.

### Presentation Layer

This layer consists of `PresentationLogicHolders` and `Widgets`. `PresentationLogicHolder` is basically what you use for state management.
