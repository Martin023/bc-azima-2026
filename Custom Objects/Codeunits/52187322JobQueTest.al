// codeunit 52187322 JobQueTetst
// {
//     TableNo = "Job Queue Entry";
//     trigger OnRun()
//     begin
//         ScheduleMultipleTasks();
//         StartJobQueue();
//     end;

//     procedure ScheduleTask(TaskCodeunitId: Integer; JobQueueName: Text[50])
//     var
//         JobQueueEntry: Record "Job Queue Entry";
//     begin
//         JobQueueEntry.Init();
//         // JobQueueEntry."Job Queue ID" := JobQueueName;
//         JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
//         JobQueueEntry."Object ID to Run" := TaskCodeunitId;
//         JobQueueEntry.Insert(true);
//         // JobQueueEntry.SetJobQueueStatus(JobQueueEntry."Job Queue Status"::Ready);
//     end;

//     procedure ScheduleMultipleTasks()
//     var
//         i: Integer;
//         JobQueueName: Text[50];
//         JobQueueEntry: Record "Job Queue Entry";
//     begin
//         for i := 1 to 50 do begin
//             JobQueueName := 'JobQueue' + Format(i);
//             ScheduleTask(Codeunit::TaskCodeunit, JobQueueName);
//         end;
//     end;

//     procedure StartJobQueue()
//     var
//         // JobQueue: Record job qu;
//     begin
        
//     end;
// }