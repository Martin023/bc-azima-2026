report 52185429 "Perfection Register"
{
    ApplicationArea = All;
    Caption = 'Perfection Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Perfection Register.rdl';
    dataset
    {
        dataitem(SecurityPerfection; "Security Perfection")
        {
            RequestFilterFields = "No.", "Loan No.", "Lending Unit";
            column(No; "No.")
            {
            }
            column(SecurityNo; SecurityNo)
            {
            }
            column(PropertyNumber; LinesPropertyNo)
            {
            }
            column(AmountToCharge; "Amount To Charge")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Collateral_Types; "Collateral Types")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanName; "Loan Name")
            {
            }
            column(Loan_No_; "Loan No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(ChargeType; ChargeType)
            {
            }
            column(MarketValue; MarketValue)
            {
            }
            column(LinesCollateralValue; LinesCollateralValue)
            {

            }
            column(ForceSaleValue; ForceSaleValue)
            {
            }
            column(LinesCollateral_Types; LinesCollateral_Types)
            {
            }

            column(PerfectionStage; "Perfection Stage")
            {
            }

            column(ValuationComments; "Valuation Comments")
            {
            }
            column(Date_of_Registration; "Date Perfected")
            {
            }
            column(PerfectionNo; PerfectionNo)
            {
            }
            column(ActiononFile; ActiononFile)
            {
            }
            column(FileTAT; FileTAT)
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
            // dataitem(PerfectionLinesTable; "Perfection Lines")
            // {
            //     DataItemLinkReference = SecurityPerfection;
            //     DataItemLink = "Loan No." = field("Loan No.");
            //     column(SecurityNo; PerfectionLines."Security No.") { }
            //     column(PropertyNumber; PerfectionLines."Property No.") { }
            //     column(AmountToCharge; PerfectionLines."Amount to Charge") { }
            //     column(MemberNo; PerfectionLines."Member No.") { }
            //     column(Collateral_Types; Format(PerfectionLines."Collateral Types")) { }
            //     ///column(Amount; PerfectionLines.Amount) { }
            //     column(ChargeType; PerfectionLines."Charge Type") { }
            //     column(MarketValue; PerfectionLines."Market Value") { }
            //     column(LinesCollateralValue; PerfectionLines."Collateral Value Sum") { }
            //     column(ForceSaleValue; PerfectionLines."Forced Sale Value") { }
            //     column(LinesCollateral_Types; Format(PerfectionLines."Collateral Types")) { }

            // }
            // dataitem(FileActions; "Perfection File Action")
            // {
            //     DataItemLinkReference = SecurityPerfection;
            //     DataItemLink = "Perfection No." = field("No.");
            //     column(PerfectionNo; "Perfection No.") { }
            //     column(ActiononFile; "Action On File") { }
            //     column(FileTAT; TAT) { }
            // }


            trigger OnAfterGetRecord()
            begin
                ActionNo := 0;
                ActiononFile := ActiononFile::" ";
                FileTAT := '';
                PerfectionNo := '';
                SecurityNo := '';
                LinesPropertyNo := '';
                Amount_To_Charge := 0;
                LinesCollateralValue := 0;
                MarketValue := 0;
                LinesCollateralValue := 0;
                ForceSaleValue := 0;
                LinesCollateral_Types := '';
                ChargeType := '';


                PerfectionLines.RESET;
                //PerfectionLines.SETRANGE("Loan No.", SecurityPerfection."Loan No.");
                FileActions.SETRANGE("Perfection No.", SecurityPerfection."No.");
                if PerfectionLines.find('-') then begin
                    repeat
                        //LinesLoanNo := PerfectionLines."Loan No.";
                        SecurityNo := PerfectionLines."Security No.";
                        LinesPropertyNo := PerfectionLines."Property No.";
                        Amount_to_Charge := PerfectionLines."Amount to Charge";
                        LinesCollateralValue := PerfectionLines."Collateral Value Sum";
                        MarketValue := PerfectionLines."Market Value";
                        LinesCollateralValue := PerfectionLines."Collateral Value Sum";
                        ForceSaleValue := PerfectionLines."Forced Sale Value";
                        LinesCollateral_Types := Format(PerfectionLines."Collateral Types");
                        ChargeType := PerfectionLines."Charge Type";



                    until PerfectionLines.Next = 0;
                end;

                FileActions.RESET;
                FileActions.SETRANGE("Perfection No.", SecurityPerfection."No.");
                if FileActions.find('-') then begin
                    repeat
                        PerfectionNo := FileActions."Perfection No.";
                        ActiononFile := FileActions."Action On File";
                        FileTAT := FileActions.TAT;
                    until FileActions.Next = 0;
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
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
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ActionNo: Integer;
        ActiononFile: Enum "Perfection Stages";
        FileTAT: CODE[20];
        //FileTAT: iNTEGER;
        FileActions: Record "Perfection File Action";
        PerfectionNo: code[20];
        Duration: Text;
        PerfectionLines: Record "Perfection Lines";
        LinesCollateral_Types: Code[200];
        ForceSaleValue: Decimal;
        MarketValue: Decimal;
        LinesCollateralValue: Decimal;
        Amount_to_Charge: Decimal;
        LinesPropertyNo: Code[200];
        SecurityNo: Code[200];
        MemberNo: Code[200];
        ChargeType: Code[100];
}
