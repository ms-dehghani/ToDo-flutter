# Todo Application

This is a simple todo application that allows you to add, delete, and mark tasks as complete. It is built using Flutter.

## Technologies

We are using the following technologies:

- Flutter & Dart
- Clean Architecture principles
- Modular structure
- Dependency Injection
- Unit test

## Architecture

The app is built using the Clean Architecture principles. The app is divided into 3 modules:
* `app` - The main module that contains the UI and the DI setup.
* `data` - The module that contains the data layer. It contains the repository and the data sources.
* `domain` - The module that contains the business logic. It contains the use cases and the models.

Every module is independent and can be tested separately. also they work together to achieve the final result.
this architecture makes the app more maintainable and testable and also makes it easier to add new features.
each layer use their own models and mappers to make the app more flexible and easy to maintain.
this is schema of the architecture:

![Alt text](./resource/architecture.png?raw=true "Architecture")

## UI
The UI is built using Jetpack Compose. The UI is divided into 2 screens:
* `ToDo List Screen` - The main screen that contains the list of todos.
* `ToDo Detail Screen` - The screen that contains the details of a task.
* `Setting Screen` - The screen that contains the application settings.

![Alt text](./resource/main_screen.png?raw=true "ToDo List Screen")
![Alt text](./resource/detail_screen.png?raw=true "ToDo Detail Screen")
![Alt text](./resource/setting_screen.png?raw=true "Setting Screen")


## Testing
The app contains unit tests and UI tests.
* `app` - Contains the UI tests.
* `data` - Contains the unit tests for both api and mock .
* `domain` - Contains the unit tests for the use cases.

Fork and enjoy! 🚀