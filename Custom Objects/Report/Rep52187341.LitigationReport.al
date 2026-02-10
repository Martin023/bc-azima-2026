report 52187341 "Litigation Report"
{
    ApplicationArea = All;
    Caption = 'Litigation Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Litigation Report.rdl';

    dataset
    {
        dataitem(Legal; Legal)
        {
            RequestFilterFields = "No.", "Case Number", "Case Category", "Matter Code", "Case Status";
            column(No; "No.")
            {
            }
            column(NameofCase; "Name of Case")
            {
            }
            column(CaseNumber; "Case Number")
            {
            }
            column(Advisory; Advisory) { }
            column(CaseSummary; "Case Summary")
            {
            }
            column(DateofComplaint; "Date of Filing the suit")
            {
            }
            column(Lawyer; Lawyer)
            {
            }
            column(CaseType; "Matter Code")
            {
            }
            column(Status; Status)
            {
            }
            column(CaseStatus; "Case Status")
            {
            }
            column(AccusedType; "Accused Type")
            {
            }
            column(AccusedName; "Accused Name")
            {
            }
            column(LegalFees; "Legal Fees")
            {
            }
            column(Contingent_Liabilities; "Contigent Liabilities")
            {
            }
            column(Budgeted_Amount; "Budgeted Amount")
            {
            }
            column(Pleadings_in_Summary; "Pleadings in Summary")
            {
            }
            column(Summary_of_advisory; "Summary of advisory") { }
            column(MatterCode; "Type of Court")
            {
            }
            column(Case_Category; "Case Category") { }
            column(Type_of_Court; "Case Description")
            {
            }
            column(Name_of_Case; "Name of Case")
            {
            }
            column(Case_Outcome; "Case Outcome")
            {
            }
            column(Case_Duration; "Case Duration")
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
            // dataitem(CaseCosts; "Case Cost List")
            // {
            //     DataItemLinkReference = Legal;
            //     DataItemLink = "Code" = Field("No.");
            column(CaseCostsNo; CaseCostsNo)
            {
            }
            column(CaseCostsDescription; CaseCostsDescription)
            {
            }
            column(Costs; Costs)
            {
            }
            // }
            // dataitem(ContingentLiabilities; Damages)
            // {
            //     DataItemLinkReference = Legal;
            //     DataItemLink = "No." = Field("No.");
            //     column(LiabilityNo;"No.")
            //     {
            //     }
            //     column(LiabilityDescription;Description)
            //     {
            //     }
            //     column(LiabilityCost; "Estimated Cost")
            //     {
            //     }
            // }
            // dataitem("Legal Line"; "Legal Line")
            // {
            //     //DataItemLinkReference = Legal;
            //     DataItemLink = "No" = Field("No.");
            // column(CaseNo; No)
            // {

            // }
            column(Discussion; CaseDiscussion)
            {
            }
            column(Date; DiscussionDate)
            {
            }
            //}
            // dataitem("Legal Upcoming Matters"; "Legal Upcoming Matters")
            // {
            //     //DataItemLinkReference = Legal;
            //     DataItemLink = "Record ID" = Field("No.");
            //     column(MatterNo; "Record ID")
            //     {
            //     }
            column(Matter; Matter)
            {
            }
            column(ScehduledDate; ScehduledDate)
            {
            }
            //}
            // dataitem(Verdict; Verdict)
            // {
            //     //DataItemLinkReference = "Legal Line";
            //     DataItemLinkReference = "Legal";
            //     //DataItemLink = "No" = Field("No.");

            //     column(VerdictNo; No)
            //     {
            //     }
            column(VerdictDiscussion; VerdictDiscussion)
            {
            }
            column(VerdictDate; VerdictDate)
            {
            }
            trigger OnAfterGetRecord()

            begin
                VerdictNo := '';
                VerdictDiscussion := '';
                CaseNo := '';
                CaseDiscussion := '';
                MatterNo := '';
                Matter := '';
                Costs := 0;
                CaseCostsDescription := '';
                CaseCostsNo := '';
                VerdictDate := 0D;

                Verdict.reset;
                Verdict.SETRANGE("No", Legal."No.");
                if Verdict.find('-') then begin
                    repeat
                        VerdictNo := LegalLines."No";
                        VerdictDiscussion := LegalLines.Discussion;
                        VerdictDate := LegalLines.Date;
                    until LegalLines.next = 0;
                end;

                LegalLines.reset;
                LegalLines.SETRANGE("No", Legal."No.");
                if LegalLines.find('-') then begin
                    repeat
                        CaseNo := LegalLines."No";
                        CaseDiscussion := LegalLines.Discussion;
                        DiscussionDate := LegalLines.Date;
                    until LegalLines.next = 0;
                end;


                UpcomingMatters.RESET;
                UpcomingMatters.SETRANGE("Record ID", Legal."No.");
                if UpcomingMatters.find('-') then begin
                    repeat
                        MatterNo := UpcomingMatters."Record ID";
                        Matter := UpcomingMatters.Matter;
                        ScehduledDate := UpcomingMatters."Shceduled Date";
                    until UpcomingMatters.next = 0;
                end;

                CaseCosts.RESET;
                CaseCosts.SETRANGE("Code", Legal."No.");
                if CaseCosts.find('-') then begin
                    repeat
                        CaseCostsNo := CaseCosts.Code;
                        CaseCostsDescription := CaseCosts.Description;
                        CaseCosts.CalcSums(Cost);
                        Costs := CaseCosts.Cost;
                    until CaseCosts.next = 0;
                end;


                // ContingentLiabilities.RESET;
                // ContingentLiabilities.SETRANGE("No.",Legal."No.");
                // if ContingentLiabilities.find ('-') then
                // begin
                //     repeat
                //     LiabilityNo := ContingentLiabilities."No.";
                //     LiabilityDescription := ContingentLiabilities.Description;
                //     LiabilityCost := ContingentLiabilities."Estimated Cost";
                //     until ContingentLiabilities.next = 0;
                //     begin
                //         if ContingentLiabilities."Estimated Cost" > 0 then
                //         begin
                //             ContingentLiability := LiabilityNo + ' - ' + LiabilityDescription;
                //         end;
                //     end;
                // end;
            end;
            //}

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LegalLines: Record "Legal Line";
        VerdictLines: Record Verdict;
        VerdictNo: Code[20];
        VerdictDiscussion: Text;
        CaseNo: Code[20];
        CaseDiscussion: Text;
        VerdictDate: Date;
        DiscussionDate: Date;
        UpcomingMatters: Record "Legal Upcoming Matters";
        MatterNo: Code[20];
        Matter: Text;
        ScehduledDate: Date;
        // LiabilityNo: Code[20];
        // LiabilityDescription: Text;
        // LiabilityCost: Decimal;
        // ContingentLiability: Text;
        Costs: Decimal;
        CaseCostsDescription: Text;
        CaseCostsNo: Code[20];
        Verdict: Record Verdict;
        CaseCosts: Record "Case Cost List";

}
