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

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL userAuthenticated = [[AHUser currentUser] isAuthenticated];
    
    if (userAuthenticated) {
        [self performSegueWithIdentifier:@"successLogin" sender:self];
    }
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
    
    [AHUser logInWithUsernameInBackground:self.usrField.text password:self.pwdField.text block:^(PFUser *user, NSError *error) {
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
            
            [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:@"user"];
            [[PFInstallation currentInstallation] saveEventually];
            
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
