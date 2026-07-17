#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185973 "ATM Upload Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ATM Upload Report.rdl';

    dataset
    {
        dataitem("ATM Applications"; "ATM Applications")
        {
            DataItemTableView = where(Status = filter(Approved));
            column(ReportForNavId_1; 1)
            {
            }
            column(FName; FName)
            {
            }
            column(Surname; Surname)
            {
            }
            column(ID; "ATM Applications"."Customer ID")
            {
            }
            column(BrancName; BrancName)
            {
            }
            column(AccNum; "ATM Applications"."Account No")
            {
            }
            column(PhoneNo; Phone)
            {
            }
            column(BinCode; BinCode)
            {
            }
            column(SaccoName; SaccoName)
            {
            }
            column(BranchCode; BranchCode)
            {
            }

            trigger OnAfterGetRecord()
            begin

                SavingsAccounts.Get("ATM Applications"."Account No");
                Members.Get(SavingsAccounts."Member No.");
                FName := Members."First Name";
                Surname := Members."Other Names";
                BrancName := 'Tom Mboya BRANCH';
                BinCode := '42993304';
                BranchCode := '011';
                SaccoName := 'AZIMA SACCO';

                if CopyStr("ATM Applications"."Phone No.", 1, 1) = '+' then
                    Phone := '0' + DelStr("ATM Applications"."Phone No.", 1, 3)
                else
                    Phone := '';

                "ATM Applications".Uploaded := Posted;
                "ATM Applications".Modify;
            end;

            trigger OnPreDataItem()
            begin
                if Confirm('Do you want to flag transactions as uploaded?', false) = true then begin
                    Posted := true
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SaccoName: Code[30];
        BinCode: Code[30];
        BrancName: Code[30];
        Surname: Text;
        FName: Text;
        SavingsAccounts: Record "Savings Accounts";
        Members: Record "Members";
        BranchCode: Code[20];
        Phone: Code[20];
        Posted: Boolean;
}
