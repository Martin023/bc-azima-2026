namespace Mwanga.Mwanga;
using System.Threading;

page 52186693 "BBF/Nominee Register"
{
    ApplicationArea = All;
    Caption = 'BBF/Nominee Register';
    PageType = List;
    SourceTable = "BBF/Nominee Register";
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Deposits field.', Comment = '%';
                }
                field("Nominee Name"; Rec."Nominee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nominee Name field.', Comment = '%';
                }
                field("Identification Type"; Rec."Identification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Identification_Type field.', Comment = '%';
                }
                field("Identification Number"; Rec."Identification Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Identification_Number field.', Comment = '%';
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Relationship field.', Comment = '%';
                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocation field.', Comment = '%';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DateCaptured field.', Comment = '%';
                }
                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deceased field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Background Processing")
            {
                // Caption = 'Generate Report';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Process;
                trigger OnAction()
                var
                    NextOfKin: Record "Next of KIN";
                begin
                    if Confirm('Do you want to run BBF/Nominee listing background task?') then begin
                        NextOfKin.Reset();

                        Codeunit.Run(Codeunit::"BBF/Nominee Job Queue Manager", NextOfKin);

                        // if Codeunit.Run(Codeunit::"BBF/Nominee Job Queue Manager", NextOfKin) then begin
                        //     Message('BBF/Nominee Listing Process initiated successfully. It will run in the background');
                        // end else begin
                        //     Error('Unable to initiate BBF/Nominee Listing Process at the moment!');
                        // end;
                    end else
                        Message('Operation aborted!');
                end;
            }
            action("Check Update")
            {
                // Caption = 'Generate Report';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    JobQueueEntry: Record "Job Queue Entry";
                    JobQueEntries: page "Job Queue Entries";
                begin
                    JobQueueEntry.Reset;
                    JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"BBF/Nominee Job", Codeunit::"BBF/Nominee Job Queue Manager");
                    if JobQueueEntry.Find('-') then begin
                        repeat
                            if JobQueueEntry.Status = JobQueueEntry.Status::Error then begin
                                JobQueueEntry.Restart();
                            end;
                            if JobQueueEntry.Status = JobQueueEntry.Status::Ready then begin
                                JobQueueEntry.Restart();
                            end;
                        until JobQueueEntry.Next() = 0;
                        Message('There are ongoing Member listing generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
                    end else
                        Message('Process complete');
                end;
            }
        }
    }
}
