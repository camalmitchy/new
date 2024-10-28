import 'package:doc/home.dart'; // Import the home screen file
import 'package:flutter/material.dart'; // Import Flutter material design package
import 'package:file_picker/file_picker.dart'; // Import package for file picking functionality

void main() {
  runApp(const DocuMatic()); // Launch the application
}

// Main application widget
class DocuMatic extends StatelessWidget {
  const DocuMatic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuMatic', // Set the title of the application
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: ThemeData(
        primarySwatch: Colors.purple, // Set primary color theme to purple
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // Adaptive density for different platforms
      ),
      home: const LandingScreen(), // Set the landing screen as the home screen
    );
  }
}

// Stateful widget for the landing screen
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LandingScreenState createState() =>
      _LandingScreenState(); // Create the state for the landing screen
}

// State class for the LandingScreen
class _LandingScreenState extends State<LandingScreen> {
  String? filePath; // Variable to store the selected file path
  bool isLoading = false; // State to manage loading indicator

  // Function to pick a file using FilePicker
  Future<void> _pickFile() async {
    setState(() => isLoading = true); // Show loading indicator

    // Allow user to pick a .pdf, .docx, or .txt file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'txt'], // Restrict file types
    );

    // Update state to hide loading indicator
    setState(() {
      isLoading = false;
    });

    // Validate the selected file, check extension, and update state
    if (result == null || !_isValidFile(result.files.single.extension)) {
      _showMessage('Please select a valid .pdf, .docx, or .txt file.',
          Colors.red); // Show error message for invalid file
    } else {
      setState(() {
        filePath = result.files.single.path; // Update the file path if valid
      });
      _showMessage('Document uploaded successfully!',
          Colors.green); // Show success message
    }
  }

  // Helper function to validate the file extension
  bool _isValidFile(String? extension) {
    return ['pdf', 'docx', 'txt']
        .contains(extension?.toLowerCase()); // Check if file type is allowed
  }

  // Function to show messages to the user
  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: color), // Display message with a background color
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('DocuMatic',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold)), // App title styling
        ),
        backgroundColor: Colors.purple, // AppBar background color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            if (isLoading)
              const CircularProgressIndicator(), // Show loading indicator if isLoading is true
            ElevatedButton(
              onPressed:
                  isLoading ? null : _pickFile, // Disable button while loading
              child: const Text('Pick a Document'), // Button text
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    'Selected File: $filePath'), // Display the selected file path
              ),
            if (filePath != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(), // Navigate to the HomeScreen
                    ),
                  );
                },
                child:
                    const Text('View Document'), // Button to view the document
              ),
          ],
        ),
      ),
    );
  }
}

// Stateless widget for displaying the document
class DocumentViewerScreen extends StatelessWidget {
  final String filePath; // Path to the file to be displayed

  const DocumentViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Viewer')), // AppBar title
      body: Center(
          child:
              Text('Displaying document: $filePath')), // Display the file path
    );
  }
}
