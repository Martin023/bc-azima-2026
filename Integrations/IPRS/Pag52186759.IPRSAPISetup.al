page 52186759 "IPRS API Setup"
{
    Caption = 'IPRS API Setup';
    PageType = List;
    ApplicationArea = Advanced;
    UsageCategory = Administration;
    SourceTable = "IPRS API Setup";
    InsertAllowed = true;
    Editable = true;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field("Base URL"; Rec."Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Base URL field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By field.', Comment = '%';
                }
                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified At field.', Comment = '%';
                }
            }
        }
    }

    trigger OnNewRecord(xRec: Boolean)
    var
        CRMAPITable: Record "IPRS API Setup";
    begin
        IF CRMAPITable.FindFirst() then begin
            Error('Only one record is allowed in this table!');
        end;
    end;

    trigger OnInsertRecord(xRec: Boolean): Boolean
    begin
        Rec.Validate("Base URL");

        exit(true)
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Validate("Base URL");

        exit(true)
    end;

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
