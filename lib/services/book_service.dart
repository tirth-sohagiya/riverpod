import 'dart:async';
import '../models/book.dart';

class BookService {
  final List<Book> _books = [];

  // Simulate fetching books (like from a database or API)
  Future<List<Book>> fetchBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _books;
  }

  // Seed initial books only once
  Future<void> seedBooks(List<Book> books) async {
    if (_books.isEmpty) {
      _books.addAll(books);
    }
  }
}
