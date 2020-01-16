//
//  AppCoordinator.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 19/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

enum TabName: String {
    case List
    case Map
}

protocol Coordinator {
    var tabBarController: UITabBarController { get set } //this is our root controlller
    func start()
}

class AppCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        //create all tabs to show
        //1
        //create data store for viewModel // Dependency Injection
        let dataStore: PoiDataStore = PoiAPIDataStore()
        let listViewModel: ListViewModel = ListViewModel(dataStore: dataStore)
        let listView = ListViewController.create(with: listViewModel)
        listView.tabBarItem = UITabBarItem(title: TabName.List.rawValue, image: nil, tag: 0)
        
        //2
        //create data store for viewModel
        let poiDataStore: PoiDataStoreProtocol = PoiAPIDataStore()
        let mapViewModel: MapViewModel = MapViewModel(poiDataStore)
        let mapView = MapViewController.create(with: mapViewModel)
        mapView.tabBarItem = UITabBarItem(title: TabName.Map.rawValue, image: nil, tag: 0)
        tabBarController.viewControllers = [listView,mapView]
        
    }
}
