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

// Got location and now update
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self panickManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
	
}

- (void)panickManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocation *currentLocation = newLocation;
    
	NSLog(@"%@", currentLocation);
}


- (void) addAnnotation:(CLLocation *)location
{
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = @"Help Needed.";
    point.subtitle = @"Assault type!";
    
    [self.mapView addAnnotation:point];
}

@synthesize mapView;

@end
