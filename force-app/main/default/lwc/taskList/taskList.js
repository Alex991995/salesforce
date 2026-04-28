import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';

import getTasks from '@salesforce/apex/TaskController.getTasks';
import markDone from '@salesforce/apex/TaskController.markDone';
import Id from '@salesforce/user/Id';


export default class TaskList extends LightningElement {
  @track tasks;
  wiredTasksResult;

  @wire(getTasks, { userId: Id })
  wiredTasks(result) {
    this.wiredTasksResult = result;
    const { data, error } = result;

    if (data) {
      const tasks = this.formattedTasks(data)
      this.tasks = tasks
      console.log('ДАННЫЕ:', data);
    } else if (error) {
      console.error('ОШИБКА APEX:', error);
    }
  }

  completeTask(event) {
    const taskId = event.target.dataset.id;

    markDone({ taskId })
      .then(() => {
        refreshApex(this.wiredTasksResult)
      })
      .catch(err => {
        console.log(err)
      })
  }

  formattedTasks(data) {
    return data.map(task => ({
      ...task,
      style: task.Done__c ? 'cross-text ' : 'qq'
    }));
  }
}