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
        _name = @"test";
        _description = @"desc";
        _priority = 0;
        _dueDate = [NSDate date];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeInteger:self.priority forKey:@"priority"];
    [coder encodeObject:self.dueDate forKey:@"dueDate"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _description = [coder decodeObjectForKey:@"description"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _dueDate = [coder decodeObjectForKey:@"dueDate"];
    }
    return self;
}

@end


