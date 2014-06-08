//
//  AHProfileViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHProfileViewController.h"
#import "AHModels.h"

@interface AHProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *bdayLabel;

@end

@implementation AHProfileViewController

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
    
    AHUser *me = [AHUser currentUser];
    self.nameLabel.text = [me getName];
    self.emailLabel.text = [me getEmail];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    
    self.bdayLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[me getBirthday]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Logout Handler
- (IBAction)performLogout:(id)sender
{
    [AHUser logOut];
    [self performSegueWithIdentifier:@"successLogout" sender:self];
}

@end
