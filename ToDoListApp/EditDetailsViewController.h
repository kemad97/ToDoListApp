//
//  EditDetailsViewController.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "ViewController.h"
#import "AddTaskDelegate.h"



NS_ASSUME_NONNULL_BEGIN

@interface EditDetailsViewController : ViewController

@property  Task *task;
@property id<AddTaskDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
