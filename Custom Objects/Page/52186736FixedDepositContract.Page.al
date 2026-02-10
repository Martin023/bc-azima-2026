page 52186736 "Fixed Deposit Contract List"
{
    Caption = 'Fixed/Call Deposit Contract';
    CardPageID = "Fixed Deposit Contract";
    Editable = false;
    InsertAllowed = true;
    DeleteAllowed = true;
    PageType = List;
    ShowFilter = true;
    SourceTable = "Fixed Deposit Contract";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = 'New, Process, Approvals, Workflows';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.';
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ToolTip = 'Specifies the value of the Payroll/Staff No. field.';
                }
                field(Balance; Rec.Balance)
                { }

                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Fixed Deposit Account No."; Rec."Fixed Deposit Account No.")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit Account No. field.';
                }
                field("Fixed Deposit Amount"; Rec."Fixed Deposit Amount")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit Amount field.';
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit Type field.';
                }
                field("FD Maturity Instructions"; Rec."FD Maturity Instructions")
                {
                    ToolTip = 'Specifies the value of the FD Maturity Instructions field.';
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    ToolTip = 'Specifies the value of the FD Duration field.';
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ToolTip = 'Specifies the value of the FD Maturity Date field.';
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit Status field.';
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ToolTip = 'Specifies the value of the Expected Maturity Date field.';
                }
                field("FD Marked for Closure"; Rec."FD Marked for Closure")
                {
                    ToolTip = 'Specifies the value of the FD Marked for Closure field.';
                }
                field("Fixed Deposit cert. no"; Rec."Fixed Deposit cert. no")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit cert. no field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Neg. Interest Rate"; Rec."Neg. Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Neg. Interest Rate field.';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ToolTip = 'Specifies the value of the Product Name field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                }


                field("Registration Date"; Rec."Registration Date")
                {
                    ToolTip = 'Specifies the value of the Registration Date field.';
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field("Relationship Manager"; Rec."Relationship Manager")
                {
                    ToolTip = 'Specifies the value of the Relationship Manager field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Savings Account No."; Rec."FOSA Main Account No.")
                {
                    ToolTip = 'Specifies the value of the Savings Account No. field.';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
        }
    }
}
