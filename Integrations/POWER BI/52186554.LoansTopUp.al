page 52186554 "Loans Top Up"
{
    APIGroup = 'powerBI';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'loansTopUp';
    DelayedInsert = true;
    EntityName = 'loansTopUp';
    EntitySetName = 'loansTopUps';
    PageType = API;
    SourceTable = "Loans Top up";

    ODataKeyFields = SystemId;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(additionalTopUpCommission; Rec."Additional Top Up Commission")
                {
                    Caption = 'Additional Top Up Commission';
                }
                field(clientCode; Rec."Client Code")
                {
                    Caption = 'Client Code';
                }
                field(commision; Rec.Commision)
                {
                    Caption = 'Commision';
                }
                field(dailyInterest; Rec."Daily Interest")
                {
                    Caption = 'Daily Interest';
                }
                field(idNO; Rec."ID. NO")
                {
                    Caption = 'ID. NO';
                }
                field(insuranceRebate; Rec."Insurance rebate")
                {
                    Caption = 'Insurance rebate';
                }
                field(interestPaid; Rec."Interest Paid")
                {
                    Caption = 'Interest Paid';
                }
                field(interestRate; Rec."Interest Rate")
                {
                    Caption = 'Interest Rate';
                }
                field(interestTopUp; Rec."Interest Top Up")
                {
                    Caption = 'Interest Top Up';
                }
                field(loanAccount; Rec."Loan Account")
                {
                    Caption = 'Loan Account';
                }
                field(loanNo; Rec."Loan No.")
                {
                    Caption = 'Loan No.';
                }
                field(loanProductTypeName; Rec."Loan Product Type Name")
                {
                    Caption = 'Loan Product Type Name';
                }
                field(loanSpan; Rec."Loan Span")
                {
                    Caption = 'Loan Span';
                }
                field(loanTopUp; Rec."Loan Top Up")
                {
                    Caption = 'Loan Top Up';
                }
                field(loanType; Rec."Loan Type")
                {
                    Caption = 'Loan Type';
                }
                field(monthlyRepayment; Rec."Monthly Repayment")
                {
                    Caption = 'Monthly Repayment';
                }
                field(oneMonthInterest; Rec."One Month Interest")
                {
                    Caption = 'One Month Interest';
                }
                field(outstandingBalance; Rec."Outstanding Balance")
                {
                    Caption = 'Outstanding Balance';
                }
                field(outstandingBill; Rec."Outstanding Bill")
                {
                    Caption = 'Outstanding Bill';
                }
                field(principleTopUp; Rec."Principle Top Up")
                {
                    Caption = 'Principle Top Up';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(totalTopUp; Rec."Total Top Up")
                {
                    Caption = 'Total Top Up';
                }
                field(untransferedInterest; Rec."Untransfered Interest")
                {
                    Caption = 'Untransfered Interest';
                }
            }
        }
    }
}
