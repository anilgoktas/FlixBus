## Feedback

- First of all thank you for creating this assignment.
- We could provide RGB values of the colors on the navigation bar and table header view background for convenience.

## Dependencies

- `Alamofire` and `SwiftyJSON` used for business layer.
    - `SwiftyJSON` preferred instead of `Codable` as a personal choice in order to implement models quickly.
- `R.swift` is a code generator for all assets, images, nibs and colors which comes in handy where deleting any of these resources results in a compile error.
- `SwiftyMocky` is also a code generator using Sourcery under the hood. It creates mock classes conforming `AutoMockable` marked protocols.
- `iOSSnapshotTestCase` is a snapshot testing framework maintained by Uber and previously Facebook. It will help us for checking table view cells and view controllers. 

## Project Notes

### Missing Features & Frameworks

- Accessibility
- Dark Mode
- iPadOS UI improvements
- Linting (e.g. SwiftLint)
- Dynamic stations listing

### Project Structure

- There are three testing targets where shared codes & resources placed in the `FlixBusTestsCore` folder.

### Core Folder

- `Config.swift` file has all endpoint and third party SDK related hard-coded strings.
- `Logging` folder includes logger structure for any third party integrations.
- `Network` layer doesn't have any unit tests on purpose in order not to bloat unit testing project. 
    - It would be nice if we can isolate as a separate framework. 
- `Extensions` folder has all the extensions, ideally we could create subfolders for each framework (UIKit, Foundation etc.)

### Code Structure

- `Environment` used as a dependency container and is being mocked while testing (`FlixBusTestsCore/Mocker.swift`). Original idea belongs to `pointfree.co`

## TODO

- Stations/station screen segmented control with arrival / departure mode?

- Sort by timestamp
- Check possible dates, format and use that string as a key
- Use strings as headers and its elements as table cells
