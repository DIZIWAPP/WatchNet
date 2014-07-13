//
//  WNViewController.h
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import <FacebookSDK/FacebookSDK.h>
#import "THPinViewController.h"



@interface WNViewController : UIViewController<UIScrollViewDelegate, UITabBarControllerDelegate, THPinViewControllerDelegate, CLLocationManagerDelegate> //, <THPinViewControllerDelegate>
{
    CLLocationManager* _locationManager;
}
@property (retain, nonatomic)CLLocationManager *locationManager;

- (IBAction)actionMenu:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *btnMain;

- (void)timerTicked:(NSTimer*)timer;


@end
