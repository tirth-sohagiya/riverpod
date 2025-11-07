# book_club_app# Book Club App (Flutter + Riverpod)

This project is a simple Flutter application demonstrating clean architecture and state management using Riverpod.  
It allows users to view, sort, and explore a small collection of books. The goal is to show how to implement Riverpod correctly with a clear separation of data, logic, and UI.

---

## Overview

The Book Club app loads a list of books from a mock service and displays them in a scrollable list.  
Users can:
- Sort the list by author or title
- View book details on a separate screen
- Refresh the list to reload data

All app state (books, loading status, sorting preference, and selected book) is managed through **Riverpod** using the `StateNotifier` pattern.

---

## Architecture

The app follows a simple three-layer structure:

lib/
│
├── main.dart → Entry point; sets up ProviderScope and app theme
│
├── models/
│ └── book.dart → Defines the Book model
│
├── services/
│ └── book_service.dart → Mock data service simulating fetch and seed calls
│
├── providers/
│ └── book_providers.dart → Contains Riverpod providers and BooksNotifier
│
├── screens/
│ ├── home_page.dart → Main list of books with sorting and refresh
│ └── book_detail_page.dart→ Displays details for a selected book
│
└── widgets/
├── book_card_widget.dart→ Card layout for a book item
└── book_image_widget.dart→ Displays image or placeholder initials


---

## Riverpod Implementation

### 1. `bookServiceProvider`
A simple `Provider` that exposes an instance of `BookService`.  
This service is responsible for seeding and fetching books.

```dart
final bookServiceProvider = Provider<BookService>((ref) => BookService());

2. booksNotifierProvider
A StateNotifierProvider exposing the BooksNotifier and its immutable BooksState.
final booksNotifierProvider =
    StateNotifierProvider<BooksNotifier, BooksState>((ref) {
  return BooksNotifier(ref);
});

3. BooksState
A plain data class holding all state fields:
books: current list of books
isLoading: whether data is being fetched
sortBy: current sorting method
selectedBook: book currently being viewed

4. BooksNotifier
A StateNotifier<BooksState> that manages all logic:
init() loads data and seeds initial books
_sortList() sorts by author or title
setSortBy() changes sorting order
selectBook() and backToList() manage navigation state
All UI reads or listens to this state through Riverpod’s ref.watch and triggers actions via ref.read.

How State Flows

Initialization
BooksNotifier calls init() in its constructor.
BookService seeds mock data and returns the book list.
State updates (isLoading → true → false), causing UI rebuild.

User Interaction
Sorting dropdown triggers setSortBy(), which updates the state and resorts the list.
Selecting a book triggers selectBook(), and the app navigates to the detail page.
Returning to the list calls backToList(), restoring the default state.

UI Integration

HomePage
A ConsumerWidget that watches booksNotifierProvider for reactive updates.
Uses a dropdown to change sorting and a RefreshIndicator to reload books.
On tap, navigates to the detail page and calls selectBook().

BookDetailPage
Reads the same provider to access the selected book.
Displays details such as title, author, description, and cover image.
Calls backToList() when the user returns.
All UI updates automatically when state changes — no manual setState() is used.

Running the App
Ensure Flutter is installed and configured.
Clone or download the project files.
From the project root, run:
flutter pub get
flutter run
