import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_image_widget.dart';

class BookCardWidget extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookCardWidget({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: BookImageWidget(book: book, size: 56),
        title: Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(book.author),
        onTap: onTap,
      ),
    );
  }
}
