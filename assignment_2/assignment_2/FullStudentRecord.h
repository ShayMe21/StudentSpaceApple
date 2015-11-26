//
//  FullStudentRecord.h
//  assignment_2
//
//  Created by smemari on 23/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BriefStudentRecord.h"
#import "VisibleFormViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface FullStudentRecord : VisibleFormViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
        UIImagePickerController * picker;
        NSURL* imagePath;
}
@property (weak, nonatomic) IBOutlet UITextField *studentIdTxt;
@property (weak, nonatomic) IBOutlet UITextField *studentFnameTxt;
@property (weak, nonatomic) IBOutlet UITextField *studentLnameTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *studentGenderSel;
@property (weak, nonatomic) IBOutlet UITextField *studentDOBTxt;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UITextField *studentAddrTxt;
@property (weak, nonatomic) IBOutlet UITextField *studentCourseTxt;
@property (nonatomic, strong) NSString *studentId;
@property (nonatomic, strong) NSString *studentFirstName;
@property (nonatomic, strong) NSString *studentLastName;
@property (nonatomic, strong) NSString *studentGender;
@property (nonatomic, strong) NSString *studentDOB;
@property (nonatomic, strong) NSString *studentAddress;
@property (nonatomic, strong) NSString *studentCourse;
@property (nonatomic, strong) NSString *imagePathString;

@property (weak, nonatomic) IBOutlet UIImageView *studentImage;
- (IBAction)deleteRecord:(UIButton *)sender;
- (IBAction)editRecord:(UIButton *)sender;
- (IBAction)addPhoto:(id)sender;

@end
