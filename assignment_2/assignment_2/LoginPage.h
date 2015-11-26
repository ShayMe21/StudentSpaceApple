//
//  LoginPage.h
//  assignment_2
//
//  Created by smemari on 23/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisibleFormViewController.h"

@interface LoginPage : VisibleFormViewController<UIAlertViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *validLoginLabel;
- (IBAction)Login:(UIButton *)sender;
@end
