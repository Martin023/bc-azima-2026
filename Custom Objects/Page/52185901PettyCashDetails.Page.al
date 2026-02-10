page 52185901 "Petty Cash Details"
{
    PageType = Card;
    SourceTable = "Imprest Details-User";
    PromotedActionCategories = 'EDMS';

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No:"; Rec."Account No:")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Imprest Holder"; Rec."Imprest Holder")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Apply to"; Rec."Apply to")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Apply to ID"; Rec."Apply to ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Surrendered; Rec.Surrendered)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("M.R. No"; Rec."M.R. No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Surrender"; Rec."Type of Surrender")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dept. Vch. No."; Rec."Dept. Vch. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Surrender Amt"; Rec."Cash Surrender Amt")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank/Petty Cash"; Rec."Bank/Petty Cash")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(Creation){
            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = New;
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
                        if Rec."No" <> '' then begin
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
                    PromotedCategory = New;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("No");
                    // RunPageMode = Create;
                }
            }
        }
    }
}

