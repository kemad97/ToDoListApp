//
//  Task.m
//  ToDoListApp
//
//  Created by Kerolos on 22/04/2025.
//

#import "Task.h"

@implementation Task

- (instancetype)init {
    self = [super init];
    if (self) {
        _taskId = [[NSUUID UUID] UUIDString];

        _name = @"";
        _taskDescription = @"";
        _priority = TASK_PRIORITY_LOW;
        _dueDate = [NSDate date];
        _status = TASK_STATUS_TODO;
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.taskId forKey:@"taskId"];

    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.taskDescription forKey:@"taskDescription"];
    [coder encodeInteger:self.priority forKey:@"priority"];
    [coder encodeObject:self.dueDate forKey:@"dueDate"];
    [coder encodeInteger:self.status forKey:@"status"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    if ( self = [super init])
    {
        _taskId = [coder decodeObjectForKey:@"taskId"];  

        _name = [coder decodeObjectForKey:@"name"];
        _taskDescription = [coder decodeObjectForKey:@"taskDescription"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _dueDate = [coder decodeObjectForKey:@"dueDate"];
        _status = [coder decodeIntegerForKey:@"status"];
    }
    return self;
}

@end
