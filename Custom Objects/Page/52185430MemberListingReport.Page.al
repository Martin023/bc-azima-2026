page 52185430 "Member Listing Report"
{
    PageType = List;
    SourceTable = "Member Listing";
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                // field(Salutation; Rec.Salutation)
                // {
                //     ApplicationArea = All;
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Member Age"; Rec."Member Age")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Transactional Mobile Number"; Rec."Transactional Mobile Number")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                // field("P.I.N Number"; Rec."P.I.N Number")
                // {
                //     ApplicationArea = All;
                // }
                // field("Primary Identification Type"; Rec."Primary Identification Type")
                // {
                //     ApplicationArea = All;
                // }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = All;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = All;
                }
                // field("Current Address"; Rec."Current Address")
                // {
                //     ApplicationArea = All;
                // }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                }
                // field("Employer Name"; Rec."Employer Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Work Station"; Rec."Work Station")
                // {
                //     ApplicationArea = All;
                // }
                // field(County; Rec.County)
                // {
                //     ApplicationArea = All;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Subflag; Rec.Subflag)
                {
                    ApplicationArea = All;
                }
                // field("Recruited by Type"; Rec."Recruited by Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Recruited By"; Rec."Recruited By")
                // {
                //     ApplicationArea = All;
                // }
                // field("Recruited By Name"; Rec."Recruited By Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Start Date"; Rec."Start Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("End Date"; Rec."End Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Member Class"; Rec."Member Class")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = All;
                }
                field("Readmission Date"; Rec."Readmission Date")
                {
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                // field("Branch Name"; Rec."Branch Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Delegates Zone"; Rec."Delegates Zone")
                // {
                //     ApplicationArea = All;
                // }
                // field("Risk Accont No"; Rec."Risk Accont No")
                // {
                //     ApplicationArea = All;
                // }
                // field("Risk Balance"; Rec."Risk Balance")
                // {
                //     ApplicationArea = All;
                // }
                // field("Risk Monthly Contribution"; Rec."Risk Monthly Contribution")
                // {
                //     ApplicationArea = All;
                // }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    ApplicationArea = All;
                }
                field("FOSA Account Status"; Rec."FOSA Account Status")
                {
                    ApplicationArea = All;
                }
                field("FOSA Balance"; Rec."FOSA Balance")
                {
                    ApplicationArea = All;
                }
                // field("Business Deposits"; Rec."Business Deposits")
                // {
                //     ApplicationArea = All;
                // }
                field("BOSA Deposit Account No"; Rec."BOSA Deposit Account No")
                {
                    ApplicationArea = All;
                }
                field("BOSA Deposit Balance"; Rec."BOSA Deposit Balance")
                {
                    ApplicationArea = All;
                }
                field("BOSA Deposit Account Status"; Rec."BOSA Deposit Account Status")
                {
                    ApplicationArea = All;
                }
                // field("BOSA Deposits Monthly Contr."; Rec."BOSA Deposits Monthly Contr.")
                // {
                //     ApplicationArea = All;
                // }
                // field("BBF Account No"; Rec."BBF Account No")
                // {
                //     ApplicationArea = All;
                // }
                // field("BBF Balance"; Rec."BBF Balance")
                // {
                //     ApplicationArea = All;
                // }
                // field("BBF Monthly Contribution"; Rec."BBF Monthly Contribution")
                // {
                //     ApplicationArea = All;
                // }
                // field("BBF Account Status"; Rec."BBF Account Status")
                // {
                //     ApplicationArea = All;
                // }
                // field("Transfer Share Capital"; Rec."Transfer Share Capital")
                // {
                //     ApplicationArea = All;
                // }
                field("Share Capital Account No"; Rec."Share Capital Account No")
                {
                    ApplicationArea = All;
                }
                // field("Share Capital Ac Status"; Rec."Share Capital Ac Status")
                // {
                //     ApplicationArea = All;
                // }
                field("Share Capital Balance"; Rec."Share Capital Balance")
                {
                    ApplicationArea = All;
                }
                // field("Trasferred Share Cap No"; Rec."Trasferred Share Cap No")
                // {
                //     ApplicationArea = All;
                // }
                // field("Trasferred Share Cap Bal"; Rec."Trasferred Share Cap Bal")
                // {
                //     ApplicationArea = All;
                // }
                // field("Trasferred Share Cap Status"; Rec."Trasferred Share Cap Status")
                // {
                //     ApplicationArea = All;
                // }
                // field(Prorata; Rec.Prorata)
                // {
                //     ApplicationArea = All;
                // }
                field(LoanBal; Rec.LoanBal)
                {
                    ApplicationArea = All;
                }
                // field("Contribution Effective Date"; Rec."Contribution Effective Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }

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
                    BulkProcessing: Codeunit "Bulk Processing";
                    Members: Record Members;
                    MemberListing: Record "Member Listing";

                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Processing ...';
                    diaProgress: Dialog;
                    intProgress: Integer;

                    BatchNo: Code[20];

                    FctBox: Record "Member FactBox";
                begin


                    if Confirm('Do you want to run member listing background task?') then begin
                        Members.Reset();

                        Codeunit.Run(Codeunit::"Member List Job Queue Manager", Members);

                        // if Codeunit.Run(Codeunit::"Member List Job Queue Manager", Members) then begin
                        //     Message('Member Listing Process initiated successfully. It will run in the background');
                        // end else begin
                        //     Error('Unable to initiate Member Listing Process at the moment!');
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
                    JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Member Listing Job", Codeunit::"Member List Job Queue Manager");
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

            action("Generate Report")
            {
                Caption = 'Generate Report';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Enabled = false;
                Image = Process;
                trigger OnAction()
                var
                    BulkProcessing: Codeunit "Bulk Processing";
                    Members: Record Members;
                    MemberListing: Record "Member Listing";

                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Processing ...';
                    diaProgress: Dialog;
                    intProgress: Integer;

                    BatchNo: Code[20];

                    FctBox: Record "Member FactBox";
                begin
                    MemberListing.Reset();
                    MemberListing.DeleteAll();

                    BatchNo := Format(CurrentDateTime);
                    Members.Reset();
                    if Members.FindSet() then begin
                        intProgressTotal := Members.Count;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN('Processing ... ' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);

                        repeat
                            intProgressI += 1;
                            if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            end;
                            BulkProcessing.MemberListing(Members, BatchNo);
                        until Members.Next() = 0;

                        diaProgress.Close();
                    end;


                end;
            }
        }
    }
}
