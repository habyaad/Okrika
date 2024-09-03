# Okrika
## Product Catalog App

### Overview
The Product Catalog App is a Flutter-based mobile application that allows users to browse, manage, and filter a list of products. The app provides a clean and user-friendly interface for viewing product details, filtering by category or price, and managing products through adding, editing, and deleting functionalities. The project follows clean architecture principles, leveraging Riverpod for state management, and implements a repository pattern for data handling.

### Features
 -  Product Browsing: View a list of products with details like name, price, description, and image.
 - Product Filtering: Filter products by category or price range. 
 - Product Management:Add new products with fields such as name, description, price, category, and image. 
 - Edit existing products. 
 - Delete products with a confirmation prompt. 
 - State Management: Efficient state management using Riverpod. 
 - Local Database Integration: SQLite used for local data persistence.

### Project Structure
The project is organized using a feature-first approach with a clean architecture setup, ensuring that the app is scalable, maintainable, and easy to navigate. The repository pattern is implemented to handle data operations, making the app's architecture more robust and testable.

### Getting Started

#### Prerequisites 
   - Flutter SDK installed on your local machine. 
   - A code editor like VSCode or Android Studio.

#### Setup Instructions

   - Clone the repository:

        <code> git clone https://github.com/your-username/product-catalog-app.git </code> <br>
        <code> cd product-catalog-app </code>
     
   -  Install dependencies:
      <code> flutter pub get </code>

   - Run the app:
     <code> flutter run </code>

   - To run tests:
     <code> flutter test </code>

### Design Decisions, Optimizations, and Trade-offs
#### Design Decisions
  - Riverpod for State Management: Chosen for its simplicity, scalability, and ease of integration with Flutter's build context. Riverpod allows for efficient management of state and dependency injection without boilerplate. 
  - Clean Architecture: Adopted to ensure separation of concerns, making the app more modular and easier to maintain. The architecture divides the app into distinct layers, such as presentation, domain, and data, each with its own responsibility. 
  - Repository Pattern: Implemented to manage data operations cleanly and consistently. This pattern abstracts the data source, making it easier to swap out local databases or introduce remote data sources in the future.

#### Optimizations
  - Lazy Loading and Efficient Builds: Careful attention was paid to avoid unnecessary widget rebuilds, leveraging const constructors and selective rebuilding of UI components using Consumer widgets. 
  - Performance Profiling: The app was profiled using Flutter’s tools to identify and mitigate performance bottlenecks, ensuring a smooth user experience even with large data sets.

#### Trade-offs
  - No Offline Sync: Given the local-only database setup, offline synchronization was not implemented, although the architecture allows for easy extension if needed in the future. 
  - Limited Animations: To maintain simplicity and focus on core functionality, the use of animations was kept minimal.

  - Quality picture: I could not really outsource for high quality pictures so, i worked with what i had.

#### State Management Solution
    The app uses Riverpod for state management, chosen for its ability to decouple business logic from the UI and handle complex state scenarios with ease. Riverpod provides a robust and scalable solution for managing the app's state, particularly with the use of StateNotifier and FutureProvider to manage asynchronous operations and UI updates.

    Key Riverpod Implementations
        FetchProductsProvider: Manages the fetching and filtering, adding and editing of products.
        FetchSingleProductProvider: Manages the fetching of a single product
        
    The providers are autodisposed except when they are kept alive while being listened to for data persistence, making this an efficient state management solution.

    The clean separation of these concerns allows for better testability and code maintenance.

### Previews
<img height="400" alt="Screen Shot 2024-09-03 at 23 15 35" src="https://github.com/user-attachments/assets/37ceba84-fcf6-49c0-9f68-f84850af5932">

<img height="400" alt="Screen Shot 2024-09-03 at 23 09 15" src="https://github.com/user-attachments/assets/20c3a4ca-ab9c-4cd5-ac67-3f31e5af4fa3">

<img height="400" alt="Screen Shot 2024-09-03 at 23 11 25" src="https://github.com/user-attachments/assets/3204a098-998d-43d0-b0a5-a55332d72e49">

<img height="400" alt="Screen Shot 2024-09-03 at 23 12 32" src="https://github.com/user-attachments/assets/b1db2469-9532-454b-bbad-4293fc6c04f5">

<img height="400" alt="Screen Shot 2024-09-03 at 23 12 55" src="https://github.com/user-attachments/assets/7b760119-c381-4dfd-b83a-8e60732eb08b">

<img height="400" alt="Screen Shot 2024-09-03 at 23 16 20" src="https://github.com/user-attachments/assets/3e7d84b8-e506-4e49-ba84-a3c1be28c970">


### Link to download apk - 
