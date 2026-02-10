#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186438 tableextension52186438 extends "Finance Cue"
{
    fields
    {
        field(50050; "Payment Vouchers"; Integer)
        {
            CalcFormula = count("Payments Header" where("Document Type" = const("Payment Voucher"),
                                                         Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50051; "Petty Cash Vouchers"; Integer)
        {
            CalcFormula = count("Payments Header" where("Document Type" = const("Petty Cash"),
                                                         Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50052; "Staff Advance"; Integer)
        {
            CalcFormula = count("Staff Advance Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50053; "Staff Claims"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50054; "Imprest Request"; Integer)
        {
            CalcFormula = count("Imprest Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50055; "Staff Advance Surrender"; Integer)
        {
            CalcFormula = count("Staff Advance Surrender Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50056; "Imprest Surrender"; Integer)
        {
            CalcFormula = count("Imprest Surrender Header" where(Status = const(Approved)));
            FieldClass = FlowField;
        }
        // field(50057;Receipts;Integer)
        // {
        //     CalcFormula = count("Receipts Header" where (Posted=const(No)));
        //     FieldClass = FlowField;
        // }
        field(50058; "My Payment Vouchers"; Integer)
        {
            CalcFormula = count("Payments Header" where("Document Type" = const("Payment Voucher"),
                                                         Status = const(Approved), Posted = const(true),
                                                         Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50059; "My Petty Cash Vouchers"; Integer)
        {
            CalcFormula = count("Payments Header" where("Document Type" = const("Petty Cash"),
                                                         Status = const(Approved), posted = const(true),
                                                         Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50060; "My Staff Advance"; Integer)
        {
            CalcFormula = count("Staff Advance Header" where(Status = const(Approved), posted = const(true),
                                                              Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50061; "My Staff Claims"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = const(Approved), posted = const(true),
                                                             Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50062; "My Imprest Request"; Integer)
        {
            CalcFormula = count("Imprest Header" where(Status = const(Approved), posted = const(true),
                                                        Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50063; "My Staff Advance Surrender"; Integer)
        {
            CalcFormula = count("Staff Advance Surrender Header" where(Status = const(Approved), posted = const(true),
                                                                        "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50064; "My Imprest Surrender"; Integer)
        {
            CalcFormula = count("Imprest Surrender Header" where(Status = const(Approved), posted = const(true),
                                                                  "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50065; "User ID Filter"; Code[30])
        {

            FieldClass = FlowFilter;
        }
        field(50066; "Member Withdrawal"; Integer)
        {

            CalcFormula = count("Member withdrawal Notice" where(Status = const(Approved)));
            FieldClass = FlowField;

        }
        field(50067; "Member Closure"; Integer)
        {

            CalcFormula = count("Membership closure" where(Status = const(Approved), Posted = const(true)));
            FieldClass = FlowField;

        }
        field(50068; "Loans"; Integer)
        {
            Caption = 'Posted Loans(All)';
            CalcFormula = count(Loans where(Status = const(Approved), Posted = const(true)));
            FieldClass = FlowField;

        }
        field(50069; "Share Capital"; Integer)
        {

            CalcFormula = count("Share Capital Transfer Buffer" where(Status = const(Approved), Transfered = const(true)));
            FieldClass = FlowField;

        }
        field(50070; "Members"; Integer)
        {

            CalcFormula = count(Members where(Status = const(Active)));
            FieldClass = FlowField;

        }
        field(50071; "Processed Checkoff"; Integer)
        {
            CalcFormula = count("Checkoff Header" where(Status = const(Approved), Posted = const(true),
            "Entered By" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        //Pending Posting

        field(50072; " Pending Share Capital"; Integer)
        {
            Caption = 'Pending Share Capital Transfer';
            CalcFormula = count("Share Capital Transfer Buffer" where(Status = const(Approved), Transfered = const(false)));
            FieldClass = FlowField;

        }
        field(50073; "Pending Payment Vouchers"; Integer)
        {
            CalcFormula = count("Payments Header" where("Document Type" = const("Payment Voucher"),
                                                         Status = const(Approved), Posted = const(false),
                                                         Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50074; "Pending Petty Cash Vouchers"; Integer)
        {
            CalcFormula = count("Payments Header" where("Document Type" = const("Petty Cash"),
                                                         Status = const(Approved), Posted = const(false),
                                                         Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50075; "Pending Processed Checkoff"; Integer)
        {
            CalcFormula = count("Checkoff Header" where(Status = const(Approved), Posted = const(false),
            "Entered By" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50076; "Pending Loans"; Integer)
        {
            Caption = 'Approved Loans';
            CalcFormula = count(Loans where(Status = const(Approved), Posted = const(false)));
            FieldClass = FlowField;

        }
        field(50077; "Pending Member Closure"; Integer)
        {
            CalcFormula = count("Membership closure" where(Status = const(Approved), Posted = const(false)));
            FieldClass = FlowField;

        }

        field(50078; "Pending Staff Advance"; Integer)
        {
            CalcFormula = count("Staff Advance Header" where(Status = const(Approved), posted = const(false),
                                                              Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50079; "Pending Staff Claims"; Integer)
        {
            CalcFormula = count("Staff Claims Header" where(Status = const(Approved), posted = const(false),
                                                             Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50080; "Pending Imprest Request"; Integer)
        {
            CalcFormula = count("Imprest Header" where(Status = const(Approved), posted = const(false),
                                                        Cashier = field("User ID Filter")));
            FieldClass = FlowField;
        }

        field(50082; "Pending Imprest Surrender"; Integer)
        {
            CalcFormula = count("Imprest Surrender Header" where(Status = const(Approved), posted = const(false),
                                                                  "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
        }
        field(50083; "Open/Pending Saving Variations"; Integer)
        {
            CalcFormula = count("Product Variations" where(Status = filter(Open | "Pending Approval"), Posted = const(false), "Variation Type" = const(Savings), "Sent Back to CRM" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50084; "Open/Pending Loan Variations"; Integer)
        {
            CalcFormula = count("Product Variations" where(Status = filter(Open | "Pending Approval"), Posted = const(false), "Variation Type" = const(Loan), "Sent Back to CRM" = CONST(false)));
            FieldClass = FlowField;
        }

        field(50085; "Running Div. Processes"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Job Queue Entry" where("Object Type to Run" = Const(Codeunit), "Object ID to Run" = const(Codeunit::"Dividend Job")));
        }
        field(50086; "Generated Div. Entries"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dividend Progression");
        }
    }
}