page 52186564  "Company Vehicles list"
{
    PageType = List;
    SourceTable = "Company Vehicles";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    CardPageId = "Motor Vehicle Card";
    DeleteAllowed = False;
    Editable = True;
    //SourceTableView = where(Status = CONST(Open));

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
                    NoSeriesMgt.InitSeries('VEHICLE', XValue, 0D, RecordID, Rec."No. Series");
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
                field("Date of Purchase"; Rec."Purchase Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Registartion"; Rec."Created at")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vehicle Status"; Rec."Vehicle Status")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Movement Status"; Rec."Movement Status")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                }
            }
        }
    }

    actions
    {
    }
    var
    NoSeriesMgt: Codeunit NoSeriesManagement;
    XValue: code[50];
    RecordID: Code[50];
    Vehicle: Record "Company Vehicles";
}

