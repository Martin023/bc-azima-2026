namespace AzimaBC.AzimaBC;
using System.Security.AccessControl;

page 52185457 "Sales Route Plan Card"
{
    ApplicationArea = All;
    Caption = 'Sales Route Plan Card';
    PageType = Card;
    SourceTable = "Sales Route Plans";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Sales Representative"; Rec."Sales Representative")
                {
                    ApplicationArea = All;
                }
                field("Route Date"; Rec."Route Date")
                {
                    ToolTip = 'Specifies the value of the Route Date field.', Comment = '%';
                }
                field(Target; Rec.Target)
                {
                    Multiline = true;
                    ToolTip = 'Specifies the value of the Target field.', Comment = '%';
                }
                field("Place to visit"; Rec."Place to visit")
                {
                    ToolTip = 'Specifies the value of the Place to visit field.', Comment = '%';
                }
                field(Achievements; Rec.Achievements)
                {
                    ToolTip = 'Specifies the value of the Achievements field.', Comment = '%';
                }
                field(Leads; Rec.Leads)
                {
                    ToolTip = 'Specifies the value of the Leads field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(CreatedBy; CreatedBy)
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
            part(PartName; "Sales Leads Lines")
            {
                caption = 'Sales Leads Lines';
                SubPageLink = "Header No" = field(No);
                ApplicationArea = Basic, Suite;
            }
            part(PartName1; "Route Achievements List")
            {
                caption = 'Route Achievements List';
                SubPageLink = "Header No" = field(No);
                ApplicationArea = Basic, Suite;
            }
        }

    }
    actions
    {

    }

    trigger OnAfterGetCurrrecord()
    begin
        CreatedBy := Getusername(rec.SystemCreatedBy);
        //ModifiedBy := Getusername(rec.SystemModifiedBy);
    end;

    var
        CreatedBy: code[40];
        ModifiedBy: code[40];

        Users: Record User;

    procedure GetUserName(UserSecurityID: Guid): Text;
    begin
        if Users.Get(UserSecurityID) then
            exit(Users."User Name");
    end;
}
