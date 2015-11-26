//
//  FullStudentRecord.m
//  assignment_2
//
//  Created by smemari on 23/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import "FullStudentRecord.h"

@interface FullStudentRecord ()

@end

@implementation FullStudentRecord
AppDelegate *appDelegate;   // get the main AppDelegate class
@synthesize studentFnameTxt, studentIdTxt, studentLnameTxt, studentAddrTxt, studentCourseTxt, studentGenderSel, studentDOBTxt;
@synthesize studentAddress, studentCourse, studentDOB, studentFirstName, studentGender, studentId, studentLastName, imagePathString;


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

//Detects the textfield in focus and sets it as the last visible view to move the view above the keyboard.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.lastVisibleView = textField;
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
    studentDOBTxt.enabled = false;    // Disable editing DOB field.
    //Set the textfields to the variables received from tableview controller.
    studentIdTxt.text = studentId;
    
    studentFnameTxt.text = studentFirstName;
    studentLnameTxt.text = studentLastName;
    studentDOBTxt.text = studentDOB;
    studentAddrTxt.text = studentAddress;
    studentCourseTxt.text = studentCourse;
    if ([studentGender isEqual:@"Male"]){
        studentGenderSel.selectedSegmentIndex = 0;
    }
    else if ([studentGender isEqual:@"Female"]){
        studentGenderSel.selectedSegmentIndex = 1;
    }
    
    studentAddrTxt.delegate = self;
    studentCourseTxt.delegate = self;
    studentFnameTxt.delegate = self;
    studentLnameTxt.delegate = self;
    
    //Load the image from URL path to image.
    NSURL* aURL = [NSURL URLWithString:imagePathString];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:aURL resultBlock:^(ALAsset *asset)
     {
         UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
         _studentImage.image = copyOfOriginalImage;
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----");
     }];
    
    
}



//Delete a record selected.
- (IBAction)deleteRecord:(UIButton *)sender {
    NSString *SelectedID = studentIdTxt.text;   //Get the studentID of the student.

    NSEntityDescription *studentEntity=[NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:studentEntity];
    
    NSPredicate *item=[NSPredicate predicateWithFormat:@"studentId == %@", SelectedID];
    [fetch setPredicate:item];

    NSError *fetchError = nil;
    NSArray *fetchedRecords=[self.managedObjectContext executeFetchRequest:fetch error:&fetchError];    //Save fetched records with that student ID
    
    for (NSManagedObject *student in fetchedRecords) {             //Delete all objects in fetchedRecords array
        [self.managedObjectContext deleteObject:student];
    }
    NSLog(@"Record Deleted!");
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Student Record"
                                                        message:@"Record was deleted successfully!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertview show];
    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];
}

// After deleting a student was successful, pressing Ok takes user back to tableview.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        UIViewController *BriefRecords = [self.storyboard instantiateViewControllerWithIdentifier:@"BriefStudentRecord"];
        [self presentViewController:BriefRecords animated:YES completion:nil];
    }
}

- (IBAction)editRecord:(UIButton *)sender {
    NSString *SelectedID = studentIdTxt.text;   //Get the studentID of the student.
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *studentEntity=[NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:studentEntity];
    
    NSPredicate *item=[NSPredicate predicateWithFormat:@"studentId == %@", SelectedID];
    [fetch setPredicate:item];
    
    NSError *fetchError = nil;
    NSArray *fetchedRecords=[self.managedObjectContext executeFetchRequest:fetch error:&fetchError];    //Save fetched records with that student ID
    
    for (NSManagedObject *student in fetchedRecords) {             //Delete all objects in fetchedRecords array
        [student setValue:studentAddrTxt.text  forKey:@"studentAddress"];
        [student setValue:studentCourseTxt.text  forKey:@"studentCourse"];
        [student setValue:studentDOBTxt.text  forKey:@"studentDOB"];
        [student setValue:studentFnameTxt.text  forKey:@"studentFname"];
        [student setValue:studentLnameTxt.text  forKey:@"studentLname"];
        [student setValue:studentIdTxt.text  forKey:@"studentId"];
        [student setValue:[studentGenderSel titleForSegmentAtIndex:studentGenderSel.selectedSegmentIndex]  forKey:@"studentGender"];
        NSString *myString = [imagePath absoluteString];    //Convert NSURL to String for storing in COredata.
        [student setValue:myString forKey:@"imagePath"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Record Saved!");
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Student Record"
                                                            message:@"Record was saved successfully!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertview show];
        NSError *saveError = nil;
        [self.managedObjectContext save:&saveError];

    }

    
    
}

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

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Set DOB text to selected Date.
- (void)datePickerChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date]; self.studentDOBTxt.text = strDate;
}

// Dismiss keyboard function
- (void)closeKeyboard {
    [self.view endEditing:TRUE];
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
