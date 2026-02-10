page 52185989 "Payment Types Lists"
{
    CardPageID = "Payment Types";
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = WHERE(Type = CONST(Payment));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        AccountTypeOnAfterValidate;
                    end;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        UpdateControl;
                    end;
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        UpdateControl;
                    end;
                }
                field("VAT Withholding Code"; Rec."VAT Withholding Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Deductible"; Rec."VAT Deductible")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Calculate Retention"; Rec."Calculate Retention")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        UpdateControl;
                    end;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = "VAT CodeEnable";
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = "Withholding Tax CodeEnable";
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = "Retention CodeEnable";
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //CurrPage."G/L AccountVisible":=("Account Type"="Account Type"::"G/L Account");
        OnAfGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Retention CodeEnable" := true;
        "Withholding Tax CodeEnable" := true;
        "VAT CodeEnable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Payment;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."Account Type"::Credit;
        OnAfGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
    end;

    var

        "VAT CodeEnable": Boolean;

        "Withholding Tax CodeEnable": Boolean;

        "Retention CodeEnable": Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin
        if Rec."VAT Chargeable" = Rec."VAT Chargeable"::Yes then
            "VAT CodeEnable" := true
        else
            "VAT CodeEnable" := false;

        if Rec."Withholding Tax Chargeable" = Rec."Withholding Tax Chargeable"::Yes then
            "Withholding Tax CodeEnable" := true
        else
            "Withholding Tax CodeEnable" := false;

        if Rec."Calculate Retention" = Rec."Calculate Retention"::Yes then
            "Retention CodeEnable" := true

        else
            "Retention CodeEnable" := false;
    end;

    local procedure AccountTypeOnAfterValidate()
    begin
        //CurrPage."G/L Account".VISIBLE:=("Account Type"="Account Type"::"G/L Account");
    end;

    local procedure OnAfGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControl;
    end;
}

