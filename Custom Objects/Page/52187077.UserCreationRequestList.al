page 52187056 "User Reactivation List"
{
    CardPageID = "User Reactivation Card";
    ApplicationArea = All;
    Caption = 'User Reactivation List';
    PageType = List;
    SourceTable = "User Termination";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Departments; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Departments field.';
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
                field("Date Captured"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Date Captured field';
                }
                field(Activate; Rec.Activate)
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
