page 52185560 "Perfection File Actions"
{
    ApplicationArea = All;
    Caption = 'Perfection File Actions';
    PageType = ListPart;
    SourceTable = "Perfection File Action";
    Editable = true;
    DeleteAllowed = false;
    InsertAllowed = true;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Perfection No."; Rec."Perfection No.")
                {
                    ToolTip = 'Specifies the value of the Perfection No. field.';
                    Editable = false;
                }
                // field("No."; Rec."No.")
                // {
                //     ToolTip = 'Specifies the value of the No. field.';
                //     Editable = false;
                // }
                
                field("Action On File"; Rec."Action On File")
                {
                    Caption = 'Perfection Stage';
                    ToolTip = 'Specifies the value of the Action On File field.';
                    Editable = False;
                }
                
                field("Start Date"; Rec."Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Date field.';
                    Editable = false;
                }
                field( "End Date"; Rec."End Date")
                {
                    Caption = 'End Date';
                    trigger OnValidate()
                     begin
                        Duration := '';

                        if (Rec."Date" <> 0D) then
                            //Duration := HRCodeunit.DetermineAge(Rec."Date", Rec."End Date");
                            Rec.TAT := HRCodeunit.DetermineAge(Rec."Date", Rec."End Date");
                    end;
                    //TAT := '';

                    // begin
                    //     Rec.TAT := Rec."End Date" - Rec.Date
                    // end;
                }
                field(TAT; Rec.TAT)
                {
                    Caption = 'TAT';
                    Editable = false;
                }
                field("TAT Sent"; Rec."TAT Sent")
                {
                    Caption = 'TAT Sent';
                    ToolTip = 'Specifies the value of the TAT Sent field.';
                    Editable = false;
                }

                field("Captured By"; Rec."Captured By")
                {
                    Caption = 'Captured By';
                    ToolTip = 'Specifies the value of the Captured By field.';
                    Editable = false;
                }
                field("Created At"; Rec."Captured On")
                {
                    Caption = 'Captured At';
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = False;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Duration := '';

        if (Rec."Date" <> 0D) then
            Duration := HRCodeunit.DetermineAge(Rec."Date", Rec."End Date");
    end;


    var
    Duration: Text[100];
    HRCodeunit: Codeunit "HR Codeunit";
}
