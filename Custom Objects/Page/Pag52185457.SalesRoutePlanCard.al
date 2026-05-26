namespace AzimaBC.AzimaBC;

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
                field(Desription; Rec.Desription)
                {
                    ToolTip = 'Specifies the value of the Desription field.', Comment = '%';
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
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
            part(PartName; "Sales Leads Lines")
            {
                caption = 'Sales Leads Lines';
                SubPageLink = "Header No" = field(No);
                ApplicationArea = Basic, Suite;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Route Achievements")
            {
                ApplicationArea = Basic;
                Caption = 'Route Achievements';
                RunObject = Page "Route Achievements List";
            }
        }
    }
}
