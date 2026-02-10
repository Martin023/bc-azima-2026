report 52187319 "Lease Contract Report"
{
    ApplicationArea = All;
    Caption = 'Lease Contract Report';
    DefaultLayout = Word;
    WordLayout = './bc-azima-2026/Layout/Lease Contract Report.docx';

    //UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Contracts; Contracts)
        {
            RequestFilterFields = "Contract No";
            // DataItemTableView = where("Contract No"=filter('01'));

            Column(Contract_No; "Contract No")
            {
            }
            column(Contractor_Name; "Contractor Name")
            {
            }
            column(Address; Address)
            {
            }

            column(Tel_No_; "Tel No.")
            {
            }
            column(Lease_Start_Date; "Start Date")
            {
            }
            column(L_R_No_; "L.R No.")
            {
            }
            column(Start_Date; "Start Date")
            {
            }
            column(End_Date; "End Date")
            {
            }
            column(Escalation_For_Leases; "Escalation For Leases")
            {
            }
            column(Escalation_Start_Date; "Escalation Start Date")
            {
            }
            column(Unit_Code; "Unit Code")
            {
            }
            column(Floor_Code; "Floor Code")
            {
            }

            column(CompanyProfile; "Contractor Description")
            {
            }
            column(Physical_Address; "Physical Address")
            {
            }
            column(LegalOfficerName; CompanyInformation."Legal Officer Name")
            {
            }
            column(LegalOfficerTitle; CompanyInformation."Legal Officer Title")
            {
            }
            column(CompanyName; CompanyInformation."Name")
            {
            }
            column(BuildingName; CompanyInformation."Building Name")
            {
            }
            column(CompanyAddress; CompanyInformation."Address")
            {
            }
            column(CompanyPhysical_Address; CompanyInformation."Address 2")
            {
            }
            column(City; CompanyInformation."City")
            {
            }
            trigger OnAfterGetRecord()
            begin

                CheckReport.InitTextVariable();

                CheckReport.FormatNoText(NumberText, "Lease Amount Exc VAT", '');
                CheckReport.FormatNoText(NumberText, "Lease Amount Exc VAT", '');
                CheckReport.FormatNoText(NumberText, "Area Sqft", '');
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
        CompanyInformation.GET;
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        City := CompanyInformation.City;
        CompanyPhysical_Address := CompanyInformation."Address 2";
        CompanyAddress := CompanyInformation.Address;
        BuildingName := CompanyInformation."Building Name";
        CompanyName := CompanyInformation."Name";
        LegalOfficerTitle := CompanyInformation."Legal Officer Title";
        LegalOfficerName := CompanyInformation."Legal Officer Name";
    end;


    Var
        CompanyInformation: Record "Company Information";
        Physical_Address: Text[250];
        Address: Text[250];
        City: Text[30];
        Tel_No_: Text[30];
        LegalOfficerName: Text[50];
        LegalOfficerTitle: Text[50];
        CompanyName: Text[50];
        BuildingName: Text[50];
        CompanyAddress: Text[50];
        CompanyPhysical_Address: Text[50];
        AmountInWords: array[2] of Text;
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;
}
