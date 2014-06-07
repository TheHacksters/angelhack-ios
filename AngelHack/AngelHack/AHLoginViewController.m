//
//  AHLoginViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHLoginViewController.h"
#import "AHUtils.h"

@interface AHLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usrField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;


@property (weak, nonatomic) IBOutlet UIView *loginContainerView;
@property (weak, nonatomic) IBOutlet UIView *passwordContainerView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation AHLoginViewController

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

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    // Setting Textfield Border Color
    self.loginContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:1.0f].CGColor;
    self.passwordContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:0.980392f].CGColor;
    
    // Setting Login Button State Color
    UIView *greenBackgroundView = [[UIView alloc] initWithFrame:self.loginButton.frame];
    greenBackgroundView.backgroundColor = [UIColor colorWithRed:0.384313725f green:0.6745098f blue:0.3607843f alpha:1.0f];
    UIImage *greenBackground = [AHUtils imageFromView:greenBackgroundView];
    // Setting Signup Button State Color
    UIView *blueBackgroundView = [[UIView alloc] initWithFrame:self.signupButton.frame];
    blueBackgroundView.backgroundColor = [UIColor colorWithRed:0.41960784f green:0.5725490f blue:0.666666667f alpha:1.0f];
    
    UIImage *blueBackground = [AHUtils imageFromView:blueBackgroundView];
    
    [self.loginButton setBackgroundImage:greenBackground forState:UIControlStateNormal];
    [self.signupButton setBackgroundImage:blueBackground forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login Handler
- (IBAction)performLogin:(id)sender {
    if (![self validEmail]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"Por favor, insira um email válido.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.pwdField.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao entrar";
        NSString *message = @"Sua senha deve conter pelo menos 6 caracteres.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [AHUser logInWithUsernameInBackground:self.usrField.text password:self.pwdField.text block:^(PFUser *    user, NSError *error) {
        if (error) {
            NSLog(@"ERROR: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] init];
            
            NSString *title = @"Erro ao entrar";
            NSString *message = @"";
            
            if (error.code == 101) {
                message = @"Email ou senha inválidos!";
            }
            
            alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            AHUser *myUser = (AHUser *)user;
            NSLog(@"DATA %@", myUser);
            
            [self performSegueWithIdentifier:@"successLogin" sender:self];
        }
    }];
}

#pragma mark - Support Methods
- (BOOL)validEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if(![emailTest evaluateWithObject:self.usrField.text])
    {
        return NO;
    }
    return YES;
}

-(void)dismissKeyboard
{
    [self.usrField resignFirstResponder];
    [self.pwdField resignFirstResponder];
    
}

#pragma mark - Status Bar Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
