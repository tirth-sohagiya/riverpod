import 'package:flutter/material.dart';
import '../models/book.dart';

class BookImageWidget extends StatelessWidget {
  final Book book;
  final double size;

  const BookImageWidget({
    super.key,
    required this.book,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    if (book.imageUrl.isNotEmpty) {
      return Image.asset(
        book.imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }

    final initials = _getInitials(book.title);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _getInitials(String text) {
    final words = text.trim().split(' ');
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }
}
