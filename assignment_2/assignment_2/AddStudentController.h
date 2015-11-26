//
//  AddStudentController.h
//  assignment_2
//
//  Created by smemari on 22/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "VisibleFormViewController.h"

@interface AddStudentController : VisibleFormViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController * picker;
    NSURL* imagePath;
}
@property (weak, nonatomic) IBOutlet UITextField *studentIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentFnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentLnameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UITextField *studentDOBTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *studentGenderSelection;
@property (weak, nonatomic) IBOutlet UITextField *studentAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentCourseTextField;
@property (weak, nonatomic) IBOutlet UILabel *validationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *studentImage;
- (IBAction)addStudent:(id)sender;
- (IBAction)addPhoto:(id)sender;
@end
