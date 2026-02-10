page 52185846 "Checkoff Advice Header"
{
    PageType = Card;
    SourceTable = "Checkoff Advice Header";
    DeleteAllowed = false;

    PromotedActionCategories = 'New,Process,Reports,Approvals,,Report,EDMS,MKey';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Issue Cut OFF Date"; Rec."Loan Issue Cut OFF Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Interest Cut OFF Date"; Rec."Loan Interest Cut OFF Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control10; "Checkoff Advice Lines")
            {
                Editable = EditBuff;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Advice Header No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Export New Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CheckoffAdviceHeader.Reset;
                    CheckoffAdviceHeader.SetRange(CheckoffAdviceHeader."No.", Rec."No.");
                    if CheckoffAdviceHeader.Find('-') then
                        XMLPORT.Run(XmlPort::"Monthly Advice New Loans", true, true, CheckoffAdviceHeader);
                end;
            }
            action("Generate Advice - Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Loan Interest Cut OFF Date");
                    Rec.TestField("Loan Issue Cut OFF Date");
                    if Rec.Processed = false then begin
                        PeriodicActivities.MonthlyCheckoffAdviceLn(Rec)

                    end else
                        Error(Txt0001);

                    Message(Txt0002);
                end;
            }
            action("Generate Advice - Saving")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.TestField("Loan Interest Cut OFF Date");
                    Rec.TestField("Loan Issue Cut OFF Date");
                    if Rec.Processed = false then begin
                        PeriodicActivities.MonthlyCheckoffAdviceSav(Rec)

                    end else
                        Error(Txt0001);

                    Message(Txt0002);
                end;
            }
            action("Mark as Processed")
            {
                ApplicationArea = Basic, Suite;
                Image = AlternativeAddress;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PeriodicActivities.ProcessAdvice(Rec);
                    CurrPage.Close();
                end;
            }
            action("Checkoff Advice - Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Checkoff Advice - Loans", true, true, Rec);
                    Rec.Reset;
                end;
            }
            action("Checkoff Advice - Cummulative")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(52185650, true, true, Rec);
                    Rec.Reset;
                end;
            }
            action("Checkoff Advice - Savings")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Checkoff Advice - Savings", true, true, Rec);
                    Rec.Reset;
                end;
            }
            action("Checkoff Advice - Consolidated")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CheckoffLines: Record "Checkoff Advice Line";
                begin
                    CheckoffLines.Reset;
                    CheckoffLines.SetRange("Advice Header No.", Rec."No.");
                    if CheckoffLines.Find('-') then
                        REPORT.Run(Report::"Checkoff Advice Consolidated", true, true, CheckoffLines);
                end;
            }
            action("Checkoff Advice - Loans Main")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Checkoff Advice - Loans Main", true, true, Rec);
                    Rec.Reset;
                end;
            }
            action("Checkoff Advice - Effective Variance")
            {
                ApplicationArea = Basic, Suite;
                Caption = ' Effective Variance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Checkoff Advice  Effectiveness", true, true, Rec);
                    Rec.Reset;
                end;
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category7;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec."No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category7;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
            action("Clear Checkoff Advice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Checkoff Advice';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ChAdvice: Record "Checkoff Advice Line";
                begin
                    ChAdvice.Reset;
                    ChAdvice.SetRange(ChAdvice."Advice Header No.", rec."No.");
                    if ChAdvice.Find('-') then begin
                        ChAdvice.DeleteAll;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Processed = true then
            CurrPage.Editable := false;
        SetUpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        SetUpdateControl;
    end;

    local procedure SetUpdateControl()
    begin
        EditBuff := true;
        if Rec.Processed = false then begin
            EditBuff := true;
        end else begin
            EditBuff := false;
        end;
    end;

    var
        PeriodicActivities: Codeunit "Periodic Activities";
        CheckoffAdviceHeader: Record "Checkoff Advice Header";
        EditBuff: Boolean;
        Txt0001: Label 'Advice already processed';
        Txt0002: Label 'Advice Generated Successfully';


}