//
//  ViewController.swift
//  PermissionSetting
//
//  Created by Mohammad Masud Rana on 15/10/24.
//

import UIKit
import AVFoundation
import Contacts
import CoreLocation
import EventKit
import Photos

struct PermissionList {
    var icon, title: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let locationManager = CLLocationManager()
    let eventStore = EKEventStore()
    let contactStore = CNContactStore()
    
    //Permission List
    var titleArray = [PermissionList(icon: "location", title: "Location"), PermissionList(icon: "calendar", title: "Calendar"), PermissionList(icon: "camera", title: "Camera"), PermissionList(icon: "photo", title: "Photo Library"), PermissionList(icon: "phone", title: "Contact")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.cellIdentifire)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifire, for: indexPath) as! TableViewCell
        
        let item = titleArray[indexPath.row]
        cell.imageIcon.image = UIImage(systemName: item.icon ?? "")
        cell.titleLabel.text = item.title
        cell.switchValue.tag = indexPath.row
        
        cell.switchValue.addTarget(self, action: #selector(permissionUpdate), for: .valueChanged)
                
        switch item.icon {
        case "location":
            var locationStatus : CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                locationStatus =  locationManager.authorizationStatus
            } else {
                // Fallback on earlier versions
                locationStatus = CLLocationManager.authorizationStatus()
            }
            cell.switchValue.isOn = locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways
            break
            
        case "calendar":
            cell.switchValue.isOn = EKEventStore.authorizationStatus(for: .event) == .authorized
            break
            
        case "camera":
            cell.switchValue.isOn = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
            break
            
        case "photo":
            cell.switchValue.isOn = PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited
            break
            
        case "phone":
            if #available(iOS 18.0, *) {
                cell.switchValue.isOn = CNContactStore.authorizationStatus(for: .contacts) == .authorized || CNContactStore.authorizationStatus(for: .contacts) == .limited
            } else {
                cell.switchValue.isOn = CNContactStore.authorizationStatus(for: .contacts) == .authorized
            }
            
            break
            
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
  

    @objc func permissionUpdate(_ sender: UISwitch) {
        //print("sender.tag   \(sender.tag)")
        //print("sender.isOn   \(sender.isOn)")
        switch sender.tag {
        case 0:
            if !sender.isOn {
                self.openAppSettings()
            } else {
                if PermissionManager.requestLocationPermission {
                    
                } else {
                    self.openAppSettings()
                }
            }
            break
        case 1:
            if !sender.isOn {
                self.openAppSettings()
            } else {
                PermissionManager.requestCalendarPermission{ isEnable in
                    if isEnable {
                        //use if any change needed.
                    } else {
                        self.openAppSettings()
                    }
                }
            }
            break
        case 2:
            if !sender.isOn {
                self.openAppSettings()
            } else {
                PermissionManager.requestCameraPermission{ isEnable in
                    if isEnable {
                        //use if any change needed.
                    } else {
                        self.openAppSettings()
                    }
                }
            }
            break
        case 3:
            if !sender.isOn {
                self.openAppSettings()
            } else {
                PermissionManager.requestPhotoLibraryPermission { isEnable in
                    if isEnable {
                        //use if any change needed.
                    } else {
                        self.openAppSettings()
                    }
                }
            }
            break
        case 4:
            if !sender.isOn {
                self.openAppSettings()
            } else {
                PermissionManager.requestContactsPermission{ isEnable in
                    if isEnable {
                        //use if any change needed.
                    } else {
                        self.openAppSettings()
                    }
                }
            }
            break
        default:
            break
        }
    }
    
    // MARK: - Open App Settings
    func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettingsURL) {
                UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
            }
        }
    }
}
