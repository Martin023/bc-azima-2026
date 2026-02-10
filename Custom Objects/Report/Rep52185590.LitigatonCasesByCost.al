report 52185590 "Litigaton Cases By Cost"
{
    ApplicationArea = All;
    Caption = 'Litigaton Cases By Cost';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Litigaton Cases By Cost.rdl';
    dataset
    {
        dataitem(Legal; Legal)
        {
            column(ADR; ADR)
            {
            }
            column(Advisory; Advisory)
            {
            }
            column(CaseType; "Matter Code")
            {
            }
            column(Case_Number; "Case Number")
            {
            }
            column(CaseOutcome; "Case Outcome")
            {
            }
            column(CaseCategory; "Case Category")
            {
            }
            column(Budgeted_Amount; "Budgeted Amount")
            {
            }
            column(ContigentLiabilities; "Contigent Liabilities")
            {
            }
            column(Lawyer; Lawyer)
            {
            }
            column(LawFirm; "Law Firm")
            {
            }
            column(LegalFees; "Legal Fees")
            {
            }
            column(No; "No.")
            {
            }
            column(Status; Status)
            {
            }
            column(TypeofADR; "Type of ADR")
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

            dataitem(Case_Cost_List; "Case Cost List")
            {
                DataItemLinkReference = Legal;
                DataItemLink = "Code" = Field("No.");
                column(Code; Code)
                {
                }
                column(Cost; Cost)
                {
                }
                column(CostDescription; "Description")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TotalLegalFees := 0;
                    CaseCosts := 0;
                    CaseCostsDescription := '';

                    if Legal."Legal Fees" > 0 then begin
                        CaseCost.RESET;
                        CaseCost.SETRANGE("Code", Legal."No.");
                        if CaseCost.find('-') then begin
                            repeat
                                CaseCostsDescription := CaseCost.Description;
                                CaseCosts := CaseCost.Cost;
                            until CaseCost.next = 0;
                        end
                    end;
                end;
            }
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
        TotalLegalFees: Decimal;
        CaseCosts: Decimal;
        CaseCostsDescription: Text[250];
        CaseCost: Record "Case Cost List";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
