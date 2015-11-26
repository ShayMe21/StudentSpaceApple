//
//  FullStudentGrade.m
//  assignment_2
//
//  Created by smemari on 24/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import "FullStudentGrade.h"
#import "AddGradeController.h"

@interface FullStudentGrade ()
@property (strong) NSMutableArray *students;    //Save all students fetched from the CoreData
@end

@implementation FullStudentGrade
AppDelegate *appDelegate;   // get the main AppDelegate class
@synthesize studentFirstTxt, studentLastTxt, studentIdTxt;
@synthesize studentFirstName, studentId, studentLastName;

@synthesize unitCode1Var, unitCode2Var, unitCode3Var, unitCode4Var, unitCode5Var;
@synthesize unitName1Var, unitName2Var, unitName3Var, unitName4Var, unitName5Var;
@synthesize unitGrade1Var, unitGrade2Var, unitGrade3Var, unitGrade4Var, unitGrade5Var;

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
    //Set the textfields to the variables received from tableview controller.
    studentIdTxt.text = studentId;
    studentFirstTxt.text = studentFirstName;
    studentLastTxt.text = studentLastName;
    //Set all academic records from Objects passed from BriefStudentGrade.
    _unitCode1.text = unitCode1Var;
    _unitCode2.text = unitCode2Var;
    _unitCode3.text = unitCode3Var;
    _unitCode4.text = unitCode4Var;
    _unitCode5.text = unitCode5Var;
    
    _unitName1.text = unitName1Var;
    _unitName2.text = unitName2Var;
    _unitName3.text = unitName3Var;
    _unitName4.text = unitName4Var;
    _unitName5.text = unitName5Var;
    
    [_grade1 setText:unitGrade1Var];
    [_grade2 setText:unitGrade2Var];
    [_grade3 setText:unitGrade3Var];
    [_grade4 setText:unitGrade4Var];
    [_grade5 setText:unitGrade5Var];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//Calcualtes the GPA, average of all grades.
- (IBAction)calculateGPA:(id)sender{
    float gpa;
    int unitCount=0;
    if ([[_grade1 text] floatValue] > 0){
        unitCount++;
    }
    if ([[_grade2 text] floatValue] > 0){
        unitCount++;
    }
    if ([[_grade3 text] floatValue] > 0){
        unitCount++;
    }
    if ([[_grade4 text] floatValue] > 0){
        unitCount++;
    }
    if ([[_grade5 text] floatValue] > 0){
        unitCount++;
    }
    gpa = ([[_grade1 text] floatValue] + [[_grade2 text] floatValue] + [[_grade3 text] floatValue] + [[_grade4 text] floatValue] + [[_grade5 text] floatValue]) / unitCount;
    _studentGPA.text = [NSString stringWithFormat:@"%.2f", gpa];
    
}

- (IBAction)showGraph:(id)sender {
    [self performSegueWithIdentifier:@"showGraph" sender:self];
}

// Dismiss keyboard function
- (void)closeKeyboard {
    [self.view endEditing:TRUE];
}

//Move to Adding Units View.
- (IBAction)addUnit:(id)sender {
    [self performSegueWithIdentifier:@"AddUnitSegue" sender:self];
}


//Move to the view to add units and pass in the StudentId info
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddUnitSegue"]) {
        AddGradeController *destViewController = segue.destinationViewController;
        
        //Pass student ID to AddGradeController
        destViewController.studentIdSelected = self.studentIdTxt.text;

    }
}
@end
