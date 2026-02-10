report 52186037 "Member Receipt Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Receipt Report.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
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
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Primary_Identification; "Primary Identification")
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Status; Status) { }

            column(Risk; Risk)
            {
            }

            column(BBF; BBF)
            {
            }

            column(BosaDep; BosaDep)
            {
            }

            trigger OnAfterGetRecord()
            begin
                BBF := 0;
                Risk := 0;
                BosaDep := 0;
                CreatedBy := '';

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", Members."No.");
                if SavingAcc.FindFirst() then begin
                    repeat
                        case
                            SavingAcc."Product Category" of
                            SavingAcc."Product Category"::"BOSA Deposits":
                                begin
                                    SavLedgerEntry.Reset();
                                    SavLedgerEntry.SetRange("Customer No.", SavingAcc."No.");
                                    SavLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                                    SavLedgerEntry.CalcSums("Credit Amount (LCY)");
                                    BosaDep := SavLedgerEntry."Credit Amount (LCY)";
                                end;
                            SavingAcc."Product Category"::"Benevolent (BBF)":
                                begin
                                    SavLedgerEntry.Reset();
                                    SavLedgerEntry.SetRange("Customer No.", SavingAcc."No.");
                                    SavLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                                    SavLedgerEntry.CalcSums("Credit Amount (LCY)");
                                    BBF := SavLedgerEntry."Credit Amount (LCY)";
                                end;
                            SavingAcc."Product Category"::Risk:
                                begin
                                    SavLedgerEntry.Reset();
                                    SavLedgerEntry.SetRange("Customer No.", SavingAcc."No.");
                                    SavLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                                    SavLedgerEntry.CalcSums("Credit Amount (LCY)");
                                    Risk := SavLedgerEntry."Credit Amount (LCY)";
                                end;
                        end;
                    until SavingAcc.next = 0;
                end;
            end;

            trigger OnpreDataItem()
            begin
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('Please select the start date and end date');
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
                group(DateFilters)
                {
                    field("Start Date"; StartDate) { }
                    field("End date"; EndDate) { }
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
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
        Amount: decimal;
        SavingAcc: Record "Savings Accounts";
        BBF: Decimal;
        Risk: Decimal;
        CreatedBy: Text;
        //Members: Record Members;
        User: Record User;
        BosaDep: Decimal;
        ProdFact: Record "Product Factory";
        Creditledger: Record "Credit Ledger Entry";
        Loans: Record Loans;
        LatPaydate: Date;
        SavLatPaydate: Date;
        GlobalFunc: Codeunit "Global Functions";
        LastPrRep: Decimal;
        lastP: Text;
        LastInPaid: Decimal;
        SavLedgerEntry: Record "Savings Ledger Entry";
        StartDate: Date;
        EndDate: Date;





}
// dataitem("Savings Accounts"; "Savings Accounts")
// {
//     DataItemTableView = where("Product Category" = Filter("BOSA Deposits" | Risk | "Benevolent (BBF)"));

//     column(ReportForNavId_1; 1)
//     {
//     }
//     column(No_SavingsAccounts; "Savings Accounts"."No.")
//     {
//     }
//     column(Name_SavingsAccounts; "Savings Accounts".Name)
//     {
//     }
//     column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
//     {
//     }
//     column(GlobalDimension1Code_SavingsAccounts; "Savings Accounts"."Global Dimension 1 Code")
//     {
//     }
//     column(GlobalDimension2Code_SavingsAccounts; "Savings Accounts"."Global Dimension 2 Code")
//     {
//     }
//     column(Balance_SavingsAccounts; "Savings Accounts".Balance)
//     {
//     }
//     column(Member_No_; "Savings Accounts"."Member No.")
//     {
//     }
//     column(Product_Type; "Savings Accounts"."Product Type")
//     {
//     }
//     column(Product_Name; "Savings Accounts"."Product Name")
//     {
//     }
//     column(Status; "Savings Accounts".Status)
//     {
//     }
//     column(Employer_Code; "Employer Code")
//     {
//     }
//     column(Risk; Risk)
//     {
//     }

//     column(BBF; BBF)
//     {
//     }

//     column(BosaDep; BosaDep)
//     {
//     }

//     column(Last_Transaction_Date; "Savings Accounts"."Last Transaction Date")
//     {
//     }
//     column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
//     {
//     }
//     column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
//     {
//     }
//     column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
//     {
//     }
//     column(ATMTransactions_SavingsAccounts; "Savings Accounts"."ATM Transactions")
//     {
//     }
//     column(ATMNo_SavingsAccounts; "Savings Accounts"."ATM No.")
//     {
//     }

//     column(AccNo; "Savings Accounts".Balance)
//     {
//     }
//     column(sno; SNo)
//     {
//     }
//     column(Amount; Amount)
//     {

