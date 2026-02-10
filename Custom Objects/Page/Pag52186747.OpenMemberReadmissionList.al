namespace KENPIPE.KENPIPE;
using Microsoft.Foundation.NoSeries;
using System.Security.User;

page 52186747 "Open Member Readmission List"
{
   CardPageID = "Open Member Readmission";
    DeleteAllowed = false;
    Editable = false;
    // InsertAllowed = false;
    PageType = List;
    SourceTable = "Member Application";
    PromotedActionCategories = 'New,Process,Reports,Activities, ,Category7_caption,Category8_caption,Category9_caption,Approvals';
    SourceTableView = WHERE("Type of Application"=const(Readmission));
    // SourceTableView = WHERE("Sent Back to CRM" = CONST(false)); to Rc filters
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("CRM Application No."; Rec."CRM Application No.")
                // {

                // }
                // field("Source Aplication"; Rec."Source Aplication")
                // {

                // }
                // field("Sent Back to CRM"; Rec."Sent Back to CRM")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Sent Back to M-Smart"; Rec."Sent Back to M-Smart")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Responsible Officer"; Rec."Responsible Officer")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Supervisor ID"; Rec."Supervisor ID")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Primary Identification Type"; Rec."Primary Identification Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("P.I.N Number"; Rec."P.I.N Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Created;Rec.Created)
                {
                    
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Recruiter';
                }
                field("Recruited by Type"; Rec."Recruited by Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            // action("Simulate CRM")
            // {
            //     ApplicationArea = all;
            //     Image = Create;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     trigger OnAction()
            //     begin
            //         if CRMSimulation() then
            //             Message('Success')
            //         else
            //             Error('Failed!\Check probably you don''t have an active officer for this task');
            //     end;
            // }
        }
    }

    procedure CRMSimulation(): Boolean
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        XValue: code[50];
        RecordID: Code[50];
        SeriesSetup: Record "Credit Nos. Series";
        MemberApplication: Record "Member Application";
        GlobalFunctions: Codeunit "Global Functions";
        SubDepartments: Enum "Sub Module";
        UserSet: Record "User Setup";
        ProductFactory: Record "Product Factory";
        AutoOpenSavingAccs: Record "Savings Account Registration";
        DepartMent: Enum "Responsibility Center Enum";
    begin
        SeriesSetup.Get;
        SeriesSetup.TestField(SeriesSetup."Member Application Nos.");
        NoSeriesMgt.InitSeries(SeriesSetup."Member Application Nos.", xRec."No. Series", 0D, RecordID, Rec."No. Series");

        MemberApplication.Init();
        MemberApplication."No." := RecordID;
        NoSeriesMgt.InitSeries('MEMCRM', XValue, 0D, RecordID, Rec."No. Series");
        MemberApplication."CRM Application No." := RecordID;

        if UserSet.Get(UserId) then begin
            MemberApplication."Responsibility Center" := UserSet."Shortcut Dimension 3 Code";
        end;

        ProductFactory.SetFilter(ProductFactory.Status, '%1', ProductFactory.Status::Active);
        ProductFactory.SetFilter(ProductFactory."Auto Open Account", '%1', true);
        if ProductFactory.Find('-') then begin
            repeat
                AutoOpenSavingAccs.Init;
                AutoOpenSavingAccs."No." := MemberApplication."No.";
                AutoOpenSavingAccs.Validate(AutoOpenSavingAccs."Product Type", ProductFactory."Product ID");
                AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                AutoOpenSavingAccs.Insert;
            until ProductFactory.Next = 0;
        end;


        MemberApplication."Application Date" := Today;
        MemberApplication."Created By" := UserId;

        if UserSet.Get(UserId) then begin
            UserSet.TestField(UserSet."Global Dimension 1 Code");
            UserSet.TestField(UserSet."Global Dimension 2 Code");
            MemberApplication."Global Dimension 1 Code" := UserSet."Global Dimension 1 Code";
            MemberApplication."Global Dimension 2 Code" := UserSet."Global Dimension 2 Code";
            MemberApplication."Responsibility Center" := UserSet."Responsibility Centre";
        end else
            Error('%1 must be set up in user setup', UserId);


        if MemberApplication.Insert() then begin
            if not GlobalFunctions.AssignUserTasks(DepartMent::RECORDS, SubDepartments::"Members Applications", RecordID) then
                exit(false)
            else
                exit(true);
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        Rec.CalcFields("Responsible Officer", "Supervisor ID");

        //Rec.SetFilter("Responsible Officer", UserId);

    end;
}

