page 52186561 "CRB Metropol API Setup"
{
    PageType = List;
    ApplicationArea = Advanced;
    UsageCategory = Lists;
    SourceTable = "CRB Metropol API Setup";
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

                field("The Proxy"; Rec."The Proxy")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                
                field("Public Key"; Rec."Public Key")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Private Key"; Rec."Private Key")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Base URL"; Rec."Base URL")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Port; Rec.Port)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("API Version"; Rec."API Version")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Base URL - DS"; Rec."Base URL - DS")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Public Key - DS"; Rec."Public Key - DS")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Private Key - DS"; Rec."Private Key - DS")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("API Version - DS"; Rec."API Version - DS")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Port - DS"; Rec."Port - DS")
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
            action("Test API Login - Data Submission")
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    CRBMetropolAPI: Codeunit "CRB Metropol API";
                begin
                    // CRBMetropolAPI.Login(true);
                    CRBMetropolAPI.LoginDataSubmission(true);
                end;
            }
            action("Test API Login - Credit Score")
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    CRBMetropolAPI: Codeunit "CRB Metropol API";
                begin
                    // CRBMetropolAPI.Login(true);
                    CRBMetropolAPI.ReportType4(
                        true,
                        "CRB Metropol Report Types"::"PDF Credit Report",
                        '',
                        1000000,
                        "CRB Metropol Identity Types"::"National ID",
                        "CRB Metropol Report Reasons"::"New credit application"
                    );
                end;
            }
            // action("Test Submissions")
            // {
            //     ApplicationArea = All;
            //     Image = Action;

            //     trigger OnAction()
            //     var
            //         CRBMetropolAPI: Codeunit "CRB Metropol API";
            //     begin
            //         // CRBMetropolAPI.Login(true);
            //         CRBMetropolAPI.Run();

            //         Message('Test Submissions Success');
            //     end;
            // }
        }
    }

    trigger OnNewRecord(xRec: Boolean)
    var
        CRBMetropolTable: Record "CRB Metropol API Setup";
    begin
        IF CRBMetropolTable.FindFirst() then begin
            Error('Only one record is allowed in this table!');
        end;
    end;

    trigger OnInsertRecord(xRec: Boolean): Boolean
    begin
        Rec.Validate("Public Key");
        Rec.Validate("Private Key");
        Rec.Validate("Base URL");
        Rec.Validate("API Version");

        Rec.Validate("Public Key - DS");
        Rec.Validate("Private Key - DS");
        Rec.Validate("API Version - DS");

        Rec.Validate(Port);

        exit(true)
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Validate("Public Key");
        Rec.Validate("Private Key");
        Rec.Validate("Base URL");
        Rec.Validate("API Version");

        Rec.Validate("Public Key - DS");
        Rec.Validate("Private Key - DS");
        Rec.Validate("API Version - DS");

        Rec.Validate(Port);

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