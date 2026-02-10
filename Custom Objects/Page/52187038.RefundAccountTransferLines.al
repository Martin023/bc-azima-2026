page 52187038 "Bulk Refund Account Transfers"
{

    Caption = 'Bulk Refund Account Transfers';
    PageType = ListPart;
    SourceTable = "refund,Account Transfer lines";
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Source Account"; Rec."Source Account")
                {
                    ToolTip = 'Specifies the value of the Debit Account No. field.';
                }
                field("Source Loan Transaction."; Rec."Source Loan Transaction.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Loan Transaction. field.';
                }
                field("Source Loan No."; Rec."Source Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Loan No. field.';

                    trigger OnDrillDown()
                    var
                        Loans: record Loans;
                    begin
                        Loans.reset;
                        Loans.SetRange("Loan No.", Rec."Source Loan No.");
                        if loans.FindFirst() then begin
                            page.run(Page::"Loans Posted", Loans);
                        end;
                    end;
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    ToolTip = 'Specifies the value of the Credit Account.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Caption = 'Destination Loan No.';
                    ToolTip = 'Specifies the value of Loan No.';
                    LookupPageId = "Loan Posted List";
                }
                field("Total Destination Loan Balance"; Rec."Total Destination Loan Balance")
                {
                    ToolTip = 'Specifies the value of the Total Destination Loan Balance field.';
                    Editable = false;
                    // visible = Rec."Loan No." <> '';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Source Name"; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    Caption = 'Source Account Name';
                    Editable = false;
                }

                field("Destination Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Destination Account Name field.';
                    Visible = true;
                    Caption = 'Destination Account Name';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of Description.';
                }
                field(Validated; Rec.Validated)
                {
                    ToolTip = 'Specifies the value of the Validated field.';
                    Editable = false;
                }
                field("Non Validated Reason"; Rec."Non Validated Reason")
                {
                    ToolTip = 'Specifies the value of the Validation reason field.';
                    Editable = false;
                }
                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Validation reason field.';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = false;
                }

            }
        }
    }
}
