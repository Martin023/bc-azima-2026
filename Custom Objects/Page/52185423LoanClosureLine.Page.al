page 52185423 "Loan Closure Line"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Loan Closure Line";
    ApplicationArea =  Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Name"; Rec."Product Name")
                {
                    Editable = false;
                }
                field("Product Type"; Rec."Product Type")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action19)
            {
            }
        }
    }

    var
        // MobileBanking: Codeunit "Sky Mbanking";
        MpesaManualUpload: Record "Mpesa Manual Upload";
        MBankingTransactions: Record "Sky Transactions";
        AccountNo: Text;
        LoanNo: Code[20];
        "Key": Text;
        MemberNo: Code[20];
        LBal: Decimal;
        PAct: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
}

