//
//  PermissionManager.swift
//  PermissionSetting
//
//  Created by Mohammad Masud Rana on 16/10/24.
//

import AVFoundation
import Contacts
import CoreLocation
import EventKit
import Photos

class PermissionManager {
 
    // MARK: - Location Permission
    class var requestLocationPermission: Bool {
        let locationManager = CLLocationManager()
        var locationStatus : CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            locationStatus =  locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            locationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch locationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return true
            //self.openAppSettings()
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access already authorized.")
            return true
        case .denied, .restricted:
            print("Location access denied or restricted.")
            return false
            //self.openAppSettings()
        @unknown default:
            print("Unknown location permission status.")
            return false
            //self.openAppSettings()
        }
    }
    
    // MARK: - Calendar Permission
   static func requestCalendarPermission(completion: @escaping (Bool) -> Void) {
        let eventStore = EKEventStore()
        let calendarStatus = EKEventStore.authorizationStatus(for: .event)
        switch calendarStatus {
        case .notDetermined:
            eventStore.requestAccess(to: .event) { granted, error in
                if granted {
                    print("Calendar access granted.")
                    completion(true)
                } else {
                    print("Calendar access denied.")
                    completion(false)
                }
            }
        case .authorized:
            print("Calendar access already authorized.")
            completion(true)
        case .denied, .restricted:
            print("Calendar access denied or restricted.")
            completion(false)
        @unknown default:
            print("Unknown calendar permission status.")
            completion(false)
        }
    }
    
    // MARK: - Camera Permission
    static func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera access granted.")
                    completion(true)
                } else {
                    print("Camera access denied.")
                    completion(false)
                }
            }
        case .authorized:
            print("Camera access already authorized.")
            completion(true)
        case .denied, .restricted:
            print("Camera access denied or restricted.")
            completion(false)
        @unknown default:
            print("Unknown camera permission status.")
            completion(false)
        }
    }
    
    // MARK: - Photo Library Permission
    static func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        switch photoStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("Photo Library access granted.")
                    completion(true)
                case .limited:
                    print("Photo Library limited access granted.")
                    completion(true)
                case .denied, .restricted:
                    print("Photo Library access denied or restricted.")
                    completion(false)
                default:
                    print("Unknown Photo Library permission status.")
                    completion(false)
                }
            }
        case .authorized:
            print("Photo Library access already authorized.")
            completion(true)
        case .limited:
            print("Photo Library limited access already authorized.")
            //Limided photo
            //PHPhotoLibrary.shared().register(self)
            //PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
            
            completion(true)
        case .denied, .restricted:
            print("Photo Library access denied or restricted.")
            completion(false)
        @unknown default:
            print("Unknown Photo Library permission status.")
            completion(false)
        }
    }
    
    // MARK: - Contacts Permission
    static func requestContactsPermission(completion: @escaping (Bool) -> Void)  {
        let contactStore = CNContactStore()
        let contactsStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch contactsStatus {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    print("Contacts access granted.")
                    completion(true)
                } else {
                    print("Contacts access denied.")
                    completion(false)
                }
            }
        case .authorized:
            print("Contacts access already authorized.")
            completion(true)
        case .denied, .restricted:
            print("Contacts access denied or restricted.")
            completion(false)
        case .limited:
            completion(true)
        @unknown default:
            print("Unknown contacts permission status.")
            completion(false)
        }
    }
    
}
