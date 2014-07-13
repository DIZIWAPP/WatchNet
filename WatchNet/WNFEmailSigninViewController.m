//
//  WNFEmailSigninViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 6/5/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNFEmailSigninViewController.h"
#import <Parse/Parse.h>
@interface WNFEmailSigninViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@end

@implementation WNFEmailSigninViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSignInClick:(id)sender {

    [self.delegate authenticateComplete:true];
    return;
    
    if([_userEmail.text length] == 0 ||
       [_userPassword.text length] == 0)
    {
        return;
    }
    
    
    [PFUser logInWithUsernameInBackground:_userEmail.text password:_userPassword.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"Login successful");
                                            //[self dismissViewControllerAnimated:true completion:nil];
                                            [self.delegate authenticateComplete:true];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog([NSString stringWithFormat:(@"error %@", error.description) ]);
                                        }
                                    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
