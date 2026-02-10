page 52186417 "Loan Linking"
{
    PageType = Card;
    SourceTable = "Loan Linking";

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control8; "Loan Linking List")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Records")
            {
                ApplicationArea = Basic, Suite;
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        LoanLinkingLine.Reset;
                        LoanLinkingLine.SetRange(LoanLinkingLine.No, Rec."No.");
                        if LoanLinkingLine.Find('-') then begin
                            repeat
                                if Loans.Get(LoanLinkingLine."Loan No") then begin
                                    Loans."Loan Linking No." := LoanLinkingLine."Loan Linking No.";
                                    Loans.Modify;
                                end;
                            until LoanLinkingLine.Next = 0;
                        end;
                        Message('Update Successful');
                    end else
                        Error('Document must be approved');
                end;
            }
        }
    }

    var
        Loans: Record Loans;
        LoanLinkingLine: Record "Loan Linking Line";
}

