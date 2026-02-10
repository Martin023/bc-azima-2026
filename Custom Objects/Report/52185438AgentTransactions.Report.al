#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185438 "Agent Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Agent Transactions.rdl';

    dataset
    {
        dataitem("Sky Agents Transactions"; "Sky Agents Transactions")
        {
            //DataItemTableView = sorting("Transaction Date", "Time Posted") where(Posted = const(Yes));
            RequestFilterFields = "Date Posted", "Agent Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(TransactionID_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction ID")
            {
            }
            column(TransactionDate_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Date")
            {
            }
            column(AgentCode_SkyAgentsTransactions; "Sky Agents Transactions"."Agent Code")
            {
            }
            column(MemberAccount_SkyAgentsTransactions; "Sky Agents Transactions"."Member Account")
            {
            }
            column(MemberNo_SkyAgentsTransactions; "Sky Agents Transactions"."Member No")
            {
            }
            column(VendorCommission_SkyAgentsTransactions; "Sky Agents Transactions"."Vendor Commission")
            {
            }
            column(SaccoFee_SkyAgentsTransactions; "Sky Agents Transactions"."Sacco Fee")
            {
            }
            column(Description_SkyAgentsTransactions; "Sky Agents Transactions".Description)
            {
            }
            column(Amount_SkyAgentsTransactions; "Sky Agents Transactions".Amount)
            {
            }
            column(DatePosted_SkyAgentsTransactions; "Sky Agents Transactions"."Date Posted")
            {
            }
            column(TransactionType_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Type")
            {
            }
            column(TransactionName_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Name")
            {
            }
            column(LoanNo_SkyAgentsTransactions; "Sky Agents Transactions"."Loan No.")
            {
            }
            column(MobileNo_SkyAgentsTransactions; "Sky Agents Transactions"."Mobile No.")
            {
            }
            column(ClientName_SkyAgentsTransactions; "Sky Agents Transactions"."Client Name")
            {
            }
            column(AgentComm; AgentComm)
            {
            }
            column(PrintedAt; PrintedAt)
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(TransactionTime_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Time")
            {
            }
            column(AgentCode; AgentCode)
            {
            }
            column(AgentName; AgentName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange("Vendor No.", "Sky Agents Transactions"."Agent Commision Account");
                VendorLedgerEntry.SetRange("Document No.", "Sky Agents Transactions"."Transaction ID");
                if VendorLedgerEntry.FindFirst then begin
                    VendorLedgerEntry.CalcFields(Amount);
                    AgentComm := VendorLedgerEntry.Amount;
                    AgentComm := Abs(AgentComm);
                end;
            end;

            trigger OnPreDataItem()
            begin
                AgentCode := "Sky Agents Transactions".GetFilter("Sky Agents Transactions"."Agent Code");
                if AgentApplications.Get(AgentCode) then
                    AgentName := AgentApplications."Name of the Proposed Agent";
                if AgentCode = '' then begin
                    AgentCode := '0';
                    AgentName := 'All Agents';
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

    trigger OnPreReport()
    begin
        PrintedBy := UserId;
        Pos := StrPos(PrintedBy, '\');
        PrintedBy := CopyStr(PrintedBy, Pos + 1, 50);
        PrintedAt := CurrentDatetime;
    end;

    var
        AgentComm: Decimal;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PrintedBy: Code[50];
        PrintedAt: DateTime;
        Pos: Integer;
        AgentCode: Code[40];
        AgentName: Text;
        AgentApplications: Record "Agent Applications";
}
