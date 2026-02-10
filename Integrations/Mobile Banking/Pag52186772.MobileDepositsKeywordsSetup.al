page 52186772 "Mobile Deposits Keywords Setup"
{
    ApplicationArea = All;
    Caption = 'Mobile Deposits Keywords Setup';
    PageType = List;
    SourceTable = "Mobile Deposits Keywords Setup";
    UsageCategory = Administration;
    
    DelayedInsert = true;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Keyword; Rec.Keyword)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Keyword field.', Comment = '%';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Code field.', Comment = '%';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Description field.', Comment = '%';
                }
                field("Product Class Type"; Rec."Product Class Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Description field.', Comment = '%';
                }
                field("Member Identifier Type"; Rec."Member Identifier Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Identifier Type field.', Comment = '%';
                }
                field("Member Identifier Position"; Rec."Member Identifier Position")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Identifier Position field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created At"; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Updated By field.', Comment = '%';
                }
                field("Updated At"; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
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
