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
    [locationManager startMonitoringSignificantLocationChanges];
	// Do any additional setup after loading the view, typically from a nib.
	
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
    [self sendPush:newLocation];
	
}

- (void) sendPush:(CLLocation *)location
{
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Someone Needs your help NOW!", @"alert",
                          @"Vaughn", @"name",
                          @"Man bites dog", @"newsItem",
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Panick"];
    [push setData:data];
    [push sendPushInBackground];
}

@synthesize mapView;

@end
