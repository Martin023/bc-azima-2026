#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186880 "All Investments Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/All Investments Report.rdl';

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where(Posted = filter(true), Status = filter(Fulfilled | Matured), "Deposit Type" = filter(<> Shares));
            RequestFilterFields = "Investment Type Code", "Period Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(SCount; SNo)
            {
            }
            column(Investment_No; "Investment No")
            {
            }
            column(Investment_Type_Code; "Investment Type Code")
            {
            }
            column(Investment_Type_Description; "Investment Type Description")
            {
            }
            column(Interest_Rate; "Interest Rate")
            {
            }
            column(Investment_Date; "Investment Date")
            {
            }
            column(Tenor; Tenor)
            {
            }
            column(Deposit_Type; "Deposit Type")
            {

            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }
            column(Institution_Name; "Institution Name")
            {
            }
            column(Institution; Institution)
            {
            }
            column(Maturity_Date; "Maturity Date")
            {
            }
            column(EndDate; EndDate) { }
            column(StartDate; StartDate) { }
            column(AmtInvested; AmtInvested) { }
            column(AmtReceived; AmtReceived) { }
            column(InterestEarned; InterestEarned) { }
            column(NoOfDays; NoOfDays) { }

            // trigger OnAfterGetRecord()
            // begin
            //     //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
            //     SNo += 1;
            // end;

            dataitem("Investment Lines"; "Investment Lines")
            {
                DataItemLink = "Investment No" = FIELD("Investment No");
                column(Face_Value; "Face Value")
                {
                }
                column(Interest_Amount; "Interest Amount")
                {
                }


            }
            trigger OnPreDataItem()
            begin
                "Investment Header".SetFilter("Date Posted", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                SNo += 1;

                NoOfDays := 0;

                Invheader.Reset();
                Invheader.SetRange(Invheader."Investment No", "Investment Header"."Investment No");
                if Invheader.Find('-') then begin
                    InvLines.Reset();
                    InvLines.SetRange("Investment No", Invheader."Investment No");
                    if InvLines.find('-') then begin
                        if calcdate('CM', Invheader."Investment Date") = calcdate('CM', today) then
                            NoOfDays := (calcdate('CM', today) - Invheader."Investment Date") + 1
                        else
                            // NoOfDays := calcdate('CM', today) - calcdate('-CM', today) + 1;
                            NoOfDays := ("Maturity Date" - "Investment Date") + 1;

                        RecptHeader.Reset();
                        RecptHeader.SetRange(RecptHeader.Investments, "Investment Header"."Investment No");
                        if RecptHeader.Find('-') then begin
                            RecptHeader.CalcFields("Invested Amount");
                            AmtInvested := RecptHeader."Invested Amount";
                            AmtReceived := RecptHeader."Amount Recieved";
                            // Desc := RecptHeader.Dim4;
                            PayDate := RecptHeader."Date Posted";
                        end;
                        InterestEarned := AmtReceived - AmtInvested;
                    end;
                end;
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
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = True;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        NoOfDays: Integer;
        ShowTotoDetail: Boolean;
        StartDate: Date;
        Invheader: Record "Investment Header";
        InvLines: Record "Investment Lines";
        EndDate: Date;
        AmtInvested: Decimal;
        AmtReceived: Decimal;
        RecptHeader: Record "Receipts Header";
        PayDate: Date;
        InterestEarned: Decimal;

}
