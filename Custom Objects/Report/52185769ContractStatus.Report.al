#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185769 "Contract Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Contract Status.rdl';

    dataset
    {
        dataitem(Contracts; Contracts)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(ContractNo_Contracts; Contracts."Contract No")
            {
            }
            column(Name_Contracts; Contracts."Contractor Name")
            {
            }
            column(StartDate_Contracts; Contracts."Start Date")
            {
            }
            column(EndDate_Contracts; Contracts."End Date")
            {
            }
            column(ContractValue_Contracts; Contracts."Contract Sum")
            {

            }


            column(SerialNo; SerialNo)
            {
            }
            column(ContractStatus; Contracts."Contract Description")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(ContractorNo_Contracts; Contracts."Contractor No")
            {
            }
            column(Type_Contracts; Contracts."Contractor Type")
            {
            }
            column(Balance_Contracts; Contracts.Balance)
            {
            }
            column(TotalBalance_Contracts; Contracts."Total Balance")
            {
            }
            // column(Category_Contracts;.Category)
            // {
            // }
            // column(RenewedContract_Contracts;Contracts."Renewed Contract")
            // {
            // }
            column(Terminated_Contracts; Contracts.Terminated)
            {
            }
            column(TerminationReason_Contracts; Contracts."Termination Reason")
            {
            }
            column(Status_Contracts; Contracts.Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SerialNo += 1;
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
        CompInfo.Reset;
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);
    end;

    var
        SerialNo: Integer;
        CompInfo: Record "Company Information";
}
