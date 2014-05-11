//
//  WNViewController.m
//  UzysSlideMenu
//
//  Created by Jaehoon Jung on 13. 2. 21..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "WNViewController.h"
#import "UzysSlideMenu.h"
#import <Parse/Parse.h>
#import "WNFBLoginViewController.h"
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7


@interface WNViewController ()
@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;
@property (weak, nonatomic) IBOutlet UIButton *panicButton;
- (IBAction)onPanicPressed:(id)sender;

@property(nonatomic,assign) UzysSMState _currentMenuState;
@property(nonatomic,assign) NSInteger   currentAppState;

@end

@implementation WNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _currentAppState = 0;
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view.frame = frame;
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.imageView.bounds.size.height);
    self.scrollView.delegate =self;
    
    
    ah__block typeof(self) blockSelf = self;
    UzysSMMenuItem *item0 = [[UzysSMMenuItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"home_icon.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        
        [UIView animateWithDuration:0.2 animations:^{
//            blockSelf.btnMain.frame = CGRectMake(100, 200, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        _currentAppState = 0;

    }];
    
    UzysSMMenuItem *item1 = [[UzysSMMenuItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settings_icon.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
  //          blockSelf.btnMain.frame = CGRectMake(10, 150, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
            if(   _currentAppState != 1)
            {            _currentAppState = 1;
                [blockSelf performSegueWithIdentifier:@"showSettings" sender:self];
            }else
            {
                [blockSelf.uzysSMenu toggleMenu];
                
            }

        }];
        
        
    }];
    UzysSMMenuItem *item2 = [[UzysSMMenuItem alloc] initWithTitle:@"Sign In" image:[UIImage imageNamed:@"profile_icon_woman.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
 //           blockSelf.btnMain.frame = CGRectMake(10, 250, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        
        {
            if(_currentAppState != 2)
            {
                _currentAppState = 2;
                [blockSelf performSegueWithIdentifier:@"showFBLogin" sender:self];
            }else
            {
                [blockSelf.uzysSMenu toggleMenu];
                
            }
            
        }
    }];
    UzysSMMenuItem *item3 = [[UzysSMMenuItem alloc] initWithTitle:@"My Trusted Circle" image:[UIImage imageNamed:@"network_icon.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
            //         blockSelf.btnMain.frame = CGRectMake(10, 250, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        
        if(_currentAppState != 3)
        {
            _currentAppState = 3;
            [blockSelf performSegueWithIdentifier:@"showMyCircle" sender:self];
        }else
        {
            [blockSelf.uzysSMenu toggleMenu];
            
        }
        
    }];


    UzysSMMenuItem *item4 = [[UzysSMMenuItem alloc] initWithTitle:@"WatchNet Live" image:[UIImage imageNamed:@"Watchnet_Live_icon.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
   //         blockSelf.btnMain.frame = CGRectMake(10, 250, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        _currentAppState = 4;

    }];
    item0.tag = 0;
    item1.tag = 1;
    item2.tag = 2;
    item3.tag = 3;
    item3.tag = 4;
    
    NSInteger statusbarHeight = 0;
    if(IS_IOS7)
        statusbarHeight = 20;
    
    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:@[item0,item1,item2, item3,item4]];
    self.uzysSMenu.frame = CGRectMake(self.uzysSMenu.frame.origin.x, self.uzysSMenu.frame.origin.y+ statusbarHeight, self.uzysSMenu.frame.size.width, self.uzysSMenu.frame.size.height);
    
    [self.view addSubview:self.uzysSMenu];
    self.navigationController.navigationBarHidden = YES;
    
    /////////////
    
   // PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
   // testObject[@"foo"] = @"bar";
   // [testObject saveInBackground];
    
    ///////////////
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.uzysSMenu.state = STATE_ICON_MENU;
//    [self.uzysSMenu setupLayout];
//    [self.uz showIconMenu:NO];

   // [self.uzysSMenu toggleMenu];
    [self.uzysSMenu openIconMenu];
    //[self.uzysSMenu toggleMenu];
    [self.uzysSMenu openMenu:STATE_ICON_MENU animated:YES];
//    self.uzysSMenu

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [_imageView release];
    [_btnMain release];
    [super ah_dealloc];
}

- (IBAction)actionMenu:(id)sender {
    NSLog(@"Btn touch");
    [self.uzysSMenu toggleMenu];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.uzysSMenu openIconMenu];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onPanicPressed:(id)sender {

    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Panic Party" message:@"Party Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}
@end
