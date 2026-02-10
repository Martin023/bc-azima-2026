page 52186639 "BC API Logs List"
{
    ApplicationArea = All;
    Caption = 'BC API Logs List';
    PageType = List;
    SourceTable = "BC API Logs";
    UsageCategory = Administration;
    CardPageId = "BC API Log Card";

    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field("Large Text"; Rec."Large Text")
                {
                    ToolTip = 'Specifies the value of the Large Text field.';
                }
                field(Miscellaneous; Rec.Miscellaneous)
                {
                    ToolTip = 'Specifies the value of the Miscellaneous field.';
                }
                field("Request Data"; Rec."Request Data")
                {
                    ToolTip = 'Specifies the value of the Request Data field.';
                }
                field("Request Headers"; Rec."Request Headers")
                {
                    ToolTip = 'Specifies the value of the Request Headers field.';
                }
                field("Request URL"; Rec."Request URL")
                {
                    ToolTip = 'Specifies the value of the Request URL field.';
                }
                field("Response Data"; Rec."Response Data")
                {
                    ToolTip = 'Specifies the value of the Response Data field.';
                }
                field("Response Headers"; Rec."Response Headers")
                {
                    ToolTip = 'Specifies the value of the Response Headers field.';
                }
                field("Response Status Code"; Rec."Response Status Code")
                {
                    ToolTip = 'Specifies the value of the Response Status Code field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
            }
        }
    }

    // -------------------------------------------------------------------------------------------------------------------------------------------
    trigger OnOpenPage()
    begin
        FnRestrictAccess();
    end;

    procedure FnRestrictAccess()
    var
        StatusPermission: Record "Status Change Permissions.";
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do not have permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("Edit Setup", true);
        StatusPermission.SetRange("Function Extended", StatusPermission."Function Extended"::Administrator);

        if not StatusPermission.Find('-') then begin
            // CurrPage.Editable := false;
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end
        // else begin
        //     CurrPage.Editable := true;
        // end;
    end;
}
