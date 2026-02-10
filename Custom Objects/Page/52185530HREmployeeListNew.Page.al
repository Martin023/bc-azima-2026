page 52185530 "HR Employee List - New1"
{
    Caption='New Hr Employees List ';
    CardPageID = "HR Employee Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Employees";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(New));
    
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control10)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = TRUE;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "HR Employees Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Notches")
            {
                ApplicationArea = Basic;
                Caption = 'Import Notches';
                ////RunObject = XMLport XMLport50051;
            }
            action("Import Notch Transactions")
            {
                ApplicationArea = Basic;
                Caption = 'Import Notch Transactions';
                ////RunObject = XMLport XMLport50061;
            }
            action("Import Payroll Variations")
            {
                ApplicationArea = Basic;
                Caption = 'Import Payroll Variations';
                ////RunObject = XMLport "Checkoff Buffer";
            }
            action("Import Employee Trans")
            {
                ApplicationArea = Basic;
                Caption = 'Import Employee Trans';
                ////RunObject = XMLport XMLport50060;
            }
            action(Abscence)
            {
                ApplicationArea = Basic;
                Caption = 'Abscence';
                Image = Absence;
                Promoted = true;
                RunObject = Page "Employee Absences";
                RunPageLink = "Employee No." = FIELD("No.");
                Visible = false;
            }
            action(Lateness)
            {
                ApplicationArea = Basic;
                Caption = 'Lateness';
                Image = AbsenceCalendar;
                Promoted = true;
                RunObject = Page prLatenessLedger;
                RunPageLink = "Employee Code" = FIELD("No.");
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DepName := '';
        DValues.Reset;
        DValues.SetRange(DValues.Code, Rec."Department Code");
        if DValues.Find('-') then
            DepName := DValues.Name;

        BankName := '';
        Banks.Reset;
        Banks.SetRange(Banks."Branch Code", Rec."Main Bank");
        Banks.SetRange(Banks."Branch Name", Rec."Branch Bank");
        if Banks.Find('-') then
            BankName := Banks."Bank Name";
    end;

    trigger OnOpenPage()
    begin
        //OnViewCurrRec();
        if (DepCode <> '') then
            Rec.SetFilter("Department Code", ' = %1', DepCode);
        if (OfficeCode <> '') then
            Rec.SetFilter(Office, ' = %1', OfficeCode);
    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];
        DepName: Text[100];
        BankName: Text[200];
        DValues: Record "Dimension Value";
        Banks: Record "PR Bank Branches";

    //[Scope('OnPrem')]
    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;

    //[Scope('OnPrem')]
    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}

