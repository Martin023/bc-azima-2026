Report 52187407 "Member Shares Analysis"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Member Shares Analysis';
    RDLCLayout = './bc-kenpipe-2024/Layout/Member shares Analysis.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = sorting("No.") where("Balance (LCY)" = filter(<> 0));
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(CompanyName; Company.Name)
            {
            }
            column(Count1; Count1)
            {
            }
            column(Count2; Count2)
            {
            }
            column(Count3; Count3)
            {
            }
            column(Count4; Count4)
            {
            }
            column(Count5; Count5)
            {
            }
            column(Count6; Count6)
            {
            }
            column(Account2; Acount2)
            {
            }
            column(Account3; Acount3)
            {
            }
            column(Account4; Acount4)
            {
            }
            column(Account5; Acount5)
            {
            }
            column(Account6; Acount6)
            {
            }
            column(Faccount2; Facount2)
            {
            }
            column(Faccount3; Facount3)
            {
            }
            column(Faccount4; Facount4)
            {
            }
            column(Faccount5; Facount5)
            {
            }
            column(Faccount6; Facount6)
            { }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(picture; CompanyInformation.Picture)
            {
            }

            column(Bal2; Bal2)
            {
            }
            column(Bal3; Bal3)
            {
            }
            column(Bal4; Bal4)
            {
            }
            column(Bal5; Bal5)
            {
            }
            column(Bal6; Bal6)
            {
            }

            column(Abal2; Abal2)
            {
            }
            column(Abal3; Abal3)
            {
            }
            column(Abal4; Abal4)
            {
            }
            column(Abal5; Abal5)
            {
            }
            column(Abal6; Abal6)
            {
            }
            column(Fbal2; Fabal2)
            {
            }
            column(Fbal3; Fabal3)
            {
            }
            column(Fbal4; Fabal4)
            {
            }
            column(Fbal5; Fabal5)
            {
            }
            column(Fbal6; Fabal6)
            {
            }
            column(GrandCount; Grandcount)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if ASAT = 0D then
                    ASAT := Today;

                DFilter := '01/01/14..' + Format(ASAT);
                SavingsAcc.Reset();
                SavingsAcc.SetRange("No.", "Savings Accounts"."No.");
                SavingsAcc.SetFilter("Date Filter", DFilter);
                SavingsAcc.SetRange(SavingsAcc."Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
                if SavingsAcc.Find('-') then begin
                    repeat

                        SavingsAcc.CalcFields(SavingsAcc."Balance (LCY)");
                        // Shares := (SavingsAcc."Balance (LCY)");
                        // if Shares <= 100000 then begin
                        //     Bal2 := Bal2 + Shares;
                        //     Count2 := Count2 + 1;
                        // end else
                        //     if (Shares > 100000.01) and (Shares <= 300000) then begin
                        //         Bal3 := Bal3 + Shares;
                        //         Count3 := Count3 + 1;
                        //     end else
                        //         if (Shares > 300000.01) and (Shares <= 600000) then begin
                        //             Bal4 := Bal4 + Shares;
                        //             Count4 := Count4 + 1;
                        //         end else
                        //             if (Shares > 600000.01) and (Shares <= 900000) then begin
                        //                 Bal5 := Bal5 + Shares;
                        //                 Count5 := Count5 + 1;
                        //             end else
                        //                 if Shares > 900000.01 then begin
                        //                     Bal6 := Bal6 + Shares;
                        //                     Count6 := Count6 + 1;
                        //                 end;
                        // if SavingsAcc."Loan Disbursement Account" = true then begin
                        Balance := (SavingsAcc."Balance (LCY)");
                        if Balance <= 100000 then begin
                            Abal2 := Abal2 + Balance;
                            Acount2 := Acount2 + 1;
                        end else
                            if (Balance > 300000.01) and (Balance <= 300000) then begin
                                Abal3 := Abal3 + Balance;
                                Acount3 := Acount3 + 1;
                            end else
                                if (Balance > 300000.01) and (Balance <= 600000) then begin
                                    Abal4 := Abal4 + Balance;
                                    Acount4 := Acount4 + 1;
                                end else
                                    if (Balance > 600000.01) and (Balance <= 900000) then begin
                                        Abal5 := Abal5 + Balance;
                                        Acount5 := Acount5 + 1;
                                    end else
                                        if Balance > 900000.01 then begin
                                            Abal6 := Abal6 + Balance;
                                            Acount6 := Acount6 + 1;
                                        end;

                    //end;
                    //else
                    // if SavingsAcc."Product Category" = SavingsAcc."product category"::"Fixed Deposit" then begin
                    //     Fbalance := SavingsAcc."Balance (LCY)";
                    //     if Fbalance > 0 then begin
                    //         if Fbalance <= 100000 then begin
                    //             Fabal2 := Fabal2 + Fbalance;
                    //             Facount2 := Facount2 + 1;
                    //         end else
                    //             if (Fbalance > 100000.01) and (Fbalance <= 300000) then begin
                    //                 Fabal3 := Fabal3 + Fbalance;
                    //                 Facount3 := Facount3 + 1;
                    //             end else
                    //                 if (Fbalance > 300000.01) and (Fbalance <= 600000) then begin
                    //                     Fabal4 := Fabal4 + Fbalance;
                    //                     Facount4 := Facount4 + 1;
                    //                 end else
                    //                     if (Fbalance > 600000.01) and (Fbalance <= 900000) then begin
                    //                         Fabal5 := Fabal5 + Fbalance;
                    //                         Facount5 := Facount5 + 1;
                    //                     end else
                    //                         if Fbalance > 900000 then begin
                    //                             Fabal6 := Fabal6 + Fbalance;
                    //                             Facount6 := Facount6 + 1;
                    //                         end;
                    //     end;

                    //end;

                    until SavingsAcc.Next() = 0;

                end;


                //Take care of fixed

                GrandTotal := Bal2 + Bal3 + Bal4 + Bal5 + Bal6 + Abal2 + Abal3 + Abal4 + Abal5 + Abal6;
                Grandcount := Count2 + Count3 + Count4 + Count5 + Count5 + Count6 + Acount2 + Acount3 + Acount4 + Acount5 + Acount6
             + Facount2 + Facount3 + Facount4 + Facount5 + Facount6;


            end;


            // trigger OnPostDataItem()
            // begin
            //     Message('%1 %2 %3 %4 %5', Count2, Count3, Count4, Count5 + Count6);
            // end;

            trigger OnPreDataItem()
            begin
                Company.Get;
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
                field(ASAT; ASAT)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At..............';
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
    var
        myInt: Integer;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        Less50000: Decimal;
        Facount6: Integer;
        "50000 to 10000": Decimal;
        "10000 t0 300000": Decimal;
        "300000 to 100000": Decimal;
        "over 1000000": Decimal;
        Acount6: Integer;
        Fabal6: Decimal;
        Abal6: Decimal;
        Account: Record "Savings Accounts";
        "Less50000-a/c": Decimal;
        Bal6: Decimal;
        "50000 to 10000-a/c": Decimal;
        "10000 t0 300000-a/c": Decimal;
        "300000 to 100000-a/c": Decimal;
        "over 1000000-a/c": Decimal;
        cust: Record "Savings Accounts";
        Shares: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyNam: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CountN: Integer;

        Bal2: Decimal;
        Bal3: Decimal;
        Bal4: Decimal;
        Bal5: Decimal;
        Count1: Integer;
        Count2: Integer;
        Count3: Integer;
        Count4: Integer;
        Count5: Integer;
        Count6: Integer;
        Abal2: Decimal;
        Abal3: Decimal;
        Abal4: Decimal;
        Abal5: Decimal;
        Acount2: Integer;
        Acount3: Integer;
        Acount4: Integer;
        Acount5: Integer;
        Balance: Decimal;
        Fabal2: Decimal;
        Fabal3: Decimal;
        Fabal4: Decimal;
        Fabal5: Decimal;
        Facount1: Integer;
        Facount2: Integer;
        Facount3: Integer;
        Facount4: Integer;
        Facount5: Integer;
        Fbalance: Decimal;
        GrandTotal: Decimal;
        Grandcount: Integer;
        DFilter: Text[50];
        ASAT: Date;
        Company: Record "Company Information";
        SavingsAcc: Record "Savings Accounts";
}

