pageextension 52185456 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        // addafter("No.")
        // {

        // }
        // addafter(Name)
        // {
        //     field("Account Type"; Rec."Account Type")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Account Type';
        //         ToolTip = 'Account Type';
        //     }
        //     field("Member Class Account Type"; Rec."Member Class Account Type")
        //     {
        //         ToolTip = 'This field is used to identify child hope accounts on member register, so that to graduate them to class A when its DUE';
        //     }
        //     field("Graduation To Class"; Rec."Graduation To Class")
        //     {
        //         ToolTip = 'This field will hold the value for whose members in the employer code subject to graduation will graduate to';
        //     }
        //     field("Checkoff Cuttoff Day"; Rec."Checkoff Cuttoff Day")
        //     {

        //     }


        // }
    }

    actions
    {
        modify(Print)
        {
            Visible = true;
        }
        addbefore(Email)
        {
            action("Sales Invoice Printout")
            {
                Caption = 'Sales Invoice Printout';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    Customer: Record Customer;
                begin
                    // Customer.SetRange("No.", Rec."Sell-to Customer No.");
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then begin
                        Report.Run(Report::"Sales Invoice Printout", true, false, SalesInvoiceHeader);
                    end;
                end;
            }


        }

    }

}