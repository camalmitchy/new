import 'package:flutter/material.dart';

// A widget that displays a document's content within a card, including a title and scrollable content
class DocumentViewer extends StatelessWidget {
  final String title; // The title of the document
  final String content; // The content of the document

  // Constructor to initialize the DocumentViewer with a title and content
  const DocumentViewer({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0), // Adds margin around the card
      child: Column(
        children: [
          // Displays the document title with some padding
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title, // The title text
              style: const TextStyle(
                fontSize: 18, // Sets the font size of the title
                fontWeight: FontWeight.bold, // Makes the title bold
              ),
            ),
          ),
          // Displays the document content in a scrollable view
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(8.0), // Adds padding around the content
              child: Text(content), // The content text
            ),
          ),
        ],
      ),
    );
  }
}
