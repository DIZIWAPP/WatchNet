//
//  WNViewController.m
//  UzysSlideMenu
//
//  Created by Jaehoon Jung on 13. 2. 21..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "WNViewController.h"
#import <Parse/Parse.h>
#import "WNFBLoginViewController.h"
#import "THPinViewController.h"
#import "MapViewController.h"
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7


@interface WNViewController ()
@property (weak, nonatomic) IBOutlet UIButton *panicButton;
- (IBAction)onPanicPressed:(id)sender;

@property(nonatomic,assign) NSInteger   currentAppState;

@property(nonatomic, copy) NSString* correctPin;
@property(nonatomic, assign) int remainingPinEntries;
@property(nonatomic, assign) CLLocationAccuracy desiredAccuracy;
@property(nonatomic, strong)CLLocation* currentLocation;
@property(nonatomic, strong)NSTimer* cancelTimer;

@end

@implementation WNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([PFUser currentUser])
    {
//        [PFUser logOut];
    }

	// Do any additional setup after loading the view, typically from a nib.
    _correctPin             = @"1234";
    _remainingPinEntries    = 3;
    _currentAppState        = 0;
    _desiredAccuracy        = kCLLocationAccuracyNearestTenMeters;
    self.tabBarController.delegate              = self;
    self.tabBarController.tabBar.translucent    = true;
    
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate               = self;
    
    [_locationManager startMonitoringSignificantLocationChanges];
    
    if (![PFUser currentUser]) { // No user logged in
        
        [self performLogin];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



-(void) showCancelUI
{
    
    THPinViewController *pinViewController = [[THPinViewController alloc] initWithDelegate:self];
    
    pinViewController.backgroundColor   = self.view.backgroundColor;
    pinViewController.promptTitle       = @"Enter PIN to stop distress call ...";
    pinViewController.promptColor       = [UIColor blueColor];
    pinViewController.view.tintColor    = [UIColor blueColor];
    pinViewController.hideLetters       = YES;
    _cancelTimer = [self createTimer];
    [self presentViewController:pinViewController animated:YES completion:nil];
    
}

- (IBAction)onPanicPressed:(id)sender {

    [self showCancelUI];
}
- (IBAction)onClickLogout:(id)sender {
    
    [PFUser logOut];
}

-(BOOL)canBecomeFirstResponder {
    
    if([PFUser currentUser])
        return YES;
    else
        return NO;
}

-(void) viewWillAppear:(BOOL)animated
{
 //   [PFUser logOut];
    
    if (![PFUser currentUser]) { // No user logged in
        
        
    }
}

- (void) performLogin
{
    UIStoryboard *storyboard = self.storyboard;
    WNFBLoginViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:svc];
    
    [self presentViewController:nav animated:NO completion:nil];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    if (![PFUser currentUser]) { // No user logged in
        
        [self performLogin];
    }else
        [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


- (NSTimer*)createTimer {
    
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:NO];
}

- (void)timerTicked:(NSTimer*)timer {
    
    [_locationManager startMonitoringSignificantLocationChanges];

    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView* aView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Timer ticked" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [aView show];

    [self sendPush:_currentLocation];

    
    // increment timer 2 … bump time and redraw in UI

}

// mandatory delegate methods

- (NSUInteger)pinLengthForPinViewController:(THPinViewController *)pinViewController
{
    return 4;
}

- (BOOL)pinViewController:(THPinViewController *)pinViewController isPinValid:(NSString *)pin
{
    if ([pin isEqualToString:self.correctPin]) {
        return YES;
    } else {
        _remainingPinEntries--;
        return NO;
    }
}

- (BOOL)userCanRetryInPinViewController:(THPinViewController *)pinViewController
{
    return (_remainingPinEntries > 0);
}

- (void)pinViewControllerWillDismissAfterPinEntryWasCancelled:(THPinViewController *)pinViewController
{
    
}

// optional delegate methods

- (void)incorrectPinEnteredInPinViewController:(THPinViewController *)pinViewController {
    
    /* INCORRECT PIN */
    UIAlertView* aView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Entered wrong PIN. Try again..." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
    [aView show];
    
}

- (void)pinViewControllerWillDismissAfterPinEntryWasSuccessful:(THPinViewController *)pinViewController {
    

    [self.cancelTimer invalidate];
    self.cancelTimer = nil;
    
    UIAlertView* aView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Successfully cancelled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [aView show];
    
    

    /* LOCAL NOTIFICATION
     
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
    localNotification.alertBody = @"Your alert message";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
     
     */

    
}

- (void)pinViewControllerDidDismissAfterPinEntryWasSuccessful:(THPinViewController *)pinViewController {

}

- (void)pinViewControllerWillDismissAfterPinEntryWasUnsuccessful:(THPinViewController *)pinViewController {
    
}

- (void)pinViewControllerDidDismissAfterPinEntryWasUnsuccessful:(THPinViewController *)pinViewController {


}


- (void)pinViewControllerDidDismissAfterPinEntryWasCancelled:(THPinViewController *)pinViewController {

}

////======

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
    NSLog(@"did updateLocations Location : %@", [locations lastObject]);

}

// Got location and now update
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"New Location : %@", newLocation);
    [self sendPush:newLocation];
	
}

- (void) sendPush:(CLLocation *)location
{

    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Someone Needs your help NOW!", @"alert",
                          @"Mahesh", @"name",
                          [NSString stringWithFormat:@"%f",location.coordinate.latitude ], @"latitude",
                          [NSString stringWithFormat:@"%f",location.coordinate.longitude ], @"longitude",
                          nil];

    
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];

    PFPush *push = [[PFPush alloc] init];
    //[push setChannel:@"Everyone"];
    [push setData:data];
    [push setQuery:pushQuery];
    
    //TODO:Push this logic to Parse cloud Code
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            NSLog(@"Push message succeeded.");
            
        }else
        {
            NSLog(@"Push message failed.");
            
        }
    }];

    
     /*
    // Send push notification to query
    [PFPush sendPushMessageToQueryInBackground:pushQuery
                                   withMessage:[   NSString stringWithFormat:@"Distress call... around %f %f", _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude ]];
      */
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
     
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Motion detected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];

    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    tabBarController.tabBar.translucent = (viewController != self);
    return YES;
}


@end
