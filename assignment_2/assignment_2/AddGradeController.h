//
//  AddGradeController.h
//  assignment_2
//
//  Created by smemari on 25/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "VisibleFormViewController.h"

@interface AddGradeController : VisibleFormViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *unitCode1TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitCode2TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitCode3TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitCode4TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitCode5TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitName1TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitName2TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitName3TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitName4TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitName5TxtField;
@property (weak, nonatomic) IBOutlet UITextField *unitGrade1;
@property (weak, nonatomic) IBOutlet UITextField *unitGrade2;
@property (weak, nonatomic) IBOutlet UITextField *unitGrade3;
@property (weak, nonatomic) IBOutlet UITextField *unitGrade4;
@property (weak, nonatomic) IBOutlet UITextField *unitGrade5;
@property (weak, nonatomic) IBOutlet UITextField *studentIdTxtField;
@property (nonatomic, strong) NSString *studentIdSelected;  //To receive the studentID
- (IBAction)addUnit:(id)sender;

@end
