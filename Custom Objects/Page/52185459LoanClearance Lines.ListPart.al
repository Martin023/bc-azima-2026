page 52185459 "Loan Clearance Lines"
{
    PageType = ListPart;
    SourceTable = "Loan Clearance Lines";
    // DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Member No."; Rec."Member No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Source Account No."; Rec."Source Account No.")
                {

                }
                field("Source Account Type"; Rec."Source Account Type")
                {

                }
                field("Source Account Name"; Rec."Source Account Name")
                {

                }
                field("Source Account Balance"; Rec."Source Account Balance")
                {

                }

                field("Loan No."; Rec."Loan No.")
                {
                    trigger OnDrillDown()
                    var
                        Loans: record Loans;
                    begin
                        Loans.reset;
                        Loans.SetRange("Loan No.", Rec."Loan No.");
                        if loans.FindFirst() then begin
                            page.run(Page::"Loans Posted", Loans);
                        end;
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {

                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {

                }
                field("Interest Balance"; Rec."Interest Balance")
                {

                }
                field("Principle Balance"; Rec."Principle Balance")
                {

                }
                field("Total Balance"; Rec."Total Balance")
                {

                }
            }
        }
    }
}
