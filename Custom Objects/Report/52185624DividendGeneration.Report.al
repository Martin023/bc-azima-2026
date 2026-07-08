#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185624 "Dividend Generation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Dividend Header"; "Dividend Header")
        {
            RequestFilterFields = "No.";

            dataitem("Savings Accounts"; "Savings Accounts")
            {
                RequestFilterFields = "Member No.", "Product Type", "Employer Code", "No.";
                trigger OnAfterGetRecord()
                begin
                    // SavingsAccounts.Reset();
                    // SavingsAccounts.SetRange("Product Type", '4|1|3');
                    // if SavingsAccounts.Findset then begin
                    intProgressTotal := "Savings Accounts".Count;
                    intProgressI := 0;
                    TimeProgress := Time;
                    NoOfRecsProgress := intProgressTotal DIV 100;
                    NoOfProgressed := 0;

                    diaProgress.Open(GeneratingDividends + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                    // repeat
                    DividendProgression.Reset;
                    DividendProgression.SetRange(DividendProgression."Header No.", "Dividend Header"."No.");
                    DividendProgression.SetRange("Account No", "Savings Accounts"."No.");
                    DividendProgression.DeleteAll(true);

                    intProgressI += 1;
                    if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                        NoOfProgressed := NoOfProgressed + intProgressI;
                        diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                        intProgressI := 0;
                        TimeProgress := Time;
                    end;
                    DividendProcess.generateDivdends("Savings Accounts", "Dividend Header");

                    // until SavingsAccounts.Next() = 0;
                    // end;
                end;
            }


            trigger OnPostDataItem()
            begin
                diaProgress.Close;
                Message('Transaction generated succesfully');
            end;

            trigger OnPreDataItem()
            begin
                //"Savings Accounts".SetFilter("Product Type", 'DCS|SCS');

                // if Codeunit.Run(Codeunit::"Dividends Job Queue Manager", "Savings Accounts") then begin
                //     Message('Dividend generation process initiated successfully. It will run in the background');
                // end;
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

            }
        }


    }

    labels
    {
    }

    trigger OnPostReport()
    var
        DividendProcess: Codeunit "Dividend Process";
        Members: Record "Members";
    begin
        //ERROR('Contact ICT');
    end;

    trigger OnPreReport()
    var

    begin
    end;

    var
        DividendProgression: Record "Dividend Progression";
        DividendProcess: Codeunit "Dividend Process";
        intProgressTotal: Integer;
        diaProgress: Dialog;
        intProgressI: Integer;
        GeneratingDividends: label 'Generating Dividends';
        intProgress: Integer;
        TimeProgress: Time;
        NoOfProgressed: Integer;
        NoOfRecsProgress: Integer;
        DividendSetUp: Record "Dividend SetUp";
    //SavingsAccounts: Record "Savings Accounts";
}
