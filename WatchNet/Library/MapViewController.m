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
	// Do any additional setup after loading the view, typically from a nib.
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.delegate = self;
	mapView.showsUserLocation = YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}


- (IBAction)getlocation:(id)sender {
	
    
	[locationManager startUpdatingLocation];
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
	
    CLLocation *currentLocation = newLocation;
    
	NSLog(@"%@", currentLocation);
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = newLocation.coordinate;
    point.title = @"Help Needed.";
    point.subtitle = @"Assault type!";
    
    [self.mapView addAnnotation:point];
	
}


@synthesize mapView;

@end
