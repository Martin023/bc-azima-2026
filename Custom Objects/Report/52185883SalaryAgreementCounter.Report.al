#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185883 "Salary Agreement Counter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Salary Agreement Counter.rdl';

    dataset
    {
        dataitem("Salary Agreement Counter"; "Salary Agreement Counter")
        {
            column(RecrutedBy_SalaryAgreementCounter; "Salary Agreement Counter"."Recruted By")
            {
            }
            column(RecrutedByName_SalaryAgreementCounter; "Salary Agreement Counter"."Recruted By Name")
            {
            }
            column(Count_SalaryAgreementCounter; "Salary Agreement Counter".Count)
            {
            }
            column(period; period)
            {
            }
            column(FormatedDate; FormatedDate)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(BranchCode_SalaryAgreementCounter; "Salary Agreement Counter"."Branch Code")
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(period; period)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    TableRelation = "Interest Due Period";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        SalaryAgreementCounter.Reset;
        SalaryAgreementCounter.DeleteAll;
    end;

    trigger OnPreReport()
    begin
        if period = 0D then Error('Kindly selact a valid date');
        //MESSAGE(FORMAT(period));
        SalaryAgreement.Reset;
        SalaryAgreement.SetRange("With Effect From", period);
        SalaryAgreement.SetFilter(Status, '<>%1', SalaryAgreement.Status::Rejected);
        if SalaryAgreement.FindFirst then begin
            repeat

                if SalaryAgreementCounter.Get(SalaryAgreement."Recruited By") then begin
                    SalaryAgreementCounter.Count += 1;
                    SalaryAgreementCounter.Modify;
                end else begin
                    SalaryAgreementCounter.Init;
                    SalaryAgreementCounter."Recruted By" := SalaryAgreement."Recruited By";
                    SalaryAgreementCounter."Recruted By Name" := SalaryAgreement."Recruited By Name";
                    SalaryAgreementCounter."Branch Code" := SalaryAgreement."Branch Code";
                    SalaryAgreementCounter.Count := 1;
                    SalaryAgreementCounter.Insert;
                end;
            until SalaryAgreement.Next = 0;
        end;
        FormatedDate := Format(Date2dmy(period, 1)) + '/' + Format(Date2dmy(period, 2)) + '/' + Format(Date2dmy(period, 3));
    end;

    var
        period: Date;
        SalaryAgreement: Record "Salary Agreement";
        SalaryAgreementCounter: Record "Salary Agreement Counter";
        FormatedDate: Text;
        BranchCode: Code[20];
}
