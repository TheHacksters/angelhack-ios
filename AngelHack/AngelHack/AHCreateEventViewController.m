//
//  AHCreateEventViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHCreateEventViewController.h"
#import "AHEvent.h"
#import "AHBorderedColorButton.h"

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

// Text Fields
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventLocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventDateTextField;

// Create Button
@property (weak, nonatomic) IBOutlet AHBorderedColorButton *createNewEventButton;


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
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
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
    self.createNewEventButton.normalStateColor = [UIColor colorWithRed:202.0f/255.0f green:158.0f/255.0f blue:72.0f/255.0f alpha:1.0f];
}
- (IBAction)sportsTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.sportsTabBackground];
    self.selectedEventType = AHEventTypeSports;
    self.createNewEventButton.normalStateColor = [UIColor colorWithRed:61.0f/255.0f green:156.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
}
- (IBAction)coffeeTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.coffeeTabBackground];
    self.selectedEventType = AHEventTypeCoffee;
    self.createNewEventButton.normalStateColor = [UIColor colorWithRed:84.0f/255.0f green:45.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
}
- (IBAction)mealTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.mealTabBackground];
    self.selectedEventType = AHEventTypeMeal;
    self.createNewEventButton.normalStateColor = [UIColor colorWithRed:136.0f/255.0f green:84.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
}
- (IBAction)meetingTab:(id)sender {
    [self.tabBackgrounds bringSubviewToFront:self.meetingTabBackground];
    self.selectedEventType = AHEventTypeMeeting;
    self.createNewEventButton.normalStateColor = [UIColor colorWithRed:56.0f/255.0f green:115.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
}

#pragma mark - Create New Event

- (IBAction)creteNewEvent:(id)sender {
}

#pragma mark - Keyboard Dismissal

-(void)dismissKeyboard
{
    [self.eventNameTextField resignFirstResponder];
    [self.eventLocationTextField resignFirstResponder];
    [self.eventDateTextField resignFirstResponder];
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
