page 52187093 "User Termination Requests List"
{
    ApplicationArea = All;
    Caption = 'User Termination Request';
    PageType = List;
    SourceTable = "User Termination";
    UsageCategory = Lists;
    CardPageId = "User Termination Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(RequestDate; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the RequestDate field.';
                }
                field(RequestID; Rec."Request ID")
                {
                    ToolTip = 'Specifies the value of the RequestID field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(TargetUserID; Rec."Target User ID")
                {
                    ToolTip = 'Specifies the value of the TargetUserID field.';
                }
                field(Terminate; Rec.Terminate)
                {
                    ToolTip = 'Specifies the value of the TargetUserID field.';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.';
                }
            }
        }
    }
}
