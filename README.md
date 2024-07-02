## Todo App
A Flutter application for managing todos with local storage and basic CRUD functionalities.

## Features
# Setup and Dependencies:

* Built using Flutter framework (version 3.x).
* Utilizes Hive for local database management.
* Uses the HTTP package for API calls (sync feature not implemented yet).
* Implements BLoC (Business Logic Component) for state management.

## Data Model:

# Todo Model:
# Attributes:
* id (int)
* title (String)
* description (String)
* status (enum: todo, inprogress, done)
* createdAt (DateTime)
* updatedAt (DateTime)
Serialization: Models are serializable for both Hive storage and API communication.

## Local Database (Hive):

* Set up Hive for local storage.
* Implemented Hive adapters for the Todo model.
* Handles database initialization and open/close operations correctly.

## API Integration:

# Service Class:
Handles API requests.

# Functions implemented:
* Fetch todos from the server.
* Add new todo to the server.
* Update existing todo on the server.
* Delete todo from the server.
* Syncing Todos with Server:
* Offline First: Todos are stored locally first.
* Manual Sync: UI button for manual sync with the server (not yet implemented).
* Automatic Sync: Background sync when internet connection is detected (not yet implemented).
* Conflict Handling: Pending implementation (e.g., prefer server data or merge changes). (not yet implemented)

## UI/UX:

Simple and intuitive UI design.

# Features:
* List todos with status indicators.
* Add new todo with validation.
* Edit existing todo.
* Delete todo.
* Display sync status (synced, pending, failed). (not yet implemented)
* Manual sync button for user-initiated synchronization.
* Ensures responsiveness and accessibility. (not yet implemented)

# Error Handling:

* Robust error handling for network issues, database errors, and other potential failures.
* Provides meaningful feedback to the user.


## Architecture
# Architecture Pattern:

* Follows BLoC (Business Logic Component) architecture for state management.
* Separation of concerns: UI, Business Logic, Data.
* Modular structure for scalability and maintainability.

## Documentation
# Setup:

* Clone the repository.
* Ensure Flutter SDK is installed and configured.
* Run flutter pub get to install dependencies.
* Running the Project:

Use an Android emulator or iOS simulator, or a physical device connected to run the app.
Execute flutter run from the project root directory.
Code Documentation:

Additional comments within the code as necessary to explain complex logic or implementation details.
