page 52185615 "PR Salary Information"
{
    AutoSplitKey = false;
    Caption = 'Payment Information';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    //PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "PR Salary Card";

    layout
    {
        area(content)
        {
            repeater("Payment Info")
            {
                Caption = 'Payment Info';
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Days Worked"; Rec."Days Worked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rate Per Day"; Rec."Rate Per Day")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays New NSSF (%)"; Rec."Pays New NSSF (%)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pays NSSF (%)';
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pays Housing Levy"; Rec."Pays Housing Levy")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Disable Personal Relief?"; Rec."Disable Personal Relief?")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Certificate?"; Rec."Insurance Certificate?")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Cert No"; Rec."Insurance Cert No")
                {

                }
                field("Gratuity Amount"; Rec."Gratuity Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin

                        if Rec."Suspend Pay" = true then begin
                            Question := 'Suspending means the staff will NOT be paid for [' + PeriodName + '].';
                            Question := Question + '\If any transactions had been posted for [' + PeriodName + '], the system will delete them.\';
                            Question := Question + '\Do you wish to suspend the pay for the staff?';
                            Answer := DIALOG.Confirm(Question, false);
                            if Answer = false then begin
                                Rec."Suspend Pay" := false;
                                Rec."Suspension Reasons" := '';
                                Rec."Suspension Date" := Today;
                            end;

                            if Answer = true then begin
                                PeriodTrans.Reset;
                                PeriodTrans.SetRange(PeriodTrans."Employee Code", Rec."Employee Code");
                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", CurrentMonth);
                                PeriodTrans.DeleteAll;
                            end;
                        end;

                        if Rec."Suspend Pay" = false then Rec."Suspension Reasons" := '';
                    end;
                }
                field("Suspension Date"; Rec."Suspension Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspension Reasons"; Rec."Suspension Reasons")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = false;
                }
                field("Cumm BasicPay"; Rec."Cumm BasicPay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm GrossPay"; Rec."Cumm GrossPay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm NetPay"; Rec."Cumm NetPay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm Allowances"; Rec."Cumm Allowances")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cumm Deductions"; Rec."Cumm Deductions")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cumm PAYE"; Rec."Cumm PAYE")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cumm NSSF"; Rec."Cumm NSSF")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cumm Pension"; Rec."Cumm Pension")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cumm HELB"; Rec."Cumm HELB")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cumm NHIF"; Rec."Cumm NHIF")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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

    var
        BasicSalary: Decimal;
        Qtn: Label '''Leave without saving changes?''';
        Question: Text[200];
        Answer: Boolean;
        objPeriod: Record "PR Payroll Periods";
        CurrentMonth: Date;
        PeriodName: Text[30];
        PeriodTrans: Record "PR Period Transactions";
}

