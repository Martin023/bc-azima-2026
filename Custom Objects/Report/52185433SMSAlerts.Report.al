#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185433 "SMS Alerts"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Balance", "Outstanding Interest", "Outstanding Bills";

            RequestFilterFields = "Loan No.", "Member No.", "Employer Code";

            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            trigger OnAfterGetRecord()
            var
                LoansProcess: Codeunit "Loans Process";


            begin
                "Days In Arrears" := SimulatedDaysInArreas;
                LoansProcess.SendArrersSMS(Loans, SMSTemplates, "Days In Arrears", SimulatedTodaysDate, false);

                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.Close();
            end;

            trigger OnPreDataItem()
            begin
                if SimulatedTodaysDate = 0D then
                    SimulatedTodaysDate := Today;


                intProgressTotal := COUNT;
                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;
                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(SimulatedTodaysDate; SimulatedTodaysDate)
                {
                }
                field(SimulatedDaysInArreas; SimulatedDaysInArreas)
                {
                }

            }
        }
    }

    trigger OnPreReport()
    begin
        AsAt := today;
        SMSTemplates.Reset();
        SMSTemplates.SetRange(Recepient, SMSTemplates.Recepient::Lonee);
        SMSTemplates.SetRange(SMSTemplates."Notice Type", SMSTemplates."Notice Type"::SMS);
        SMSTemplates.SetRange(SMSTemplates."Notice Category", SMSTemplates."Notice Category"::"Arrears Alert");
        if SMSTemplates.FindFirst() then begin
        end;
    end;



    var
        RunLoan: Boolean;
        SimulatedTodaysDate: Date;
        ProgressWindow: Dialog;
        Counter: Integer;
        AsAt: Date;
        DaysInArrears: Decimal;
        SimulatedDaysInArreas: Integer;
        SMSTemplates: Record "DMU SMS Templates";



        //Progress Variables
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;
}
