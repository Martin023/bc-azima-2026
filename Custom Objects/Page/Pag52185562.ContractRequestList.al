page 52185562 "Contract Request List"
{
    ApplicationArea = All;
    Caption = 'Contract Request List';
    PageType = List;
    SourceTable = "Contract Request";
    UsageCategory = Lists;
    CardPageID = "Contract Request Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Party to The Contract"; Rec."Party to The Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party to The Contract field.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Type of Service"; Rec."Type of Service")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type of Service field.';
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contractor Type field.';
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contractor Name field.';
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Description field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Current Department", UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}