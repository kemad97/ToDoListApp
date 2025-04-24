//
//  EditDetailsViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "EditDetailsViewController.h"
#import "TaskManager.h"
#import "Task.h"



@interface EditDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_taskName;
@property (weak, nonatomic) IBOutlet UITextView *tv_taskDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_Priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_State;

@end

@implementation EditDetailsViewController

- (void)viewDidLoad {
    
 
    [super viewDidLoad];
    self.tf_taskName.text = self.task.name;
    self.tv_taskDesc.text = self.task.taskDescription;
    
    [self.segment_Priority setSelectedSegmentIndex:self.task.priority];

    self.datePicker.date = self.task.dueDate;
    
    [self.segment_State setSelectedSegmentIndex:self.task.status];

    self.title = @"Edit Task";

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnEditTask:(id)sender {
    
        Task *updatedTask = [[Task alloc] init];
    
    updatedTask.taskId = self.task.taskId; // save original task ID

        updatedTask.name = self.tf_taskName.text;
        updatedTask.taskDescription = self.tv_taskDesc.text;
        updatedTask.priority = self.segment_Priority.selectedSegmentIndex;
        updatedTask.dueDate = self.datePicker.date;
        updatedTask.status = self.segment_State.selectedSegmentIndex;
        
    [[TaskManager sharedManager] deleteTask:self.task];
       [[TaskManager sharedManager] addTask:updatedTask];
        
                
            [self.delegate addTaskViewController:(id)self MyTask:updatedTask];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }


@end
