//
//  BriefStudentGrade.m
//  assignment_2
//
//  Created by smemari on 22/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import "BriefStudentGrade.h"


@interface BriefStudentGrade ()
@property (strong) NSMutableArray *students;    //Save all students fetched from the CoreData
@end

@implementation BriefStudentGrade
@synthesize briefTableGrades;
@synthesize selectedIndexPathForGrade;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    self.students = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //Load all the objects stored in the coredata into our tableview
    [self.briefTableGrades reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//Get the managed object context
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


//Upon selecting a record from tableview, get studentId of the cell selected and pass it on to fullrecords controller.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected section>> %ld",(long)indexPath.section);              //FOR DEBUGGING ONLY.
    NSLog(@"Selected row of section >> %ld",(long)indexPath.row);          //FOR DEBUGGING ONLY.

    //Get the selected Student ID from the cell.
    NSManagedObject *selectedStudent = [self.students objectAtIndex:indexPath.row];
    NSLog(@"Student ID >> %@", [selectedStudent valueForKey:@"studentId"]);     //FOR DEBUGGING ONLY.
    selectedIndexPathForGrade = indexPath;                                  //Set the selected row indexpat to the global var indexpath
    [self performSegueWithIdentifier:@"showFullGrade" sender:self];
}

// Populate tableview with cells containing student information.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    NSManagedObject *student = [self.students objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ %@", [student valueForKey:@"studentFname"],     //first name, Id and surname will be shown on the left side.
                             [student valueForKey:@"studentLname"], [student valueForKey:@"studentId"]]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", [student valueForKey:@"studentCourse"]]];   //studentCourse will be shown on the right side of row.
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 12.0 ];      //Set the font of cells to Arial 12.0
    cell.textLabel.font  = myFont;
    cell.detailTextLabel.font = myFont;
    return cell;
}

// Afer selecting a record from briefStudentRecord, send the Details to the FullStudentRecord view controller.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showFullGrade"]) {
        FullStudentGrade *destViewController = segue.destinationViewController;
        NSManagedObject *selectedStudent = [self.students objectAtIndex:selectedIndexPathForGrade.row];
        NSLog(@"IndexPath Row: %ld", (long)selectedIndexPathForGrade.row);                          //DEBUGGING
        NSLog(@"%@", [selectedStudent valueForKey:@"studentId"]);
        
        //Pass student info to FullStudentRecord controller
        destViewController.studentId = [selectedStudent valueForKey:@"studentId"];
        destViewController.studentFirstName = [selectedStudent valueForKey:@"studentFname"];
        destViewController.studentLastName = [selectedStudent valueForKey:@"studentLname"];
        
        destViewController.unitCode1Var = [selectedStudent valueForKey:@"unitCode1"];
        destViewController.unitCode2Var = [selectedStudent valueForKey:@"unitCode2"];
        destViewController.unitCode3Var = [selectedStudent valueForKey:@"unitCode3"];
        destViewController.unitCode4Var = [selectedStudent valueForKey:@"unitCode4"];
        destViewController.unitCode5Var = [selectedStudent valueForKey:@"unitCode5"];
        
        destViewController.unitName1Var = [selectedStudent valueForKey:@"unitName1"];
        destViewController.unitName2Var = [selectedStudent valueForKey:@"unitName2"];
        destViewController.unitName3Var = [selectedStudent valueForKey:@"unitName3"];
        destViewController.unitName4Var = [selectedStudent valueForKey:@"unitName4"];
        destViewController.unitName5Var = [selectedStudent valueForKey:@"unitName5"];
        
        destViewController.unitGrade1Var = [selectedStudent valueForKey:@"unitGrade1"];
        destViewController.unitGrade2Var = [selectedStudent valueForKey:@"unitGrade2"];
        destViewController.unitGrade3Var = [selectedStudent valueForKey:@"unitGrade3"];
        destViewController.unitGrade4Var = [selectedStudent valueForKey:@"unitGrade4"];
        destViewController.unitGrade5Var = [selectedStudent valueForKey:@"unitGrade5"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//We only use on section in the tableview.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Returns number of records in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.students.count;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


@end
