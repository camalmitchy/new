import 'package:doc/suggestion.dart';
import 'package:doc/viewer.dart';
import 'package:flutter/material.dart';

// Stateful widget that serves as the main screen of the app, displaying documents and suggestions
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample content for the original and improved documents
  String originalDocument = 'This is the original document content...';
  String improvedDocument = 'This is the improved document content...';

  // List of suggestions for improving the document
  List<String> suggestions = [
    'Suggestion 1: Replace "..." with "better text"',
    'Suggestion 2: Rephrase the second paragraph for clarity',
    'Suggestion 3: Add a heading to the third section',
  ];

  bool isEditingEnabled =
      false; // Controls whether the improved side is editable

  // Function to handle accepting a suggestion
  void _acceptSuggestion(int index) {
    setState(() {
      suggestions
          .removeAt(index); // Remove the accepted suggestion from the list
      isEditingEnabled = false; // Disable editing after accepting
    });
    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Suggestion accepted'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Function to handle rejecting a suggestion
  void _rejectSuggestion(int index) {
    setState(() {
      suggestions
          .removeAt(index); // Remove the rejected suggestion from the list
      isEditingEnabled = false; // Disable editing after rejecting
    });
    // Show a rejection message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Suggestion rejected'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Function to enable editing on the improved side
  void _enableEditing() {
    setState(() {
      isEditingEnabled = true; // Enable editing when a suggestion is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Set the app bar color to purple
        title: const Text('DocuMatic'), // Display the app title
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Add padding around the main content
        child: Column(
          children: [
            // Dual-pane view for original and improved documents
            Expanded(
              child: Row(
                children: [
                  // Original Document (read-only)
                  Expanded(
                    child: DocumentViewer(
                      title:
                          'Original Document', // Title for the original document
                      content: originalDocument, // Display original content
                    ),
                  ),
                  // Improved Document (editable based on state)
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Improved Document',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(8.0),
                              child: isEditingEnabled
                                  ? TextFormField(
                                      initialValue: improvedDocument,
                                      onChanged: (text) {
                                        setState(() {
                                          improvedDocument = text;
                                        });
                                      },
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Edit the improved content',
                                      ),
                                    )
                                  : Text(improvedDocument),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
                height:
                    16.0), // Add spacing between document view and suggestions

            // Show suggestions if available
            if (suggestions.isNotEmpty)
              Expanded(
                child: SuggestionList(
                  suggestions: suggestions, // Provide suggestions list
                  onAccept: _acceptSuggestion, // Accept callback function
                  onReject: _rejectSuggestion, // Reject callback function
                  onSelect:
                      _enableEditing, // Enable editing when a suggestion is selected
                ),
              ),

            // Show a message when no more suggestions are available
            if (suggestions.isEmpty)
              const Text('No more suggestions available.'),
          ],
        ),
      ),
    );
  }
}
