//
//  MapViewController.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapViewController: UIViewController {
    var viewModel: MapViewModel
    private let disposeBag = DisposeBag()
    lazy var mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    public static func create(with viewModel: MapViewModel, embededInNavigationController: Bool = true) -> UIViewController {
        let mapViewController = MapViewController(with: viewModel)
        mapViewController.title = "Map View"
        guard embededInNavigationController else {
            return mapViewController
        }
        return UINavigationController(rootViewController: mapViewController)
    }
    
    init(with viewModel:MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.white
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitialMapState()
        self.bindViewModel()
    }
    
    private func setupInitialMapState() {
        let coordinateRegion = viewModel.getInitialStateCenterRegion()
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.regionThatFits(coordinateRegion)
    }
    
    private func addAnnotations(annotations: [MKAnnotation]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
    /// Binding our viewMoel to listen events
    private func bindViewModel() {
        viewModel.onShowAnnotations.subscribe { [weak self] annotations in
            //show annotations
            self?.addAnnotations(annotations: annotations.element ?? [])
        }.disposed(by: disposeBag)
        
        viewModel.onShowError.subscribe { [weak self] error in
            //show error
            guard let this = self else { return }
            guard let error = error.element else { return }
            AlertHandler.showError(this, error: error)
        }.disposed(by: disposeBag)
    }
    
}
// MARK: - MapView Delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            return annotationView
        }
        annotationView.annotation = annotation
        return annotationView
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        //First we need to calculate the corners of the map so we get the points
        let northEeastCoord = viewModel.getNorthEastCoordinate(with: mapView)
        let southWestCoord = viewModel.getSouthWestCoordinate(with: mapView)
        viewModel.load(northEeastCoord, southWestCoordinate: southWestCoord)
    }
}
