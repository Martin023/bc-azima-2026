page 52187154 "Deposit Listing List"
{
    PageType = List;
    SourceTable = "Deposit Listing";
    ApplicationArea = All;
    Caption = 'Deposit Listing';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("ID Number";Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = All;
                }
               
                field("Last Transacted Amount"; Rec."Last Transacted Amount")
                {
                    ApplicationArea = All;
                }
                field("Last Transaction Date"; Rec."Last Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = All;
                }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                }
                field("Member Sub Status"; Rec."Member Sub Status")
                {
                    ApplicationArea = All;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = All;
                }
                field("Product Code";Rec."Product Code")
                {
                    ApplicationArea = All;
                }
                field("Product Name";Rec."Product Name")
                {
                    ApplicationArea = All;
                }
                 field("As At Date";Rec."As At Date")
                {
                    ApplicationArea = All;
                }
                field("Balance As At";Rec."Balance As At")
                {
                    ApplicationArea = All;
                }
                field("Current Balance";Rec."Current Balance")
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Queue Deposit Listing Process")
            {
                ApplicationArea = All, Basic, Suite;
                Caption = 'Start Deposit Listing Process';
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TheSavingsAccounts: Record "Savings Accounts";
                begin
                    TheSavingsAccounts.Reset();

                    Codeunit.Run(Codeunit::"Deposit List Job Queue Manager", TheSavingsAccounts);

                    // if Codeunit.Run(Codeunit::"Deposit List Job Queue Manager", TheSavingsAccounts) then begin
                    //     Message('Deposit Listing Process initiated successfully. It will run in the background');
                    // end else begin
                    //     Error('Unable to initiate Deposit Listing Process at the moment!');
                    // end;
                end;
            }
        }
    }
}
