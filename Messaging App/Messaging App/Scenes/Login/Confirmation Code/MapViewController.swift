//
//  MapViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 17.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    // MARK: - Dependencies
    
    var confirmationCodeView: ConfirmationCodeViewControllerProtocol?
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: CustomTextField!
    @IBOutlet weak var locationTableView: UITableView!
    
    // MARK: - Constraints
    
    @IBOutlet weak var locationTableHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    var addressDescription = ""
    var currentLoactionDescription = ""
    var matchingItems: [MKMapItem] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableView.reloadData()
    }
    
    // MARK: - Configure
    
    override func configureView() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(press:)))
        mapView.addGestureRecognizer(tap)
        
        dismissKeyboard(press: nil)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
        longPressRecogniser.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPressRecogniser)
        
        searchText.leftViewButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        findCurrentLocationDescription()
    }
    
    override func dismissKeyboard(press: UITapGestureRecognizer? = nil) {
        if let press = press {
            let location = press.location(in: view)
            if locationTableView.frame.contains(location) {
                return
            }
        }
        
        super.dismissKeyboard(press: nil)
    }
    
    // MARK: - Actions
    
    @objc func complateLocationSelection() {
        
        if latitude.isEmpty || longitude.isEmpty {
            return
        }
        
        if addressDescription.isEmpty {
            if currentLoactionDescription.isEmpty {
                let alert = UIAlertController(title: "please_complate".localized, message: "message_text.please_enter_address_description".localized, preferredStyle: .alert)
                
                alert.addTextField { (addressText) in
                    addressText.placeholder = "address_description".localized
                }
                
                alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: { (action) in
                    if let addressText = alert.textFields?.first?.text {
                        if addressText.isEmpty { return }
                        
                        self.addressDescription = addressText
                        alert.dismiss(animated: true, completion: nil)
                    }
                }))
                
                alert.show(self, sender: nil)
            } else {
                addressDescription = currentLoactionDescription
            }
        }
        
        dismiss(animated: true) {
            let address = AddressModel(description: self.addressDescription, latitude: self.latitude, longitude: self.longitude)
            self.confirmationCodeView?.complateAddressSelection(address: address)
        }
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchTextChanged(_ sender: CustomTextField) {
        guard let mapView = mapView,
            let searchText = sender.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else { return }
            
            self.matchingItems = response.mapItems
            self.locationTableHeightConstraint.constant = CGFloat(49 * self.matchingItems.count)
            self.locationTableView.reloadData()
        }
    }
}

// MARK: - Extensions

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        
        if currentLoactionDescription == "" {
            findCurrentLocationDescription()
        }
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        setAnnotation(selectedItem)
        locationTableHeightConstraint.constant = 0
        dismissKeyboard(press: nil)
    }
}

extension MapViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        locationTableHeightConstraint.constant = CGFloat(49 * matchingItems.count)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        locationTableHeightConstraint.constant = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{

        if annotation is MKUserLocation { return nil }

        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        let selectButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        if #available(iOS 13.0, *) {
            selectButton.setImage(UIImage.checkmark, for: .normal)
            selectButton.scalesLargeContentImage = true
        } else {
            selectButton.setImage(#imageLiteral(resourceName: "checkMark.png"), for: .normal)
        }
        selectButton.setTitle(" " + "register.select_this_location".localized, for: .normal)
        
        selectButton.setTitleColor(.black, for: .normal)
        selectButton.addTarget(self, action: #selector(complateLocationSelection), for: .touchUpInside)
        
        let userLocationView = views.first { $0.annotation is MKUserLocation }
        
        if let annotation = userLocationView?.annotation as? MKUserLocation {
            annotation.title = ""
            userLocationView?.annotation = annotation
            userLocationView?.detailCalloutAccessoryView = selectButton
        }
        
        let annotationView = views.first { $0.annotation is MKPointAnnotation }
        
        if let annotation = annotationView?.annotation as? MKPointAnnotation {
            annotation.title = ""
            annotation.subtitle = ""
            annotationView?.annotation = annotation
            annotationView?.detailCalloutAccessoryView = selectButton
            (annotationView as? MKMarkerAnnotationView)?.titleVisibility = .hidden
            (annotationView as? MKMarkerAnnotationView)?.subtitleVisibility = .hidden
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            mapView.removeAnnotations(mapView.annotations)
            
            addressDescription = ""
            
            if let location = locationManager.location {
                latitude = "\(location.coordinate.latitude)"
                longitude = "\(location.coordinate.longitude)"
            }
        }
    }
}


extension MapViewController {
    
    func findCurrentLocationDescription() {
            
        if let location = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                if error != nil { return }
                
                if let placeMark = placemarks?.last {
                    self.currentLoactionDescription = self.parseAddress(selectedItem: placeMark)
                }
            }

            latitude = "\(location.coordinate.latitude)"
            longitude = "\(location.coordinate.longitude)"
            
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func setAnnotation(_ placemark: MKPlacemark) {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        latitude = "\(placemark.coordinate.latitude)"
        longitude = "\(placemark.coordinate.longitude)"
        addressDescription = parseAddress(selectedItem: placemark)
    }
    
    @objc func addAnnotation(press: UILongPressGestureRecognizer) {
        if press.state == .began {
            mapView.removeAnnotations(mapView.annotations)
            
            let location = press.location(in: mapView)
            let cordinates = mapView.convert(location, toCoordinateFrom: mapView)
            
            let placemark = MKPlacemark(coordinate: cordinates)
            let annotation = MKPointAnnotation()
            annotation.coordinate = placemark.coordinate
    
            let clLoction = CLLocation(latitude: cordinates.latitude, longitude: cordinates.longitude)
            
            CLGeocoder().reverseGeocodeLocation(clLoction) { (placemarks, error) in
                if error != nil { return }
                
                if let placeMark = placemarks?.last {
                    self.addressDescription = self.parseAddress(selectedItem: placeMark)
                    self.searchText.text = self.addressDescription
                }
            }
            
            mapView.addAnnotation(annotation)
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            latitude = "\(placemark.coordinate.latitude)"
            longitude = "\(placemark.coordinate.longitude)"
        }
    }
    
    func parseAddress(selectedItem: CLPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
                            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
                    (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
                            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
}
