page 52186510 "CRM Originations Setup"
{
    ApplicationArea = All;
    Caption = 'CRM Originations Setup';
    PageType = List;
    SourceTable = "CRM Originations Setup";
    UsageCategory = Administration;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("CRM Origination"; Rec."CRM Origination")
                {
                    ToolTip = 'Specifies the value of the CRM Origination field.';
                }
                field("Landing Department"; Rec."Landing Department")
                {
                    ToolTip = 'Specifies the value of the Landing Department field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                    Editable = false;
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
