#import "TaskManager.h"
#import "Task.h"


@implementation TaskManager

+ (instancetype)sharedManager {
    static TaskManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance loadTasks];
    });
    
    return sharedInstance;
}



- (instancetype)init {
    self = [super init];
    if (self) {
        _tasks = [NSMutableArray array];
    }
    return self;
}

- (NSArray<Task *> *)getAllTasks {
    NSLog(@"getAllTasks called, returning %lu tasks", (unsigned long)self.tasks.count);
    return [self.tasks copy];
}

- (NSArray *)allTasks {
    return [self.tasks copy];
}

- (void)addTask:(Task *)task {
    [self.tasks addObject:task];
    [self saveTasks];
}

- (void)updateTask:(Task *)task {
    for (NSInteger i = 0; i < self.tasks.count; i++) {
        Task *existingTask = self.tasks[i];
        if ([existingTask.taskId isEqualToString:task.taskId]) {
            [self.tasks replaceObjectAtIndex:i withObject:task];
            break;
        }
    }
    [self saveTasks];
}

- (void)deleteTask:(Task *)task {
    NSInteger indexToRemove = NSNotFound;
    for (NSInteger i = 0; i < self.tasks.count; i++) {
        Task *existingTask = self.tasks[i];
        if ([existingTask.taskId isEqualToString:task.taskId]) {
            indexToRemove = i;
            break;
        }
    }
    
    if (indexToRemove != NSNotFound) {
        [self.tasks removeObjectAtIndex:indexToRemove];
        [self saveTasks];
    }
}

- (void)saveTasks {
    NSData *tasksData = [NSKeyedArchiver archivedDataWithRootObject:self.tasks];
    [[NSUserDefaults standardUserDefaults] setObject:tasksData forKey:@"savedTasks"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)loadTasks {
    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedTasks"];
    if (tasksData) {
        NSArray *loadedTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
        if (loadedTasks) {
            self.tasks = [loadedTasks mutableCopy];
        }
    }
}

@end
