page 52186597 "CRM Member Account API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'memberAccountAPI';
    DelayedInsert = true;
    EntityName = 'account';
    EntitySetName = 'accounts';
    EntityCaption = 'Account';
    EntitySetCaption = 'Accounts';
    PageType = API;
    SourceTable = "Savings Accounts";

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
                field(memberNo; Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field(accountNo; Rec."No.")
                {
                    Caption = 'Account No.';
                }
                field(accountName; Rec.Name)
                {
                    Caption = 'Account Name';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(lastTransactionDate; Rec."Last Transaction Date")
                {
                    Caption = 'Last Transaction Date';
                }
                field(accountCategory; Rec.Category)
                {
                    Caption = 'Account Category';
                }
                field(productNo; Rec."Product Type")
                {
                    Caption = 'Product Type';
                }
                field(productName; Rec."Product Name")
                {
                    Caption = 'Product Name';
                }
                field(productCategory; Rec."Product Category")
                {
                    Caption = 'Product Category';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(monthlyContribution; Rec."Monthly Contribution")
                {
                    Caption = 'Monthly Contribution';
                }
                field(outstandingInterest; Rec."Outstanding Interest")
                {
                    Caption = 'Outstanding Interest';
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
