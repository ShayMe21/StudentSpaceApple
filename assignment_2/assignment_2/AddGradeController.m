//
//  AddGradeController.m
//  assignment_2
//
//  Created by smemari on 25/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import "AddGradeController.h"

@interface AddGradeController ()

@end

@implementation AddGradeController
AppDelegate *appDelegate;   // get the main AppDelegate class
@synthesize studentIdSelected;
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
    //For Allowing Return key to jump to next tagged TextField.
    _unitCode1TxtField.delegate = self;
    _unitCode2TxtField.delegate = self;
    _unitCode3TxtField.delegate = self;
    _unitCode4TxtField.delegate = self;
    _unitCode5TxtField.delegate = self;
    _unitName1TxtField.delegate = self;
    _unitName2TxtField.delegate = self;
    _unitName3TxtField.delegate = self;
    _unitName4TxtField.delegate = self;
    _unitName5TxtField.delegate = self;
    _unitGrade1.delegate = self;
    _unitGrade2.delegate = self;
    _unitGrade3.delegate = self;
    _unitGrade4.delegate = self;
    _unitGrade5.delegate = self;
    _studentIdTxtField.text = studentIdSelected;    //Set studentID received from previous controller.

}

// After adding a student was successful, pressing Ok takes user back to tableview.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        UIViewController *BriefRecords = [self.storyboard instantiateViewControllerWithIdentifier:@"BriefStudentGrade"];
        [self presentViewController:BriefRecords animated:YES completion:nil];
    }
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

//Detects the textfield in focus and sets it as the last visible view to move the view above the keyboard.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.lastVisibleView = textField;
}

//Add the units to the object specific to the student ID selected
- (IBAction)addUnit:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *studentEntity=[NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:studentEntity];
    
    NSPredicate *item=[NSPredicate predicateWithFormat:@"studentId == %@", studentIdSelected];
    [fetch setPredicate:item];
    
    NSError *fetchError = nil;
    NSArray *fetchedRecords=[self.managedObjectContext executeFetchRequest:fetch error:&fetchError];    //Save fetched records with that student ID
    
    
    
    for (NSManagedObject *student in fetchedRecords) {             //Delete all objects in fetchedRecords array
        [student setValue:_unitCode1TxtField.text  forKey:@"unitCode1"];
        [student setValue:_unitCode2TxtField.text  forKey:@"unitCode2"];
        [student setValue:_unitCode3TxtField.text  forKey:@"unitCode3"];
        [student setValue:_unitCode4TxtField.text  forKey:@"unitCode4"];
        [student setValue:_unitCode5TxtField.text  forKey:@"unitCode5"];
        
        [student setValue:_unitName1TxtField.text forKey:@"unitName1"];
        [student setValue:_unitName2TxtField.text forKey:@"unitName2"];
        [student setValue:_unitName3TxtField.text forKey:@"unitName3"];
        [student setValue:_unitName4TxtField.text forKey:@"unitName4"];
        [student setValue:_unitName5TxtField.text forKey:@"unitName5"];
        
        [student setValue:_unitGrade1.text forKey:@"unitGrade1"];
        [student setValue:_unitGrade2.text forKey:@"unitGrade2"];
        [student setValue:_unitGrade3.text forKey:@"unitGrade3"];
        [student setValue:_unitGrade4.text forKey:@"unitGrade4"];
        [student setValue:_unitGrade5.text forKey:@"unitGrade5"];
        

    }
    NSLog(@"unitcode1TxtField: %@", _unitCode1TxtField.text);
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Units Saved!");
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Student Units"
                                                            message:@"Units were saved successfully!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertview show];
        NSError *saveError = nil;
        [self.managedObjectContext save:&saveError];
        
    }
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}
@end
