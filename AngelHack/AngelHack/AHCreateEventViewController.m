//
//  AHCreateEventViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHCreateEventViewController.h"
#import "AHEvent.h"

@interface AHCreateEventViewController ()

@property (assign, nonatomic) AHEventType selectedEventType;

// Tab backgrounds
@property (weak, nonatomic) IBOutlet UIView *tabBackgrounds;
@property (weak, nonatomic) IBOutlet UIImageView *happyHourTabBackground;
@property (weak, nonatomic) IBOutlet UIImageView *sportsTabBackground;
@property (weak, nonatomic) IBOutlet UIImageView *coffeeTabBackground;
@property (weak, nonatomic) IBOutlet UIImageView *mealTabBackground;
@property (weak, nonatomic) IBOutlet UIImageView *meetingTabBackground;

// Tab Buttons
@property (weak, nonatomic) IBOutlet UIButton *happyHourTabButton;
@property (weak, nonatomic) IBOutlet UIButton *sportsTabButton;
@property (weak, nonatomic) IBOutlet UIButton *coffeeTabButton;
@property (weak, nonatomic) IBOutlet UIButton *mealTabButton;
@property (weak, nonatomic) IBOutlet UIButton *meetingTabButton;

@end

@implementation AHCreateEventViewController

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
    // Do any additional setup after loading the view.
    
    self.selectedEventType = AHEventTypeHappyHour;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tab Controll
- (IBAction)happyHourTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.happyHourTabBackground];
    self.selectedEventType = AHEventTypeHappyHour;
}
- (IBAction)sportsTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.sportsTabBackground];
    self.selectedEventType = AHEventTypeSports;
}
- (IBAction)coffeeTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.coffeeTabBackground];
    self.selectedEventType = AHEventTypeCoffee;
}
- (IBAction)mealTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.mealTabBackground];
    self.selectedEventType = AHEventTypeMeal;
}
- (IBAction)meetingTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.meetingTabBackground];
    self.selectedEventType = AHEventTypeMeeting;
}

#pragma mark - Status Bar Style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Cancel Event Creation
- (IBAction)popViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
