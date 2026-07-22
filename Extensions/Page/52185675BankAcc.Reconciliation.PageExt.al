#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185675 pageextension52185675 extends "Bank Acc. Reconciliation"
{

    PromotedActionCategories = ',,,,EDMS';

    layout
    {
        modify(BankAccountNo)
        {
            ApplicationArea = Basic;
        }
        modify(StatementNo)
        {
            ApplicationArea = Basic;
        }
        modify(StatementDate)
        {
            ApplicationArea = Basic;
        }
        modify(BalanceLastStatement)
        {
            ApplicationArea = Basic;
            Editable = false;
        }
        modify(StatementEndingBalance)
        {
            ApplicationArea = Basic;
        }



        addafter(BankAccountNo)
        {
            // field("Reconciliation Type";"Reconciliation Type")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter(StatementEndingBalance)
        {
            field("Notes Line 1"; Rec."Notes Line 1")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 2"; Rec."Notes Line 2")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 3"; Rec."Notes Line 3")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 4"; Rec."Notes Line 4")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 5"; Rec."Notes Line 5")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 6"; Rec."Notes Line 6")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        // modify(ActionContainer1900000003)
        // {
        //     Visible = false;
        // }
        // modify("&Recon.")
        // {
        //     Visible = false;
        // }
        // modify("&Card")
        // {
        //     Visible = false;
        // }
        // modify(ActionContainer1900000004)
        // {
        //     Visible = false;
        // }
        modify("F&unctions")
        {
            Visible = True;
        }
        modify(SuggestLines)
        {
            Visible = True;
        }
        modify("Transfer to General Journal")
        {
            Visible = True;
        }
        modify("Ba&nk")
        {
            Visible = True;
        }
        modify(ImportBankStatement)
        {
            Visible = True;
        }
        modify("M&atching")
        {
            Visible = True;
        }
        modify(MatchAutomatically)
        {
            Visible = true;
        }
        modify(MatchManually)
        {
            Visible = True;
        }
        modify(RemoveMatch)
        {
            Visible = true;
        }
        modify(All)
        {
            Visible = false;
        }
        modify(NotMatched)
        {
            Visible = true;
        }
        modify("P&osting")
        {
            Visible = True;
        }
        modify("&Test Report")
        {
            Visible = false;
        }
        addafter(SuggestLines)
        {
            action(BankReconReport)
            {
                ApplicationArea = Basic;
                Caption = 'Bank Acc .Reconcilliation ReportII';
                Image = Report2;
                promoted = true;
                PromotedIsBig = true;
                PromotedCategory = process;

                trigger OnAction()
                var
                    BankRecon: record "Bank Acc. Reconciliation";
                begin
                    BankRecon.Reset();
                    BankRecon.SetRange("Bank Account No.", rec."Bank Account No.");
                    BankRecon.SetRange("Statement No.", rec."Statement No.");
                    if BankRecon.Find('-') then
                        Report.run(Report::"Bank Reconcilliation Report II", true, false, BankRecon);
                end;
            }

            action(BankReconRep)
            {
                ApplicationArea = Basic;
                Caption = 'Bank Reconcilliation Report';
                Image = Report2;
                promoted = true;
                PromotedIsBig = true;
                PromotedCategory = process;

                trigger OnAction()
                var
                    BankRecon: record "Bank Acc. Reconciliation";
                begin
                    BankRecon.Reset();
                    BankRecon.SetRange("Bank Account No.", rec."Bank Account No.");
                    BankRecon.SetRange("Statement No.", rec."Statement No.");
                    if BankRecon.Find('-') then
                        Report.run(Report::"Bank Reconcilliation report", true, false, BankRecon);
                end;
            }
            action(TestReport)
            {
                ApplicationArea = Basic;
                Caption = 'Number of Applied Entr. Report';
                Image = TestReport;
                promoted = true;
                PromotedIsBig = true;
                PromotedCategory = process;

                trigger OnAction()
                var
                    BankRecon: record "Bank Acc. Reconciliation";
                begin
                    BankRecon.Reset();
                    BankRecon.SetRange("Bank Account No.", rec."Bank Account No.");
                    BankRecon.SetRange("Statement No.", rec."Statement No.");
                    if BankRecon.Find('-') then
                        Report.run(Report::"Bank Recon Custom", true, false, BankRecon);
                end;
            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = Import;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'MA'; // Member Application
                        PFNumber: Text;
                    begin
                        if Rec."Bank Account No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                // UploadToEDMS(Rec, FileName, FileContentsB64);
                            end;
                        end else begin
                            Error('Application No. is required for EDMS document upload');
                        end;
                    end;
                }
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("Bank Account No.");
                    // RunPageMode = Create;
                }
            }
        }
        modify(Post)
        {
            Visible = true;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        addfirst(navigation)
        {
            // group("&Recon.")
            // {
            //     Caption = '&Recon.';
            //     Image = BankAccountRec;
            // }
            // action("&Card")
            // {
            //     ApplicationArea = Basic;
            //     Caption = '&Card';
            //     Image = EditLines;
            //     RunObject = Page "Bank Account Card";
            //     RunPageLink = "No."=field("Bank Account No.");
            //     ShortCutKey = 'Shift+F7';
            // }
        }
    }
}