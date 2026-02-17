table 52185542 "HR Leave Planner Header"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Leave Planner Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(2; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;
        }
        field(3; "No series"; Code[30])
        {
        }
        field(4; Picture; BLOB)
        {
        }
        field(5; "Document Date"; Date)
        {
        }
        field(6; HOD; Text[30])
        {
        }
        field(7; Year; Integer)
        {
        }
        field(8; "User ID"; Code[50])
        {
        }
        field(9; "Employee No"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(10; Supervisor; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(11; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                /*
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",1);
                DimVal.SETRANGE(DimVal.Code,"Global Dimension 1 Code");
                 IF DimVal.FIND('-') THEN
                    "Function Name":=DimVal.Name;
                 UpdateLines;
                 */

            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

                /*DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 2 Code");
                 IF DimVal.FIND('-') THEN
                    "Budget Center Name":=DimVal.Name ;
                UpdateLines
                */

            end;
        }
        field(15; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                /*
                DimVal.RESET;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 3 Code");
                 IF DimVal.FIND('-') THEN
                    Dim3:=DimVal.Name
                */

            end;
        }
        field(16; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                /*
                DimVal.RESET;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 4 Code");
                 IF DimVal.FIND('-') THEN
                    Dim4:=DimVal.Name
                  */

            end;
        }
        field(17; "Job Description"; Text[100])
        {
        }
        field(18; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Store Requisition,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval,Disciplinary Approvals,Activity Approval,Exit Approval,Medical Claim Approval,Jv,BackToOffice ,Training Needs,EmpTransfer,LeavePlanner';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs",EmpTransfer,LeavePlanner;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
        //No. Series
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Planner Nos.");
            No := NoSeriesMgt.GetNextNo(HRSetup."Leave Planner Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Leave Planner Nos.", xRec."No series", 0D, No, "No series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        HREmp: Record "HR Succession Job Rotation";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        // SMTP: Codeunit "SMTP Mail";
        LeaveGjline: Record "HR Leave Journal Line";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRJournalBatch: Record "HR Leave Journal Batch";
        DimVal: Record "Dimension Value";
}

