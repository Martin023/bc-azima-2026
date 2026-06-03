namespace AzimaBC.AzimaBC;

page 52187412 "Portfolio Management Lines"
{
    ApplicationArea = All;
    Caption = 'Portfolio Management Lines';
    PageType = ListPart;
    SourceTable = "Portfolio Manager Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Member Class"; Rec."Member Class")
                {
                    ToolTip = 'Specifies the value of the Member Class field.', Comment = '%';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.', Comment = '%';
                }
                field("PF Number"; Rec."PF Number")
                {
                    ToolTip = 'Specifies the value of the PF Number field.', Comment = '%';
                }
                field(Workstation; Rec.Workstation)
                {
                    ToolTip = 'Specifies the value of the Workstation field.', Comment = '%';
                }
                field("Workstation Name"; Rec."Workstation Name")
                {
                    ToolTip = 'Specifies the value of the Workstation Name field.', Comment = '%';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Phone No field.', Comment = '%';
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ToolTip = 'Specifies the value of the Primary Identification field.', Comment = '%';
                }
                field("Sales Rep Type"; Rec."Sales Rep Type")
                {
                    ToolTip = 'Specifies the value of the Sales Rep Type field.', Comment = '%';
                }
                field("Sales Rep code"; Rec."Sales Rep code")
                {
                    ToolTip = 'Specifies the value of the Sales Rep Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Sub Status"; Rec."Sub Status")
                {
                    ToolTip = 'Specifies the value of the Sub Status field.', Comment = '%';
                }
            }
        }
    }
}
