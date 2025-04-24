//
//  AddTaskViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "AddTaskViewController.h"
#import "TaskManager.h"
#import "Task.h"

@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_taskName;
@property (weak, nonatomic) IBOutlet UITextView *tv_taskDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) TaskManager *taskManager;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.taskManager = [[TaskManager alloc] init];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnAddTask:(id)sender {
    Task *newTask = [Task new];
    newTask.name=_tf_taskName.text;
    newTask.taskDescription=_tv_taskDesc.text;
    
    switch (_segment_priority.selectedSegmentIndex) {
        case 0:
            newTask.priority=TASK_PRIORITY_LOW;
            break;

        case 1:
            newTask.priority=TASK_PRIORITY_MEDIUM;
            break;
            
        case 2:
            newTask.priority=TASK_PRIORITY_HIGH;
            break;
            
        default:
            newTask.priority=TASK_PRIORITY_MEDIUM;
            break;
    }
    newTask.dueDate=self.datePicker.date;
    newTask.status=TASK_STATUS_TODO;
    
    [[TaskManager sharedManager] addTask:newTask];

    
    [self.delegate addTaskViewController:self MyTask:newTask];

    [self.navigationController popViewControllerAnimated:YES];

}

@end
