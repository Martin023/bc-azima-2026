Report 52187382 "Investment and Interest Income"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Investment and Interest Income.rdl';
    usagecategory = Lists;
    ApplicationArea = All;

    dataset
    {
        dataitem("Investment Interest Header"; "Investment Interest Header")
        {
            DataItemTableView = where(Posted = filter(true));

            dataitem("Investment Interest Lines"; "Investment Interest Lines")
            {
                //DataItemTableView = where(Posted = filter(true));
                DataItemLink = "Investment Header No" = field("No.");
                column(No; No)
                {
                }
                column(Investment_No; "Investment No")
                {
                }
                column(Account_No; "Account No")
                {
                }
                column(Account_Name; "Account Name")
                {
                }
                column(Accrued_Interest_Amount; "Accrued Interest Amount")
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
                column(JanAmount; JanAmount) { }
                column(FebAmount; FebAmount) { }
                column(MarAmount; MarAmount) { }
                column(AprAmount; AprAmount) { }
                column(MayAmount; MayAmount) { }
                column(JunAmount; JunAmount) { }
                column(JulyAmount; JulyAmount) { }
                column(AugAmount; AugAmount) { }
                column(SeptAmount; SeptAmount) { }
                column(OctAmount; OctAmount) { }
                column(NovAmount; NovAmount) { }
                column(DecAmount; DecAmount) { }

                trigger OnAfterGetRecord()
                begin
                    // for I := 1 to Months.Count
                    // do
                    //     message('%1,%2', Months.get(I), I);
                    case CalcDate('<-CM>', "Investment Interest Header"."Posting Date") of
                        Months.Get(1):
                            JanAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(2):
                            FebAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(3):
                            MarAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(4):
                            AprAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(5):
                            MayAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(6):
                            JunAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(7):
                            JulyAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(8):
                            AugAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(9):
                            SeptAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(10):
                            OctAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(11):
                            NovAmount := "Investment Interest Lines"."Accrued Interest Amount";
                        Months.Get(12):
                            DecAmount := "Investment Interest Lines"."Accrued Interest Amount";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    if CompanyInformation.Get then
                        CompanyInformation.CalcFields(CompanyInformation.Picture);
                    CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
                    CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
                    CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
                end;
            }

            trigger OnAfterGetRecord()
            begin

            end;
        }

    }

    requestpage
    {
        SaveValues = true;
        // SaveValues = true;

        layout
        {
            area(content)
            {
                field(InvestMentYear; InvestMentYear)
                {
                    ApplicationArea = Basic;
                    Caption = 'Investment Year';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        if Strlen(format(InvestMentYear)) <> 4 then
            error('Please Input valid Year!');

        clear(months);
        I := 1;
        repeat
            if StrLen(format(I)) < 2 then
                CurrMonth := '0' + format(I)
            else
                CurrMonth := Format(I);
            Evaluate(ConvertedDate, (Format(InvestMentYear) + '-' + CurrMonth + '-01'));
            Months.Add(I, ConvertedDate);
            //Message('%1', Months.get(I));
            I += 1;
        until I = 13;
    end;

    var

        InvestMentYear: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        JanAmount: Decimal;
        FebAmount: Decimal;
        MarAmount: Decimal;
        AprAmount: Decimal;
        MayAmount: Decimal;
        JunAmount: Decimal;
        JulyAmount: Decimal;
        AugAmount: Decimal;
        SeptAmount: Decimal;
        OctAmount: Decimal;
        NovAmount: Decimal;
        DecAmount: Decimal;
        ConvertedDate: date;
        I: Integer;
        Months: Dictionary of [integer, Date];
        CurrMonth: text;
}

