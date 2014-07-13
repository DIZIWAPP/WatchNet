//
//  WNAppDelegate.m
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNAppDelegate.h"
#import "MapViewController.h"
@implementation WNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"KSxCqPQWT10pBsOqaFlEgK4Ps9ubZ8khqL3cd3RC"
                  clientKey:@"6U9CWaA08Qh5CqELxOC7gR8mQJ23VWN08WqqrFJD"];
    
    application.applicationSupportsShakeToEdit = YES;
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    // Extract the notification data
    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if(notificationPayload != nil)
    {
        [self showDistressLocation:notificationPayload];
        
    }
    
    [_window makeKeyAndVisible];

    
    return YES;
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //[PFPush handlePush:userInfo];
    
    [self showDistressLocation:userInfo];
    
    
}

//- (void) showDistressLocation:(CLLocation*)distressLocation
-(void) showDistressLocation:(NSDictionary*) notificationInfo
{
    
    NSString* strLatitude = [notificationInfo objectForKey:@"latitude"];
    NSString* strLongitude = [notificationInfo objectForKey:@"longitude"];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"MyAlertView"
                                                        message: [NSString stringWithFormat:@"lat= %@, log = %@", strLatitude, strLongitude]
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];

    CLLocation* distressLocation = [[CLLocation alloc]initWithLatitude:[strLatitude doubleValue] longitude:[strLongitude doubleValue]];
    
    
    UITabBarController* tabbarVC = (UITabBarController*)self.window.rootViewController;
    
    MapViewController* mapVC    = tabbarVC.viewControllers[1];
    mapVC.reportedLocation      = distressLocation;
    
    tabbarVC.selectedIndex = 1;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}


- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"MyAlertView"
                                                        message:@"Local notification was received"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [PFUser logOut];
}



- (BOOL)application:(UIApplication *)application
                                openURL:(NSURL *)url
                                sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    
    NSLog(@"Launched with URL: %@", url.absoluteString);

    
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

@end
