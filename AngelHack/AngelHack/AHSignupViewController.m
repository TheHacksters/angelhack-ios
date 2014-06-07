//
//  AHSignupViewController.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHSignupViewController.h"

@interface AHSignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *bdayField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *rpwdField;

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

@end
