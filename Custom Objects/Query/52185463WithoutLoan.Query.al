query 52185463 "Members Without Loans"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    EntityName = 'member';
    EntitySetName = 'members';
    QueryType = API;

    elements
    {
        dataitem(members; Members)
        {
            column(memberNo; "No.")
            {
                Caption = 'No.';
            }
            column(firstName; "First Name")
            {
                Caption = 'First Name';
            }
            column(middleName; "Middle Name")
            {
                Caption = 'Last Name';
            }
            column(fullName; Name)
            {
                Caption = 'Name';
            }
            column(age; Age)
            {
                Caption = 'Age';
            }
            column(status; Status)
            {
                Caption = 'Status';
            }
            column(subStatus; Subflag)
            {
                Caption = 'Sub Status';
            }
            column(Loan_Balances; "Loan Balances")
            {
                Caption = 'Loan Balances';
            }

        }
    }

    trigger OnBeforeOpen()
    begin

        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}
