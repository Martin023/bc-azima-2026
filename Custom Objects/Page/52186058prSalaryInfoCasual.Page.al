page 52186058 "prSalary Info Casual"
{
    PageType = CardPart;
    SourceTable = "prSalary Card Casual";

    layout
    {
        area(content)
        {
            repeater("Payment Info")
            {
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overtime Hours"; Rec."Overtime Hours")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Public Holidays&Weekend Hours"; Rec."Public Holidays&Weekend Hours")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Non Taxable"; Rec."Non Taxable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm BasicPay"; Rec."Cumm BasicPay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm GrossPay"; Rec."Cumm GrossPay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm Allowances"; Rec."Cumm Allowances")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm PAYE"; Rec."Cumm PAYE")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm Deductions"; Rec."Cumm Deductions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm NetPay"; Rec."Cumm NetPay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspension Date"; Rec."Suspension Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspension Reasons"; Rec."Suspension Reasons")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //Get the open period
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            CurrentMonth := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
        end;
    end;

    trigger OnOpenPage()
    begin
        // CurrPage.EDITABLE:=TRUE;
    end;

    var
        BasicSalary: Decimal;
        Question: Text[200];
        Answer: Boolean;
        objPeriod: Record "PR Payroll Periods";
        CurrentMonth: Date;
        PeriodName: Text[30];
        PeriodTrans: Record "PR Period Transactions";
}

