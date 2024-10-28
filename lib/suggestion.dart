// SuggestionList widget modification to include onSelect callback
import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  final List<String> suggestions; // List of suggestions to display
  final void Function(int index)
      onAccept; // Callback function when a suggestion is accepted
  final void Function(int index)
      onReject; // Callback function when a suggestion is rejected
  final VoidCallback onSelect; // Callback function to enable editing

  // Constructor for SuggestionList
  const SuggestionList({
    super.key,
    required this.suggestions,
    required this.onAccept,
    required this.onReject,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows the ListView to be sized based on its content
      itemCount: suggestions.length, // Number of items in the list
      itemBuilder: (context, index) {
        // Builds each list item
        return Card(
          margin:
              const EdgeInsets.symmetric(vertical: 8.0), // Space between cards
          child: ListTile(
            title: Text(suggestions[index]), // Display the suggestion text
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Minimize the row's width
              children: [
                // Button for enabling editing and selecting the suggestion
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onSelect, // Trigger onSelect to enable editing
                ),
                // Button for accepting the suggestion
                IconButton(
                  icon: const Icon(Icons.check,
                      color: Colors.green), // Green check icon
                  onPressed: () => onAccept(
                      index), // Trigger onAccept callback with the index
                ),
                // Button for rejecting the suggestion
                IconButton(
                  icon: const Icon(Icons.close,
                      color: Colors.red), // Red close icon
                  onPressed: () => onReject(
                      index), // Trigger onReject callback with the index
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
