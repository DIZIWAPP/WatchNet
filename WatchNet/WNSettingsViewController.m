//
//  WNSettingsViewController.m
//  WatchNet
//
//  Created by Mahesh Kumar on 5/10/14.
//  Copyright (c) 2014 RescueMe. All rights reserved.
//

#import "WNSettingsViewController.h"

@interface WNSettingsViewController ()
- (IBAction)onDone:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *sliderNotify;
@property (weak, nonatomic) IBOutlet UILabel *notifyTextLabel;
@property (weak, nonatomic) IBOutlet UISlider *sliderRespond;


@property (weak, nonatomic) IBOutlet UILabel *responstextLabel;

@end

@implementation WNSettingsViewController

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
    _notifyTextLabel.text = [NSString stringWithFormat:@"Notify community withn %.0f Kms",[_sliderNotify value]];
    _responstextLabel.text = [NSString stringWithFormat:@"Will respond within %.0f Kms", [_sliderRespond value]];

    // Do any additional setup after loading the view.
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) sliderValueChanged:(id)sender
{
    UISlider* slide = sender;
    if(slide.tag == 1000)
    {
     _notifyTextLabel.text = [NSString stringWithFormat:@"Notify community withn %.0f Kms",[slide value]];
    }
    else if(slide.tag == 1001)
    {
        _responstextLabel.text = [NSString stringWithFormat:@"Will respond within %.0f Kms", [slide value]];
    }
}
@end
