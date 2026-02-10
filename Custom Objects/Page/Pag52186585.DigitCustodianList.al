namespace MNS.MNS;

page 52186585 "Digit Custodian List"
{
    ApplicationArea = All;
    Caption = 'Digit Custodian List';
    PageType = List;
    SourceTable = "Digit Custodian Setup";
    SourceTableView = where("Sub Module" = filter("Member Closure"));
    UsageCategory = ReportsAndAnalysis;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Responsible Officer Code"; Rec."Responsible Officer Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Officer Code field.', Comment = '%';
                }
                field("Responsible Officer Name"; Rec."Responsible Officer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Officer Name field.', Comment = '%';
                }
                field("Responsible Officer Extension"; Rec."Responsible Officer Extension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Officer Extension field.', Comment = '%';
                }
                field("Responsible Officer Email"; Rec."Responsible Officer Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Officer Email field.', Comment = '%';
                }
                field("Digit Custodian"; Rec."Digit Custodian")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Digit Custodian field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        UpdateCustodian
    end;

    procedure UpdateCustodian()
    var
        DigCustSetup: Record "Digit Custodian Setup";

    begin
        DigCustSetup.reset;
        if DigCustSetup.FindFirst() then begin
            repeat
                DigCustSetup.Validate("Responsible Officer Code");
                DigCustSetup.modify;
            until DigCustSetup.Next = 0;
        end;
    end;
}
