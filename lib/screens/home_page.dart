import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/book_providers.dart';
import '../widgets/book_card_widget.dart';
import 'book_detail_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booksNotifierProvider);
    final notifier = ref.read(booksNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Club'),
        actions: [
          DropdownButton<SortBy>(
            value: state.sortBy,
            underline: const SizedBox(),
            icon: const Icon(Icons.sort, color: Colors.white),
            dropdownColor: Colors.white,
            onChanged: (value) {
              if (value != null) notifier.setSortBy(value);
            },
            items: const [
              DropdownMenuItem(value: SortBy.author, child: Text('Sort by Author')),
              DropdownMenuItem(value: SortBy.title, child: Text('Sort by Title')),
            ],
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.books.isEmpty
              ? const Center(child: Text('No books available'))
              : RefreshIndicator(
                  onRefresh: notifier.init,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      final book = state.books[index];
                      return BookCardWidget(
                        book: book,
                        onTap: () {
                          notifier.selectBook(book);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailPage(bookId: book.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
