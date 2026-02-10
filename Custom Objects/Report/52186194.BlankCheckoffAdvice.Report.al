namespace Mwanga.Mwanga;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 52186194 "Triggered Checkoff Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Triggered Checkoff Advice.rdl';

    dataset
    {
        dataitem("Triggered Advice Line"; "Triggered Advice Line")
        {
            RequestFilterFields = "Advice Header No.", "Advice Date", "Member No.";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {

            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {

            }
            column(Location; Location)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(City; City)
            {

            }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(SMSOnly; SMSOnly)
            {

            }
            column(Website; Website)
            {

            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(Client; Client)
            {

            }
            column(Period; Period)
            {

            }

            column(PFNumber; PFNumber)
            {

            }
            column(IDNO; IDNO)
            {

            }
            column(Name; Name)
            {

            }
            column(AmountOn; Round(AmountOn, 1, '>'))
            {

            }
            column(AmountOff; Round(AmountOff, 1, '>'))
            {

            }
            column(Balance; Round(Balance, 1, '<'))
            {

            }
            column(Reference; Reference)
            {

            }
            column(Remarks; Remarks)
            {

            }

            trigger OnAfterGetRecord()
            var
                CreditAccounts: Record "Credit Accounts";
                Accounts: Record "Savings Accounts";
            begin
                if "Triggered Advice Line"."Advice Type" = "Triggered Advice Line"."Advice Type"::Adjustment then begin
                    "Triggered Advice Line"."Balance Off" := 0;
                end;

                Period := "Triggered Advice Line".Period + ' ' + Format(Date2DMY("Triggered Advice Line"."Advice Date", 3));
                if Customer.Get("Triggered Advice Line"."Employer Code") then
                    Client := Customer.Name;

                if Members.Get("Member No.") then begin
                    PFNumber := Members."Payroll/Staff No.";
                    IDNO := Members."Primary Identification";
                    Name := Members.Name;

                end;
                AmountOn := "Amount On";
                AmountOff := "Amount Off";
                Balance := "Balance On";

                if CreditAccounts.Get("Account No.") then
                    Reference := CreditAccounts."Product Type" + "Member No." + MonthShortForm("Advice Date");

                if Accounts.Get("Account No.") then begin
                    case Accounts."Product Category" of
                        Accounts."Product Category"::"Benevolent (BBF)":
                            begin
                                Reference := 'BBF';
                            end;
                        Accounts."Product Category"::"BOSA Deposits":
                            begin
                                Reference := 'SHARES';
                            end;
                        Accounts."Product Category"::Risk:
                            begin
                                Reference := 'RISK';
                            end;
                    end;
                end;

                case "Advice Type" of
                    "Triggered Advice Line"."Advice Type"::New:
                        begin
                            Remarks := 'RECOVER';
                        end;
                    "Triggered Advice Line"."Advice Type"::"New Loan":
                        begin
                            Remarks := 'RECOVER';
                        end;
                    "Triggered Advice Line"."Advice Type"::Variations:
                        begin
                            Remarks := 'VARY RATE';
                        end;
                    else
                        Remarks := UpperCase(Format("Triggered Advice Line"."Advice Type"));
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        Location := CompanyInformation.Address;
        CompanyAddress := CompanyInformation."Address 2";
        City := CompanyInformation.City;
        CompanyTelephone := CompanyInformation."Phone No.";
        Website := CompanyInformation.Website;

        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    var
        //columns
        CompanyName: Text;
        BuldingName: Text;
        Location: Text;
        CompanyAddress: Text;
        City: Text;
        CompanyTelephone: Text;
        SMSOnly: Label '20156';
        Website: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];
        Client: Text;
        Period: Text;

        //Columns Data Items
        PFNumber: Text;
        IDNO: Text;
        Name: Text;
        AmountOn: Decimal;
        AmountOff: Decimal;
        Balance: Decimal;
        Reference: Text;
        Remarks: Text;



        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        Members: Record Members;
        PeriodText: Text;
        Customer: Record Customer;

    procedure MonthShortForm(Date: Date): Text
    var
        Month: Integer;
        Year: Integer;
    begin
        Month := Date2DMY(Date, 2);
        Year := Date2DMY(Date, 3);

        case Month of
            1:
                begin
                    exit('JAN' + Format(Year));
                end;
            2:
                begin
                    exit('FEB' + Format(Year));
                end;
            3:
                begin
                    exit('MAR' + Format(Year));
                end;
            4:
                begin
                    exit('APR' + Format(Year));
                end;
            5:
                begin
                    exit('MAY' + Format(Year));
                end;
            6:
                begin
                    exit('JUN' + Format(Year));
                end;
            7:
                begin
                    exit('JUL' + Format(Year));
                end;
            8:
                begin
                    exit('AUG' + Format(Year));
                end;
            9:
                begin
                    exit('SEP' + Format(Year));
                end;
            10:
                begin
                    exit('OCT' + Format(Year));
                end;
            11:
                begin
                    exit('NOV' + Format(Year));
                end;
            12:
                begin
                    exit('DEC' + Format(Year));
                end;
        end;
    end;

}
