//
//  WNViewController.h
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface WNViewController : UIViewController<UIScrollViewDelegate>

- (IBAction)actionMenu:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *btnMain;

@end
