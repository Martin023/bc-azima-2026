page 52186500 "CRM API Setup"
{
    PageType = List;
    ApplicationArea = Advanced;
    UsageCategory = Lists;
    SourceTable = "CRM API Setup";
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

                field("Get Token Name"; Rec."Get Token Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("App ID"; Rec."App ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Base URL"; Rec."Base URL")
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    CRMFunctions: Codeunit "CRM Functions";
                begin
                    CRMFunctions.CRMLogin(true);
                end;
            }
            action("Test Cases Lookup")
            {
                ApplicationArea = All;
                Image = Document;

                trigger OnAction()
                var
                    CRMFunctions: Codeunit "CRM Functions";
                    ResponseData: JsonToken;
                    ResponseDataTxt: Text;
                begin
                    ResponseData := CRMFunctions.CRMGetCaseDetails('crmcase29');
                    ResponseData.WriteTo(ResponseDataTxt);
                    Message(ResponseDataTxt);
                end;
            }

            action("Test Parcels Lookup")
            {
                ApplicationArea = All;
                Image = PostMail;

                trigger OnAction()
                var
                    CRMFunctions: Codeunit "CRM Functions";
                    ResponseData: JsonToken;
                    ResponseDataTxt: Text;
                begin
                    ResponseData := CRMFunctions.CRMGetParcelDetails('CRMPR1');
                    ResponseData.WriteTo(ResponseDataTxt);
                    Message(ResponseDataTxt);
                end;
            }
            action("Test Member Application Update")
            {
                ApplicationArea = All;
                Image = User;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_MEMBER_APPLICATION_UPDATE');
                end;
            }
            action("Test Loan Application Update")
            {
                ApplicationArea = All;
                Image = Loaner;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_LOAN_APPLICATION_UPDATE');
                end;
            }
            action("Test Claim Application Update")
            {
                ApplicationArea = All;
                Image = Users;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_CLAIM_APPLICATION_UPDATE');
                end;
            }
            action("Test Variation Update")
            {
                ApplicationArea = All;
                Image = TransferOrder;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_VARIATION_REQUEST_UPDATE');
                end;
            }
            action("Test Share Transfer Update")
            {
                ApplicationArea = All;
                Image = TransferFunds;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_SHARE_TRANSFER_UPDATE');
                end;
            }
            action("Test Member Account Update")
            {
                ApplicationArea = All;
                Image = UserInterface;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_MEMBER_ACCOUNT_UPDATE');
                end;
            }
            action("Test Member Edit Update")
            {
                ApplicationArea = All;
                Image = EditCustomer;

                trigger OnAction()
                var
                    CRMIntegration: Codeunit "CRM Integration";
                begin
                    CRMIntegration.HandleRequest('TEST_CRM_MEMBER_EDIT_UPDATE');
                end;
            }
        }
    }

    trigger OnNewRecord(xRec: Boolean)
    var
        CRMAPITable: Record "CRM API Setup";
    begin
        IF CRMAPITable.FindFirst() then begin
            Error('Only one record is allowed in this table!');
        end;
    end;

    trigger OnInsertRecord(xRec: Boolean): Boolean
    begin
        Rec.Validate("Get Token Name");
        Rec.Validate("App ID");
        Rec.Validate("Base URL");

        exit(true)
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Validate("Get Token Name");
        Rec.Validate("App ID");
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