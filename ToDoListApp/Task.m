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
        _name = @"";
        _taskDescription = @"";
        _priority = TASK_PRIORITY_LOW;
        _dueDate = [NSDate date];
        _status = TASK_STATUS_TODO;
    }
    return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeInteger:self.priority forKey:@"priority"];
    [coder encodeObject:self.dueDate forKey:@"dueDate"];
    [coder encodeInteger:self.status forKey:@"status"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _taskDescription = [coder decodeObjectForKey:@"description"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _dueDate = [coder decodeObjectForKey:@"dueDate"];
        _status = [coder decodeIntegerForKey:@"status"];
    }
    return self;
}

@end
