//
//  AddStudentController.m
//  assignment_2
//
//  Created by smemari on 22/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import "AddStudentController.h"

@interface AddStudentController ()

@end

@implementation AddStudentController
AppDelegate *appDelegate;   // get the main AppDelegate class
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Dismiss keyboard on outside tap
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    viewTap.cancelsTouchesInView = FALSE;
    [self.view addGestureRecognizer:viewTap];
    //Load Date Picker
    [self.datepicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    _studentDOBTextField.enabled = false;    // Disable editing DOB field.
    _studentAddressTextField.delegate = self;
    _studentCourseTextField.delegate = self;
    _studentFnameTextField.delegate = self;
    _studentIdTextField.delegate = self;
    _studentLnameTextField.delegate = self;
    
}

//Detects the textfield in focus and sets it as the last visible view to move the view above the keyboard.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.lastVisibleView = textField;
}

//Once Add photo is clicked, photo library is loaded to select a picture from.
- (IBAction)addPhoto:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion: NULL];
    
}

//The selected picture from gallery is set to the imageview and student.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _studentImage.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imagePath = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"ImagePath: %@", imagePath);
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//Cancelling photo selection returns us to view.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//Add the student information to coreData
//Minimum requirement is studentID should be filled in.
//Alertview pops up to show successful Adding of record.
- (IBAction)addStudent:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if ([_studentIdTextField.text isEqualToString:@""]){
        [_validationLabel setText:@"StudentID is required."];
        
    } else {
        // Create a new managed object
        NSManagedObject *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
        
        [newStudent setValue:self.studentIdTextField.text forKey:@"studentId"];
        [newStudent setValue:self.studentFnameTextField.text forKey:@"studentFname"];
        [newStudent setValue:self.studentLnameTextField.text forKey:@"studentLname"];
        [newStudent setValue:[_studentGenderSelection titleForSegmentAtIndex:_studentGenderSelection.selectedSegmentIndex] forKey:@"studentGender"];
        [newStudent setValue:self.studentDOBTextField.text forKey:@"studentDOB"];
        [newStudent setValue:self.studentAddressTextField.text forKey:@"studentAddress"];
        [newStudent setValue:self.studentCourseTextField.text forKey:@"studentCourse"];
        NSString *myString = [imagePath absoluteString];
        [newStudent setValue:myString forKey:@"imagePath"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else{
            NSLog(@"Record Added!");
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Student Record"
                                                                message:@"Record was added successfully!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertview show];
        }

        
    }
    
    
}


// After adding a student was successful, pressing Ok takes user back to tableview.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        UIViewController *BriefRecords = [self.storyboard instantiateViewControllerWithIdentifier:@"BriefStudentRecord"];
        [self presentViewController:BriefRecords animated:YES completion:nil];
    }
}

//Set DOB text to selected Date.
- (void)datePickerChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date]; self.studentDOBTextField.text = strDate;
}

// Dismiss keyboard function
- (void)closeKeyboard {
    [self.view endEditing:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
