//
//  WNFBLoginViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNFBLoginViewController.h"
#import "UzysSlideMenu.h"
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

@interface WNFBLoginViewController ()
@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;
- (IBAction)onDone:(id)sender;

@end

@implementation WNFBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    // Do any additional setup after loading the view.
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view.frame = frame;
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.imageView.bounds.size.height);
    self.scrollView.delegate =self;
    
    
    ah__block typeof(self) blockSelf = self;
    UzysSMMenuItem *item0 = [[UzysSMMenuItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"a0.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        
        [UIView animateWithDuration:0.2 animations:^{
    //        blockSelf.btnMain.frame = CGRectMake(100, 200, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        [blockSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UzysSMMenuItem *item1 = [[UzysSMMenuItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
      //      blockSelf.btnMain.frame = CGRectMake(10, 150, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        
        
    }];
    UzysSMMenuItem *item2 = [[UzysSMMenuItem alloc] initWithTitle:@"Sign In" image:[UIImage imageNamed:@"a2.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
        //    blockSelf.btnMain.frame = CGRectMake(10, 250, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
        
    }];
    
    UzysSMMenuItem *item3 = [[UzysSMMenuItem alloc] initWithTitle:@"WatchNet Live" image:[UIImage imageNamed:@"a2.png"] action:^(UzysSMMenuItem *item) {
        NSLog(@"Item: %@ menuState : %d", item , blockSelf.uzysSMenu.menuState);
        [UIView animateWithDuration:0.2 animations:^{
//            blockSelf.btnMain.frame = CGRectMake(10, 250, blockSelf.btnMain.bounds.size.width, blockSelf.btnMain.bounds.size.height);
        }];
    }];
    item0.tag = 0;
    item1.tag = 1;
    item2.tag = 2;
    item3.tag = 3;
    
    NSInteger statusbarHeight = 0;
    if(IS_IOS7)
        statusbarHeight = 20;
    
    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:@[item0,item1,item2, item3]];
    self.uzysSMenu.frame = CGRectMake(self.uzysSMenu.frame.origin.x, self.uzysSMenu.frame.origin.y+ statusbarHeight, self.uzysSMenu.frame.size.width, self.uzysSMenu.frame.size.height);
    
    [self.view addSubview:self.uzysSMenu];
    self.navigationController.navigationBarHidden = YES;
     */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)onDone:(id)sender {
    [self  dismissViewControllerAnimated:YES completion:nil];

}
@end
