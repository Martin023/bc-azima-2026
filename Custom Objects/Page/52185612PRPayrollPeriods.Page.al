page 52185612 "PR Payroll Periods"
{
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "PR Payroll Periods";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    CardPageId = "prPayroll Period";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Opened"; Rec."Date Opened")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Opened By"; Rec."Opened By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */

                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']';

                    Answer := DIALOG.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod);

                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //  OnViewCurrRec();
    end;

    var
        PayPeriod: Record "PR Payroll Periods";
        strPeriodName: Text[30];
        Text000: Label '''Leave without saving changes?''';
        Text001: Label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "PR Payroll Processing";
        dtOpenPeriod: Date;
        SalCard: Record "PR Salary Card";

    //[Scope('OnPrem')]
    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period
        PayPeriod.Reset();
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;

    //[Scope('OnPrem')]
    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}

