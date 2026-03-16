page 52187344 "Closed vehicles"
{
    ApplicationArea = All;
    Caption = 'Closed vehicles';
    PageType = List;
    SourceTable = "Company Vehicles";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    CardPageId = "Closed Vehicles Card";
    SourceTableView = where(Status = const(Closed));
    
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    trigger OnValidate() begin
                    // NoSeriesMgt.InitSeries('VEHICLE', XValue, 0D, RecordID, Rec."No. Series");

                    RecordID := NoSeriesMgt.GetNextNo('VEHICLE');

                    Vehicle."No." := RecordID;
                    end;
                }
                field("Type of Vehicle"; Rec."Type of Vehicle")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vehicle Make"; Rec."Vehicle Make")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
                field("Vehicle Description"; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vehicle Status"; Rec."Vehicle Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
    var
    NoSeriesMgt: Codeunit "No. Series";
    XValue: code[50];
    RecordID: Code[50];
    Vehicle: Record "Company Vehicles";
}



