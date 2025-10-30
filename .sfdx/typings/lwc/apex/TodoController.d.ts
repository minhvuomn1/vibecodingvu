declare module "@salesforce/apex/TodoController.getTodos" {
  export default function getTodos(): Promise<any>;
}
declare module "@salesforce/apex/TodoController.markComplete" {
  export default function markComplete(param: {recordId: any}): Promise<any>;
}
