namespace MNS.MNS;

using Microsoft.Sales.Customer;

page 52186566 "Employer Code List"
{
    ApplicationArea = All;
    Caption = 'Employer Code List';
    PageType = List;
    SourceTable = Customer;
    SourceTableView = where("Account Type" = filter(Employer));
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageId = "Customer Card";
    // Sorting = "No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the responsibility center that will administer this customer by default.';
                }
                field("Number Of Members"; rec."No of Memmbers (Employer)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number Of Members';
                    Caption = 'Number Of Members';

                    trigger OnDrillDown()
                    var
                        Members: Record Members;
                    begin
                        Members.Reset();
                        Members.setfilter(Status, '<>%1&<>%2', Members.Status::Closed, Members.Status::Deceased);
                        Members.SetRange("Employer Code", Rec."No.");
                        if Members.FindSet() then
                            page.run(page::"Member List", Members);
                    end;
                }
                field("Number of Accounts"; Rec."No of Accounts (Employer)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of Accounts';

                    trigger OnDrillDown()
                    var
                        SavAccs: Record "Savings Accounts";
                    begin
                        SavAccs.Reset();
                        SavAccs.setfilter(Status, '<>%1&<>%2', SavAccs.Status::Closed, SavAccs.Status::Deceased);
                        SavAccs.SetRange("Employer Code", Rec."No.");
                        SavAccs.SetRange("Source Unit", SavAccs."Source Unit"::BOSA);
                        if SavAccs.FindSet() then
                            page.run(page::"Savings Account List", SavAccs);
                    end;
                }
                field("Number of Loans"; Rec."No of Loans (Employer)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of Loans';

                    trigger OnDrillDown()
                    var
                        Loans: Record Loans;
                    begin
                        Loans.Reset();
                        Loans.setrange(Posted, true);
                        Loans.SetRange("Employer Code", Rec."No.");
                        Loans.SetRange("Source Unit", Loans."Source Unit"::BOSA);
                        if Loans.FindSet() then
                            page.run(page::"Loan Posted List", Loans);
                    end;
                }
                // field("Digit Custodian"; Rec."Digit Custodian")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Digit Custodian';
                // }
                // field("Responsible Employee"; Rec."Responsible Employee")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Responsible Employee';
                // }
                // field("Responsible Employee Name"; Rec."Responsible Employee Name")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Responsible Employee Name';
                // }
                // field("Responsible Employee Extension"; Rec."Responsible Employee Extension")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Responsible Employee Extension';
                // }
                // field("E-Mail"; Rec."E-Mail")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'E-Mail';
                // }
            }
        }
    }
    trigger OnOpenPage()
    var
        Cust: record Customer;
    begin
        Cust.Reset();
        Cust.SetRange("Account Type", Cust."Account Type"::Employer);
        if Cust.Find('-') then begin
            repeat
                Cust.Validate("Responsible Employee");
                Cust.Modify();
            until Cust.Next = 0;
        end;
    end;
}
