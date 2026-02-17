table 52186256 "HR Training Planner"
{

    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[40])
        {
            Caption = 'No';
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Training Planner Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Training Course"; Code[40])
        {
            Caption = 'Training Course';
            TableRelation = "HR Training Needs".Description where(status = filter(Approved));
            ValidateTableRelation = false;
        }
        field(3; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                Month := Date2DMY("Start Date", 2);
                Year := Date2DMY("Start Date", 3);

            end;
        }
        field(6; "Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "End Date" := CalcDate("Duration", "Start Date");
            end;
        }
        field(20; "End Date"; Date)
        {
            Editable = false;
            trigger OnValidate()
            var
                TPlanner: record "HR Training Planner";
            begin
                TPlanner.reset();
                TPlanner.SetRange("End Date", rec."End Date");
                if TPlanner.FindSet() then
                    if TPlanner."End Date" > Today then
                        Message('The Training Planner Has Expired');

            end;
        }
        field(4; "No Of Participants"; Integer)
        {
            Caption = 'No Of Participants';
        }
        field(5; "User ID"; code[40])
        {
            Caption = 'User ID';
        }
        field(3978; Month; Integer)
        {
        }
        field(3979; Year; Integer)
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(30; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Deffered';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Deffered;
            trigger OnValidate()
            begin
                if (Rec.Status = Status::Rejected) then
                    GlobalFunctions.CommentsManagement(Rec.No);
            end;
        }
        field(31; "Training Category"; Option)
        {
            OptionMembers = Individual,Organization;
        }
        field(32; "CPD Points"; integer)
        {

        }

    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Training Planner Nos.");
            No := NoSeriesMgt.GetNextNo(HRSetup."Training Planner Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Training Planner Nos.", xRec."No series", 0D, No, "No series");

            "User ID" := UserId;
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        GlobalFunctions: Codeunit "Global Functions";
}
