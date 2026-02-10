page 52185857 "Loan Guarantors List"
{
    Caption = 'Loan Guarantor Substitution Lines';
    PageType = ListPart;
    DeleteAllowed = false;
    SourceTable = "Loan Guarantors Sub";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Type"; Rec."Guarantor Type")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Guarantor Type" = Rec."Guarantor Type"::Collateral then
                            Colledit := true
                        else
                            Colledit := false;
                    end;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = all;
                    Editable = Colledit;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Member Substituted"; Rec."Member Substituted")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Substituted Guarantor';
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Substituted';

                    trigger OnValidate()
                    begin
                        /*
                        GuarantSubt.RESET;
                        GuarantSubt.SETRANGE(GuarantSubt."Loan Account No.","Member No");
                        IF GuarantSubt.FIND('-') THEN BEGIN
                        IF GuarantSubt.Status<>GuarantSubt.Status::Approved THEN
                        ERROR(Text001);
                        END;
                         */

                    end;
                }
                field("No Of Loans Guaranteed"; Rec."No Of Loans Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Proportion Guaranteed"; Rec."Proportion Guaranteed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member Guaranteed"; Rec."Member Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member Guaranteed';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Group Account No."; Rec."Group Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(PercentageGur; Rec.PercentageGur)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text001: Label 'This Application is not Approved';
        Colledit: Boolean;
}

