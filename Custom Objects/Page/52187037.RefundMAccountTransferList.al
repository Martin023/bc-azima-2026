page 52187037 "Bulk Account Refunds"
{
    CardPageID = "Bulk Refunds Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    Caption = 'Bulk Account Refunds List ';

    SourceTable = "Refund,Account Transfer Header";
    UsageCategory = Lists;
    SourceTableView = WHERE("Upload Option" = filter("Single Line"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Refund Type"; Rec."Refund Type") { }
                field("Entered By"; Rec."Entered By") { }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }

                field("Time Entered"; Rec."Time Entered") { Editable = false; }
                field("Posting date"; Rec."Posting date") { }
                field("Time Posted"; Rec."Time Posted") { }
                field(Description; Rec.Description) { }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ToolTip = 'Specifies the value of the Scheduled Amount field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserSetup.get(UserID) then begin
            rec.SetRange("Responsibility Center", UserSetup."Responsibility Centre");
        end;
        // else
        //     Error('Kindly ensure you have been assigned a Responsibility Centre');
    end;

    var
        UserSetup: record "User Setup";
}
