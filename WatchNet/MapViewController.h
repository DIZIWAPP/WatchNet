//
//  ParseStarterProjectViewController.h
//  WatchNet
//
//  Created by Jasmeet Singh on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController <CLLocationManagerDelegate>{
	
	CLLocationManager *locationManager;
	
    MKMapView *mapView;
    
//    CLLocation *currentLocation;
//    CLLocation* reportedLocation;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocation* reportedLocation;
@property (nonatomic, retain) CLLocation* currentLocation;

@end
