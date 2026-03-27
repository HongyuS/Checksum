# HashHawk

A clean and elegant macOS file checksum calculator.

[中文](README.md) | English

## Features

- 🔍 **Five hashes in one pass**: MD5, SHA1, SHA256, SHA384, and SHA512
- 🎯 **Drag & drop plus file picker**: drop a file into the sidebar or open/replace it from the top-right toolbar button
- 📊 **Real-time progress**: shows progress while hashing large files
- 📁 **File metadata preview**: displays the file icon, name, size, and full path
- 🧪 **Hash comparison**: paste any supported digest and match it against the selected file automatically
- 📋 **One-click copy**: copy the currently selected hash value to the clipboard
- 🌍 **Bilingual UI**: English and Simplified Chinese localizations included
- 🛡️ **Sandbox-friendly file access**: read-only access for user-selected files

## System Requirements

### Runtime

- macOS 26+

### Development

- macOS 26+
- Swift 6+
- Xcode 26+

## Installation and Running

### Build from Source

1. Clone the repository
2. Open `HashHawk.xcodeproj` in Xcode
3. Select the `HashHawk` scheme and build/run the app

## Usage

### Calculate File Hashes

1. **Drag and drop a file**
   - Drop a file into the left sidebar drop zone

2. **Or open a file manually**
   - Click the **Open File** button in the top-right corner

3. **Review the result**
   - Hashing starts automatically after a file is selected
   - The app shows the file icon, name, and size
   - Click the info button next to the filename to inspect the full path
   - Switch between MD5, SHA1, SHA256, SHA384, and SHA512 in the result card

### Compare Hash Values

1. Enter or paste a hash value into the comparison field
2. The app normalizes whitespace and letter case before matching
3. If the input matches any supported digest for the current file, the UI shows the matched state and hash type
4. Use the clear button to reset the comparison input quickly

### Copy Hash Values

Click the **Copy** button in the result area to copy the currently displayed hash to the system clipboard.

## Tech Stack

- **SwiftUI** for the native macOS interface
- **Observation** for view model state updates
- **CryptoKit** for streamed multi-hash calculation
- **AppKit** for clipboard and file icon integration
- **UniformTypeIdentifiers** for file type handling
- **Swift Testing** for unit tests

## Project Structure

```text
Checksum/
├── HashHawk/
│   ├── HashHawkApp.swift              # App entry point
│   ├── HashHawkViewModel.swift        # File selection, hashing, and comparison logic
│   ├── AppLocalization.swift          # Localization helpers
│   ├── HashHawkLayout.swift           # Layout constants
│   ├── HashResult.swift               # Hash result model
│   ├── HashComparisonResult.swift     # Comparison result model
│   ├── HashType.swift                 # Supported hash algorithms
│   ├── MainContentState.swift         # Main content state model
│   ├── Localizable.xcstrings          # English / Simplified Chinese string catalog
│   └── View/
│       ├── ContentView.swift          # Root view and file importer entry
│       ├── DropZoneView.swift         # Sidebar drop zone and open-file UI
│       ├── MainContentView.swift      # Main detail container
│       ├── MainContentStateView.swift # Idle, progress, error, and result switching
│       ├── SelectedFileInfoView.swift # Selected file metadata card
│       ├── HashResultView.swift       # Hash result card
│       ├── HashTypeSelectorView.swift # Hash algorithm selector
│       ├── HashRow.swift              # Hash display and copy action
│       └── HashCompareView.swift      # Hash comparison UI
├── HashHawk.xcodeproj/                # Xcode project
├── HashHawkTests/                     # Unit tests
└── HashHawkUITests/                   # UI tests
```

## Development Notes

### Testing

- Run tests in Xcode with `⌘ + U`
- Current unit tests cover hash comparison, comparison reset, file metadata refresh, and string catalog validation

### Localization

- UI strings are maintained in `HashHawk/Localizable.xcstrings`
- The app currently ships with English (`en`) and Simplified Chinese (`zh-Hans`)

### Code Style

This project follows Swift's official style conventions and prefers modern SwiftUI and Observation APIs.

## Contributing

Issues and Pull Requests are welcome.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push the branch
5. Open a Pull Request

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Author

Hongyu Shi
