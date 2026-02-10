#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185647 "Get Salary RTGS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Get Salary EFT.rdl';

    dataset
    {
        dataitem("RTGS Transfer Header"; "RTGS Transfer Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("Savings Accounts"; "Savings Accounts")
            {
                CalcFields = Balance, "Uncleared Cheques", "Authorised Over Draft", "ATM Transactions", "Lien Placed";
                //DataItemTableView = sorting("No.") where("Product Category" = filter(" "), "Enable Sweeping" = const(Yes));
                //RequestFilterFields = "No.", "Date Filter", "Document No. Filter";
                column(ReportForNavId_2; 2)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    AvailableBal := 0;
                    MinBal := 0;
                    SalaryDed := 0;
                    SalaryRTGSAmount := 0;

                    if ProdTypes.Get("Savings Accounts"."Product Type") then begin
                        MinBal := ProdTypes."Minimum Balance";


                        AvailableBal := ("Savings Accounts".Balance + "Savings Accounts"."Authorised Over Draft") - ("Savings Accounts"."Uncleared Cheques"
                                    + "Savings Accounts"."Lien Placed" + "Savings Accounts"."ATM Transactions" + MinBal + 275);
                    end;
                    //MESSAGE('The available balance is %1',AvailableBal);
                    //Get the Deductions done on processing
                    TransferAmnt := 0;

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange(SavingsAccount."No.", "Savings Accounts"."No.");
                    SavingsAccount.SetFilter(SavingsAccount."Document No. Filter", "Savings Accounts".GetFilter("Savings Accounts"."Document No. Filter"));
                    SavingsAccount.SetFilter(SavingsAccount."Date Filter", "Savings Accounts".GetFilter("Savings Accounts"."Date Filter"));
                    if SavingsAccount.Find('-') then begin
                        //MESSAGE('Checked');
                        SavingsAccount.CalcFields(SavingsAccount."Debit Amount (LCY)", SavingsAccount."Credit Amount (LCY)");
                        SalaryDed := SavingsAccount."Debit Amount (LCY)" + MinBal;
                        SalaryRTGSAmount := SavingsAccount."Credit Amount (LCY)";
                        TransferAmnt := SalaryRTGSAmount - SalaryDed;
                        //MESSAGE('The Deduction from the salary is %1 and the RTGS amount is %2 and transfer amount is%3',SalaryDed,SalaryRTGSAmount,TransferAmnt);
                    end;



                    //IF ((SalaryRTGSAmount-SalaryDed) - 100) > AvailableBal THEN
                    //SalaryRTGSAmount:=AvailableBal
                    //ELSE
                    //SalaryRTGSAmount:=((SalaryRTGSAmount-SalaryDed) - 100);

                    //MESSAGE('The salary RTGS amount is %1',TransferAmnt);

                    if TransferAmnt > 0 then begin

                        if TransferAmnt > AvailableBal then
                            TransferAmnt := AvailableBal else
                            TransferAmnt := TransferAmnt;

                        //IF TransferAmnt<AvailableBal THEN BEGIN

                        //MESSAGE('The transfer amount is %1',TransferAmnt);

                        RTGSLines.Init;
                        RTGSLines.No := '';
                        RTGSLines."Document No." := "RTGS Transfer Header"."No.";
                        RTGSLines."Account Type" := RTGSLines."account type"::Savings;
                        RTGSLines."Account No." := "Savings Accounts"."No.";
                        RTGSLines."Account Name" := "Savings Accounts".Name;
                        RTGSLines."Member No." := "Savings Accounts"."Member No.";
                        RTGSLines.Amount := TransferAmnt;
                        //RTGSLines."Charge Amount":=250;
                        //MESSAGE('The amount is %1',RTGSLines.Amount);
                        RTGSLines."External Account No." := "Savings Accounts"."External Account No";
                        //RTGSLines."Branch Code":="Savings Accounts"."Bank Code";
                        RTGSLines."Bank Code" := "Savings Accounts"."Bank Code";
                        RTGSLines."External Account Name" := "Savings Accounts".Name;
                        RTGSLines.Insert(true);


                        RTGSLines.Reset;
                        RTGSLines.SetRange(RTGSLines."Document No.", "RTGS Transfer Header"."No.");
                        RTGSLines.SetRange(RTGSLines."Account No.", "Savings Accounts"."No.");
                        if RTGSLines.Find('-') then begin
                            RTGSLines.Validate(RTGSLines."Branch Code");
                            RTGSLines.Validate(RTGSLines."Account No.");
                            RTGSLines.Validate(RTGSLines.Amount);
                            RTGSLines.Modify;
                        end;


                        //END;
                    end;
                end;

                trigger OnPostDataItem()
                begin

                    Message('The RTGS Batch has been Completed sucessfully');
                end;
            }
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
        ProdTypes: Record "Product Factory";
        SavingsAccount: Record "Savings Accounts";
        SalaryRTGSAmount: Decimal;
        SalaryDed: Decimal;
        AvailableBal: Decimal;
        RTGSLines: Record "RTGS Transfer Lines";
        MinBal: Decimal;
        TransferAmnt: Decimal;
}
