
query 52185430 "Members Listing"
{
    Caption = 'Members Listing';
    QueryType = Normal;
    //OrderBy = Ascending(memberNo);
    //TopNumberOfRows = 5000;
    elements
    {
        dataitem(members; Members)
        {
            column(memberNo; "No.")
            {
                Caption = 'No.';
            }
            column(fullName; Name)
            {
                Caption = 'Name';
            }
            column(FOSA_Account; "FOSA Account")
            {
                Caption = 'Ordinary Account';
            }
            column(Phone_No_; "Phone No.")
            {
                Caption = 'Phone No.';
            }
            column(Transactional_Mobile_Number; "Transactional Mobile Number")
            {
                Caption = 'Transactional Mobile Number';
            }
            column(Global_Dimension_1; "Global Dimension 1 Code")
            {
                Caption = 'Global Dimension 1 Code';
            }
            column(Global_Dimension_2; "Global Dimension 2 Code")
            {
                Caption = 'Global Dimension 2 Code';
            }
            column(Registration_Date; "Registration Date")
            {
                Caption = 'Registration Date';
            }
            column(Status; Status)
            {
                Caption = 'Status';
            }
            column(Employer_Code; "Employer Code")
            {
                Caption = 'Employer Code';
            }

            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {
                Caption = 'Payroll/Staff No';
            }
            column(Date_of_Birth; "Date of Birth")
            {
                Caption = 'Date of Birth';
            }

            column(Subflag; Subflag)
            {
                Caption = 'Sub Status';
            }
            column(Primary_Identification; "Primary Identification")
            {
                Caption = 'Primary Identification';
            }
        }

    }

    trigger OnBeforeOpen()
    begin
    end;

    var
        GFunc: Codeunit "Global Functions";
        SavingsAcc: record "Savings Accounts";
        Balance: decimal;
}

