page 52186501 "CRB Trans Union API Setup"
{
    PageType = List;
    ApplicationArea = Advanced;
    UsageCategory = Lists;
    SourceTable = "CRB Trans Union API Setup";
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                // Data Submission
                field(Username; Rec.Username)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Infinity Code"; Rec."Infinity Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Base URL"; Rec."Base URL")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                // Credit Reports
                field("WS - Username"; Rec."WS - Username")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("WS - Password"; Rec."WS - Password")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("WS - Infinity Code"; Rec."WS - Infinity Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("WS - Code"; Rec."WS - Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("WS - XML NS"; Rec."WS - XML NS")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("WS - URL"; Rec."WS - URL")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                // Basic Auth
                field("WS - Basic Username"; Rec."WS - Basic Username")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("WS - Basic Password"; Rec."WS - Basic Password")
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
                    // CRBTransUnionAPI: Codeunit "CRB TransUnion API";

                    XmlParameters: Text;
                begin
                    // CRBTransUnionAPI.Login(true);
                    // CRBTransUnionAPI.TestDailyPaymentInformation();
                    // CRBTransUnionAPI.TestMobileFacilityInformation();

                    // XmlParameters := Report.RunRequestPage(Report::"Ind Member Lifetime Value Rep");
                    // Message(XmlParameters);
                end;
            }
            action("Test Credit Report API Status")
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    CRBTransUnionAPI: Codeunit "CRB TransUnion CreditScore API";
                begin
                    CRBTransUnionAPI.GetServerInfo(True);
                end;
            }
        }
    }

    trigger OnNewRecord(xRec: Boolean)
    var
        CRBTransUnionTable: Record "CRB Trans Union API Setup";
    begin
        IF CRBTransUnionTable.FindFirst() then begin
            Error('Only one record is allowed in this table!');
        end;
    end;

    trigger OnInsertRecord(xRec: Boolean): Boolean
    begin
        Rec.Validate(Username);
        Rec.Validate(Password);
        Rec.Validate("Base URL");
        Rec.Validate("Infinity Code");

        Rec.Validate("WS - Username");
        Rec.Validate("WS - Password");
        Rec.Validate("WS - Infinity Code");
        Rec.Validate("WS - Code");
        Rec.Validate("WS - URL");
        Rec.Validate("WS - XML NS");

        Rec.Validate("WS - Basic Username");
        Rec.Validate("WS - Basic Password");

        exit(true)
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Validate(Username);
        Rec.Validate(Password);
        Rec.Validate("Base URL");
        Rec.Validate("Infinity Code");

        Rec.Validate("WS - Username");
        Rec.Validate("WS - Password");
        Rec.Validate("WS - Infinity Code");
        Rec.Validate("WS - Code");
        Rec.Validate("WS - URL");
        Rec.Validate("WS - XML NS");

        Rec.Validate("WS - Basic Username");
        Rec.Validate("WS - Basic Password");

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