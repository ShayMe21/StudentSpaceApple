//
//  BriefStudentRecord.h
//  assignment_2
//
//  Created by smemari on 22/10/2015.
//  Copyright (c) 2015 uws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BriefStudentRecord : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    NSIndexPath *selectedIndexPath;     //The selected cell in the tableview
}
@property (weak, nonatomic) IBOutlet UITableView *briefRecordsTable;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@end