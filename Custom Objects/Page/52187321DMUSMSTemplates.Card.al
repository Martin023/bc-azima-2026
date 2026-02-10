page 52187321 "DMU SMS Templates"
{
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "DMU SMS Templates";
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {

                }

            }
            field(Description; Rec.Description)
            {

            }
            field("Text SMS"; Rec."Text SMS")
            {
                MultiLine = true;
            }
            field("Notice Type"; Rec."Notice Type")
            {

            }
            field(Recepient; Rec.Recepient)
            {

            }
            field("Notice Category"; Rec."Notice Category")
            {

            }
            field("SMS Days Intervals"; Rec."SMS Days Intervals")
            {

            }
            field("Days in Arrears"; Rec."Days in Arrears")
            {

            }
        }
    }

    actions
    {
        area(creation)
        {
            action(README)
            {
                ApplicationArea = Basic, Suite;
                Image = Tools;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'This action will display the place holders and their meaning. Feel advised';
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Message('README!\%1 - Recepients Name\%2 - Loan Description\%3 - Amount In Arrears\%4 - Total Balance\%5 - Loanee 1st Name\%6 - Loanee Member No\%7 - Monthly Repayment\%8 - Last Repayment Date\%9 - Loan Number\%10 - Principle Loan Balance\%11 - Interest Balance\%12 - Amount In Arrears\%13 - Disbursement Amount\%14 - Prorata');
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnClosePage()
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;


}

