# TODO List App (Objective-C)

A simple yet powerful TODO list application built with Objective-C to help you organize and manage your daily tasks efficiently. Designed for iOS, the app features task creation, editing, status tracking, searching, filtering, and local data persistence.

---
## Demo
https://github.com/user-attachments/assets/cb833b4e-4add-4ff2-9cdc-bf97f0184010

## Features

### Add a New Task

* Create tasks with:

  * Task name
  * Description
  * Priority level (High / Medium / Low)
* Automatic creation date assignment
* Unique priority-based icon for easy visual identification

### View Tasks

* Browse a clean list of all tasks
* View detailed task information including name, description, priority, and creation date

### Edit Tasks

* Modify any task details
* Confirmation prompt before saving edits to avoid accidental changes

### Delete Tasks

* Remove unwanted tasks from the list with ease

### Change Task Status

* Track progress with three status stages:

  * **To-Do**
  * **In Progress** (once moved here, cannot revert to To-Do)
  * **Done** (once marked done, cannot revert to In Progress)

### Search Tasks

* Quickly find tasks by name
* User-friendly message shown if no matches are found

### Filter Tasks

* Use segmented control to filter and view tasks by:

  * All tasks
  * To-Do
  * In Progress
  * Done
  * Priority (High, Medium, Low — displayed in separate sections)

### Local Storage

* All task data and changes are stored locally on the device using **NSUserDefaults** to ensure data persistence between app launches

---

## Technology & Tools

* **Objective-C** — Core language for iOS development
* **UIKit** — For building the app UI components
* **NSUserDefaults** — Local data persistence for storing tasks
* **Storyboards** — For designing UI and navigation flow

---

## Contact

Created by [Kerolos Emad](https://github.com/kemad97). Feel free to open issues or submit pull requests!