//     }
//     column(Monthly_Contribution; "Monthly Contribution")
//     {

//     }
//     column(CompanyInformation_Name; CompanyInformation.Name)
//     {
//     }
//     column(CompanyInformation_Picture; CompanyInformation.Picture)
//     {
//     }
//     column(CompanyAddress; CompanyAddress)
//     {
//     }
//     column(CompanyTelephone; CompanyTelephone)
//     {
//     }
//     column(CommunicationOnline; CommunicationOnline)
//     {
//     }
//     column(LastPrRep; LastPrRep)
//     {

//     }
//     column(LastInPaid; LastInPaid)
//     {

//     }

//     trigger OnAfterGetRecord()
//     begin
//         SNo += 1;
//         BBF := 0;
//         Risk := 0;
//         BosaDep := 0;
//         CreatedBy := '';

//         User.Reset;
//         User.SetRange("User Name", Members."Created By");
//         if User.Find('-') then begin
//             CreatedBy := User."Full Name";
//         end;

//         /// Upates MIM
//         //if "Savings Accounts".GetFilters() <>''

//         case
//             "Savings Accounts"."Product Category" of
//             "Savings Accounts"."Product Category"::"BOSA Deposits":
//                 begin
//                     SavLedgerEntry.Reset();
//                     SavLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
//                     SavLedgerEntry.setfilter("Date Filter", '%1', "Savings Accounts"."Date Filter");
//                     //SavLedgerEntry.setfilter("Credit Amount (LCY)", '>%1', 0);
//                     SavLedgerEntry.CalcSums("Credit Amount (LCY)");
//                     BosaDep := SavLedgerEntry."Credit Amount (LCY)";
//                 end;
//             "Savings Accounts"."Product Category"::"Benevolent (BBF)":
//                 begin
//                     SavLedgerEntry.Reset();
//                     SavLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
//                     SavLedgerEntry.setfilter("Date Filter", '%1', "Savings Accounts"."Date Filter");
//                     //SavLedgerEntry.setfilter("Credit Amount (LCY)", '>%1', 0);
//                     SavLedgerEntry.CalcSums("Credit Amount (LCY)");
//                     BBF := SavLedgerEntry."Credit Amount (LCY)";
//                 end;
//             "Savings Accounts"."Product Category"::Risk:
//                 begin
//                     SavLedgerEntry.Reset();
//                     SavLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
//                     SavLedgerEntry.setfilter("Date Filter", '%1', "Savings Accounts"."Date Filter");
//                     //SavLedgerEntry.setfilter("Credit Amount (LCY)", '>%1', 0);
//                     SavLedgerEntry.CalcSums("Credit Amount (LCY)");
//                     Risk := SavLedgerEntry."Credit Amount (LCY)";
//                 end;



//         end;


//         // SavingAcc.Reset;
//         // SavingAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
//         // SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
//         // if SavingAcc.Find('-') then begin
//         //     SavLedgerEntry.Reset();
//         //     SavLedgerEntry.SetRange("Customer No.");
//         //     SavingAcc.CalcFields(Balance);
//         //     BosaDep := SavingAcc.Balance;
//         // end;


//         // SavingAcc.Reset;
//         // SavingAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
//         // SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Benevolent (BBF)");
//         // if SavingAcc.Find('-') then begin
//         //     SavingAcc.CalcFields(Balance);
//         //     BBF := SavingAcc.Balance;
//         // end;

//         // SavingAcc.Reset();
//         // SavingAcc.SetRange("Product Category", "Savings Accounts"."Product Category"::Risk);
//         // SavingAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
//         // if SavingAcc.Find('-') then begin
//         //     SavLedgerEntry.Reset;
//         //     SavLedgerEntry.SetRange("Member No.", SavingAcc."Member No.");
//         //     SavLedgerEntry.SetRange("Customer No.", SavingAcc."No.");
//         //     if SavLedgerEntry.FindLast() then begin
//         //         SavLatPaydate := SavLedgerEntry."Posting Date";
//         //         Risk := SavLedgerEntry.Amount;
//         //         // if SavLatPaydate <> 0D then
//         //         //     lastP := GlobalFunc.FormatDate(LatPaydate);
//         //     end;
//         // end;

//         Creditledger.Reset();
//         Creditledger.SetRange("Loan No", Loans."Loan No.");
//         Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::Repayment);
//         if Creditledger.FindLast() then begin
//             LatPaydate := Creditledger."Posting Date";
//             LastPrRep := Creditledger.Amount;
//             if LatPaydate <> 0D then
//                 lastP := GlobalFunc.FormatDate(LatPaydate);
//         end;

//         Creditledger.Reset();
//         Creditledger.SetRange("Loan No", Loans."Loan No.");
//         Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Interest Paid");
//         if Creditledger.FindLast() then begin
//             LastInPaid := Creditledger.Amount;
//         end;



//     end;

// }
