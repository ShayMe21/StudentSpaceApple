//
//  LoginPage.m
//  assignment_2
//
//  Created by smemari on 23/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import "LoginPage.h"
#include "BriefStudentRecord.h"
@interface LoginPage ()

@end

@implementation LoginPage

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
    // Dismiss keyboard on outside tap
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    viewTap.cancelsTouchesInView = FALSE;
    [self.view addGestureRecognizer:viewTap];
    _usernameTextField.delegate = self;
    _passwordTextField.delegate = self;
    self.lastVisibleView = _passwordTextField;
}


// Dismiss keyboard function
- (void)closeKeyboard {
    [self.view endEditing:TRUE];
}

//Validation for Login credentials.
//Default details are: admin/password.
- (IBAction)Login:(UIButton *)sender {
    NSString * Username=_usernameTextField.text;
    NSString * Password=_passwordTextField.text;
    if ([Username  isEqual: @"admin"] && [Password isEqual:@"password"])
    {
         _validLoginLabel.text = @"";
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Login"
                                                            message:@"Successfull!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertview show];
        
    }
    else
    {
        _validLoginLabel.text = @"Wrong Username Or Password.";
       
    }
    
    
    
}

/* After successful login, and pressing OK on AlertView will open the Tab bar controller of the app.*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        UIViewController *briefRecords = [self.storyboard instantiateViewControllerWithIdentifier:@"BriefStudentRecord"];
        [self presentViewController:briefRecords animated:YES completion:nil];
    }
}

//Move to the next textfield upon pressing return
- (BOOL) textFieldShouldReturn:(UITextField *) textField {
    /* Focus changes to the next textfield as user presses next */
    if(textField.returnKeyType==UIReturnKeyNext) {
        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
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

@end
