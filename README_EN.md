# Checksum

A clean and elegant macOS file checksum calculator supporting multiple hash algorithms.

[中文](README.md) | English

## Features

- 🔍 **Multiple Hash Algorithms** - MD5, SHA1, SHA256, SHA384, SHA512
- 🎯 **Drag & Drop Support** - Simply drag files into the application window
- 📊 **Real-time Progress** - Shows calculation progress for large files
- 🔍 **Hash Comparison** - Enter known hash values for verification
- 📋 **One-click Copy** - Copy hash values to clipboard with a single click
- 🎨 **Native Design** - Beautiful macOS-native interface
- 📁 **File Information** - Displays file name, size, and icon

## System Requirements

### Runtime Requirements

- macOS 15.1+

### Development Requirements

- macOS 15.7+
- Swift 6+
- Xcode 26+

## Installation

### Build from Source

1. Clone the repository:
```bash
git clone https://github.com/HongyuS/Checksum.git
cd Checksum
```

2. Open the project in Xcode:
```bash
open Checksum.xcodeproj
```

3. Build and run the application

## Usage

### Calculate File Hashes

1. **Method 1: Drag & Drop**
   - Drag files directly into the application's drop zone

2. **Method 2: Click to Select**
   - Click the drop zone to open a file selection dialog

3. **View Results**
   - The app displays file information (name, size, icon)
   - Select your desired hash algorithm type (MD5, SHA1, SHA256, SHA384, SHA512)
   - View the calculated hash value

### Verify Hash Values

1. Enter or paste a known hash value in the comparison area
2. The app automatically detects the hash type
3. Shows matching result (✓ Match or ✗ Mismatch)

### Copy Hash Values

Click the copy button 📋 next to any hash value to copy it to the system clipboard.

## Tech Stack

- **SwiftUI** - Modern UI framework
- **CryptoKit** - System-level cryptographic library for secure hash calculation
- **AppKit** - macOS native functionality integration
- **Foundation** - Core framework support
- **UniformTypeIdentifiers** - File type identification

## Project Structure

```
Checksum/
├── ChecksumApp.swift              # Application entry point
├── ChecksumViewModel.swift        # Core business logic
├── HashResult.swift              # Hash result model
├── HashComparisonResult.swift    # Comparison result model
└── View/
    ├── ContentView.swift         # Main interface
    ├── DropZoneView.swift        # Drop zone component
    ├── HashResultView.swift      # Result display component
    ├── HashProgressView.swift    # Progress display component
    ├── HashRow.swift            # Hash value row component
    └── HashCompareView.swift    # Comparison feature component
```

## Development

### Environment Setup

1. Ensure Xcode 26+ or later is installed
2. macOS 15.7+ or later development environment

### Running Tests

```bash
# Run tests in Xcode
⌘ + U
```

### Code Style

This project follows Swift official code style guidelines.

## Contributing

Issues and Pull Requests are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Hongyu Shi** - Initial development