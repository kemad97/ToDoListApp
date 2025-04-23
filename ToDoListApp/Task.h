//
//  Task.h
//  ToDoListApp
//
//  Created by Kerolos on 22/04/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) NSInteger priority; // 0=low, 1=medium, 2=high
@property (nonatomic, strong) NSDate *dueDate;

@end

NS_ASSUME_NONNULL_END
