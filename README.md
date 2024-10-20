# PermissionSetting
To request permissions in Swift for Camera, Photo Library, Contacts, Location, and Calendar, you need to use the respective frameworks, such as AVFoundation for camera, Photo for Photo Library, Contacts for contacts, CoreLocation for location, EventKit for calendar.

Include the corresponding entries in your app’s Info.plist for user-facing permissions:

<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos.</string>
<key>NSContactsUsageDescription</key>
<string>We need access to your contacts to sync them with the app.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need access to your location to provide location-based services.</string>
<key>NSCalendarsUsageDescription</key>
<string>We need access to your calendar to sync your events.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to upload and view photos.</string>
