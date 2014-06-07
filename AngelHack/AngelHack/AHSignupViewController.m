//
//  AHSignupViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHSignupViewController.h"
#import "AHUtils.h"

@interface AHSignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *bdayField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *rpwdField;

@property (weak, nonatomic) IBOutlet UIView *emailContainerView;
@property (weak, nonatomic) IBOutlet UIView *nameContainerView;
@property (weak, nonatomic) IBOutlet UIView *bdayContainerView;
@property (weak, nonatomic) IBOutlet UIView *pwdContainerView;
@property (weak, nonatomic) IBOutlet UIView *rpwdContainerView;

@property (weak, nonatomic) IBOutlet UIButton *createButton;


@end

@implementation AHSignupViewController

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
    
    //Change Placeholder Font Color
    self.emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.bdayField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Birthday" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.pwdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.rpwdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Retype Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // Setting Textfield Border Color
    self.emailContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:1.0f].CGColor;
    self.nameContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:0.980392f].CGColor;
    self.bdayContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:0.980392f].CGColor;
    self.pwdContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:0.980392f].CGColor;
    self.rpwdContainerView.layer.borderColor = [UIColor colorWithRed:0.980392f green:0.980392f blue:0.980392f alpha:0.980392f].CGColor;
    
    // Setting Login Button State Color
    UIView *greenBackgroundView = [[UIView alloc] initWithFrame:self.createButton.frame];
    greenBackgroundView.backgroundColor = [UIColor colorWithRed:0.384313725f green:0.6745098f blue:0.3607843f alpha:1.0f];
    UIImage *greenBackground = [AHUtils imageFromView:greenBackgroundView];
    [self.createButton setBackgroundImage:greenBackground forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Signup Handler
- (IBAction)performSignup:(id)sender {
    
    if (![self validEmail]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"Por favor, insira um email válido.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![self.pwdField.text isEqualToString:self.rpwdField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"As senhas devem ser iguais";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.pwdField.text.length < 6 || self.rpwdField.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"Sua senha deve conter pelo menos 6 caracteres.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
#warning Ajustar a data
    AHUser *myUser = [[AHUser alloc] initWithUsername:self.emailField.text andPassword:self.pwdField.text andName: self.nameField.text andBirthday: @"a"];
    
    
    [myUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"SUCCESS: %d", succeeded);
            
            [self performSegueWithIdentifier:@"successSignup" sender:self];
        } else {
            NSLog(@"ERROR: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] init];
            
            NSString *title = @"Erro ao cadastrar";
            NSString *message = @"";
            
            if (error.code == 200) {
                message = @"Por favor, insira seu email.";
            }
            
            if (error.code == 201) {
                message = @"Por favor, insira sua senha corretamente.";
            }
            
            if (error.code == 202 || error.code == 203) {
                message = @"Este email já está sendo utilizado.";
            }
            
            alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

#pragma mark - Support Methods
- (BOOL)validEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if(![emailTest evaluateWithObject:self.emailField.text])
    {
        return NO;
    }
    return YES;
}

-(void)dismissKeyboard
{
    [self.emailField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.bdayField resignFirstResponder];
    [self.pwdField resignFirstResponder];
    [self.rpwdField resignFirstResponder];
    
}

#pragma mark - Status Bar Style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Dismiss Signup
- (IBAction)dismissSignup:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
