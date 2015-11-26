//
//  BriefStudentGrade.h
//  assignment_2
//
//  Created by smemari on 22/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FullStudentGrade.h"

@interface BriefStudentGrade : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    NSIndexPath *selectedIndexPath;     //The selected cell in the tableview
}
@property (weak, nonatomic) IBOutlet UITableView *briefTableGrades;
@property (nonatomic, retain) NSIndexPath *selectedIndexPathForGrade;
@end