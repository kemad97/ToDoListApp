//
//  AddTaskDelegate.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN
@class AddTaskViewController;


@protocol AddTaskDelegate <NSObject>

-(void)addTaskViewController:(AddTaskViewController *)controller didCreateTask:(Task *)task;

@end

NS_ASSUME_NONNULL_END
