page 52187077 "User Creation Request List"
{
    CardPageID = "User Creation Request Card";
    ApplicationArea = All;
    Caption = 'User Creation Request';
    PageType = List;
    SourceTable = "User Creation Requests";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Departments; Rec.Departments)
                {
                    ToolTip = 'Specifies the value of the Departments field.';
                }
                field("New Email"; Rec."Contact Email")
                {
                    ToolTip = 'Specifies the value of the NewEmail field.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the RequestDate field.';
                }
                field("New Username"; Rec."User name")
                {
                    ToolTip = 'Specifies the value of the NewUsername field.';
                }
                field("Request ID"; Rec."Request ID")
                {
                    ToolTip = 'Specifies the value of the RequestID field.';
                }
                field("Requester User ID"; Rec."Requester User ID")
                {
                    ToolTip = 'Specifies the value of the RequesterUserID field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field';
                }
            }
        }
    }

    var
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        RequestType: Boolean;
        LinesEditable: Boolean;
}
