page 52186596 "CRM Loan Guarantors API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'loanGuarantorsAPI';
    DelayedInsert = true;
    EntityName = 'guarantor';
    EntitySetName = 'guarantors';
    EntityCaption = 'Guarantor';
    EntitySetCaption = 'Guarantors';
    PageType = API;
    SourceTable = "Loan Guarantors and Security";

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
                field(loanNo; Rec."Loan No")
                {
                    Caption = 'Loan No';
                }
                field(loaneeName; Rec."Loanee Name")
                {
                    Caption = 'Loanee Name';
                }
                field(memberNo; Rec."Member No")
                {
                    Caption = 'Guarantor Member Number';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(loanType; Rec."Loan Type")
                {
                    Caption = 'Loan Type';
                }
                field(loanProductName; Rec."Loan Product Name")
                {
                    Caption = 'Loan Product Name';
                }
                field(amountGuaranteed; Rec."Amount Guaranteed")
                {
                    Caption = 'Amount Guaranteed';
                }
                field(dateSubstituted; Rec."Date Substituted")
                {
                    Caption = 'Date Substituted';
                }
                field(guaranteedBalance; Rec."Guaranteed Balance")
                {
                    Caption = 'Guaranteed Balance';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Created Date Time';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'Modified Date Time';
                }
            }
        }
    }
}
