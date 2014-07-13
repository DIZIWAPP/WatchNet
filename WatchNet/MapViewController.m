#import "MapViewController.h"
#import <Parse/Parse.h>

@interface MapViewController () {
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    

}
@end

@implementation MapViewController: UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	mapView.showsUserLocation = YES;
	// Do any additional setup after loading the view, typically from a nib.
    
    [locationManager startMonitoringSignificantLocationChanges];
    
    
   // [self updateToLocation:_reportedLocation ];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [locationManager stopMonitoringSignificantLocationChanges];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [locationManager startMonitoringSignificantLocationChanges];
    
}

- (void) recievePush:(CLLocation *)location
{
    // set loc. In update Loc call annotation(loc)
    [locationManager startMonitoringSignificantLocationChanges];
}

// Failed to get current location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	
    UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // Call alert
	[errorAlert show];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = [locations lastObject];
    [self updateToLocation:_reportedLocation ];

}
/*
// Got location and now update
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self panickManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
	
}
 */

- (void)panickManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocation *curLocation = newLocation;
    
    [self addAnnotation:curLocation];
	NSLog(@"%@", curLocation);
}

- (void) updateToLocation:(CLLocation *)newLocation
{
	
//    CLLocation* loc = [[CLLocation alloc]initWithLatitude:37.333333 longitude:-121.9];
    CLLocation* loc = _currentLocation;

//    NSArray* locs
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 800, 800);
    MKCoordinateRegion region;
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    topLeftCoord.latitude = fmax(topLeftCoord.latitude, loc.coordinate.latitude);
    topLeftCoord.longitude = fmin(topLeftCoord.longitude, loc.coordinate.longitude);
    bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, loc.coordinate.latitude);
    bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, loc.coordinate.longitude);

    
    topLeftCoord.latitude = fmax(topLeftCoord.latitude, newLocation.coordinate.latitude);
    topLeftCoord.longitude = fmin(topLeftCoord.longitude, newLocation.coordinate.longitude);
    bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, newLocation.coordinate.latitude);
    bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, newLocation.coordinate.longitude);

    const double extraSpace = 2.1;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) / 2.0;
    region.center.longitude = topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude) / 2.0;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace;
    region.span.longitudeDelta = fabs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace;

    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocation *curLocation = newLocation;
    
    [self addAnnotation:curLocation];
	NSLog(@"%@", curLocation);
}


- (void) addAnnotation:(CLLocation *)location
{
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = @"Help Needed.";
    point.subtitle = @"Assault type!";
    [self.mapView addAnnotation:point];

    /*
    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
    point2.coordinate = location2.coordinate;
    point2.title = @"You are here.";
    [self.mapView addAnnotation:point2];
     */
}

@synthesize mapView;

@end
