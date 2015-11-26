//
//  FullStudentGrade.h
//  assignment_2
//
//  Created by smemari on 24/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BriefStudentGrade.h"

@interface FullStudentGrade : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *studentIdTxt;
@property (weak, nonatomic) IBOutlet UITextField *studentFirstTxt;
@property (weak, nonatomic) IBOutlet UITextField *studentLastTxt;
@property (weak, nonatomic) IBOutlet UITextField *studentGPA;
@property (weak, nonatomic) IBOutlet UITextField *unitCode1;
@property (weak, nonatomic) IBOutlet UITextField *unitCode2;
@property (weak, nonatomic) IBOutlet UITextField *unitCode3;
@property (weak, nonatomic) IBOutlet UITextField *unitCode4;
@property (weak, nonatomic) IBOutlet UITextField *unitCode5;
@property (weak, nonatomic) IBOutlet UITextField *unitName1;
@property (weak, nonatomic) IBOutlet UITextField *unitName2;
@property (weak, nonatomic) IBOutlet UITextField *unitName3;
@property (weak, nonatomic) IBOutlet UITextField *unitName4;
@property (weak, nonatomic) IBOutlet UITextField *unitName5;
@property (weak, nonatomic) IBOutlet UILabel *grade1;
@property (weak, nonatomic) IBOutlet UILabel *grade2;
@property (weak, nonatomic) IBOutlet UILabel *grade3;
@property (weak, nonatomic) IBOutlet UILabel *grade4;
@property (weak, nonatomic) IBOutlet UILabel *grade5;
@property (nonatomic, strong) NSString *studentId;
@property (nonatomic, strong) NSString *studentFirstName;
@property (nonatomic, strong) NSString *studentLastName;

- (IBAction)calculateGPA:(id)sender;
- (IBAction)showGraph:(id)sender;
@property (nonatomic, strong) NSString *unitCode1Var;
@property (nonatomic, strong) NSString *unitCode2Var;
@property (nonatomic, strong) NSString *unitCode3Var;
@property (nonatomic, strong) NSString *unitCode4Var;
@property (nonatomic, strong) NSString *unitCode5Var;

@property (nonatomic, strong) NSString *unitName1Var;
@property (nonatomic, strong) NSString *unitName2Var;
@property (nonatomic, strong) NSString *unitName3Var;
@property (nonatomic, strong) NSString *unitName4Var;
@property (nonatomic, strong) NSString *unitName5Var;

@property (nonatomic, strong) NSString *unitGrade1Var;
@property (nonatomic, strong) NSString *unitGrade2Var;
@property (nonatomic, strong) NSString *unitGrade3Var;
@property (nonatomic, strong) NSString *unitGrade4Var;
@property (nonatomic, strong) NSString *unitGrade5Var;

- (IBAction)addUnit:(id)sender;
@end
