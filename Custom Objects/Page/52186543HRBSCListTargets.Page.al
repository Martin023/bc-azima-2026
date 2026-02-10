page 52186543 "HR BSC List Targets1"
{
    CardPageID = "HR BSC Appraisal Header-App";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Caption = 'Employee Targets';
    PageType = List;
    SourceTable = "HR Individual Targets Header";
    SourceTableView = WHERE(Status = FILTER(Open));    
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("Finance Rating"; Rec."Finance Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Rating"; Rec."Customer Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Training Rating"; Rec."Training Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Service Rating"; Rec."Service Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."User ID" <> UserId then
            CurrPage.Close
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("User ID", UserId);
    end;
}

