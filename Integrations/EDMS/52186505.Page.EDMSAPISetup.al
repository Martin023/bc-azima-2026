page 52186505 "EDMS API Setup"
{
    PageType = List;
    ApplicationArea = Advanced;
    UsageCategory = Administration;
    SourceTable = "EDMS API Setup";
    InsertAllowed = true;
    Editable = true;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Base URL"; Rec."Base URL")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Source IP"; Rec."Source IP")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Encrypt Key"; Rec."Encrypt Key")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Username"; Rec."Username")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Passcode"; Rec."Passcode")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Web API POST URL"; Rec."Web API POST URL")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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

    actions
    {
        area(Processing)
        {
            action("Test API Login")
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    EDMSIntegration: Codeunit "EDMS Functions";
                begin
                    EDMSIntegration.EDMSLogin(true);
                end;
            }
        }
    }

    trigger OnNewRecord(xRec: Boolean)
    var
        CRMAPITable: Record "EDMS API Setup";
    begin
        IF CRMAPITable.FindFirst() then begin
            Error('Only one record is allowed in this table!');
        end;
    end;

    trigger OnInsertRecord(xRec: Boolean): Boolean
    begin
        Rec.Validate("Base URL");
        Rec.Validate("Source IP");
        Rec.Validate("Encrypt Key");
        Rec.Validate(Username);
        Rec.Validate(Passcode);

        exit(true)
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Validate("Base URL");
        Rec.Validate("Source IP");
        Rec.Validate("Encrypt Key");
        Rec.Validate(Username);
        Rec.Validate(Passcode);

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