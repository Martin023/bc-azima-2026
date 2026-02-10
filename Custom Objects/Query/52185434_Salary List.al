
query 52185434 "Salary Lines"
{
    Caption = 'Detailed Salary Lines';
    QueryType = Normal;
    UsageCategory = ReportsAndAnalysis;


    DataAccessIntent = ReadOnly; // use this to read data from the secondary database replica to speed up performance
    elements
    {
        dataitem(members; "Salary Header")
        {
            column(No; No)
            {
            }

            column(Posting_date; "Posting date")
            {

            }
            column(Document_No; "Document No")
            {

            }
            column(Remarks; Remarks)
            {

            }

            dataitem(FosaAccount; "Salary Lines")
            {
                DataItemLink = "Salary Header No." = members.No;


                SqlJoinType = LeftOuterJoin;
                //DataItemTableFilter = "Product Category" = const("FOSA Account");
                column(fosaAccountNo; "Account No.")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Staff_No_; "Staff No.")
                {
                }
                column(Account_Name; "Account Name")
                {
                }
                column(ID_No_; "ID No.")
                {
                }
                column(Employer_Code; "Employer Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Posted; Posted)
                {

                }


            }

        }
    }

    trigger OnBeforeOpen()
    begin
    end;

    var
        GFunc: Codeunit "Global Functions";
}

