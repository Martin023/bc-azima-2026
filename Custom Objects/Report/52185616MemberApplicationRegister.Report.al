#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185616 "Member Application Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Application Register.rdl';

    dataset
    {
        dataitem(MemberApplication; "Member Application")
        {
            RequestFilterFields = "No.", "Application Date", "Employer Code", Nationality, Status, "Responsibility Center", "Recruited By", "Group Account No.";
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
            column(No_MemberApplication; MemberApplication."No.")
            {
            }

            column(Name_MemberApplication; MemberApplication.Name)
            {
            }
            column(GlobalDimension1Code_MemberApplication; MemberApplication."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_MemberApplication; MemberApplication."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_MemberApplication; MemberApplication."Application Date")
            {
            }
            column(EmployerCode_MemberApplication; MemberApplication."Employer Code")
            {
            }
            column(Nationality_MemberApplication; MemberApplication.Nationality)
            {
            }
            column(PayrollStaffNo_MemberApplication; MemberApplication."Payroll/Staff No.")
            {
            }
            column(PhoneNo_MemberApplication; MemberApplication."Phone No.")
            {
            }
            column(IDNumber_MemberApplication; MemberApplication."Primary Identification")
            {
            }

            column(GroupAccountNo_MemberApplication; MemberApplication."Group Account No.")
            {
            }
            column(SalespersonCode_MemberApplication; MemberApplication."Recruited By")
            {
            }
            column(MemberSegment_MemberApplication; MemberApplication."Member Segment")
            {
            }
            column(CreatedBy_MemberApplication; MemberApplication."Created By")
            {
            }

            column(Status_MemberApplication; MemberApplication.Status)
            {
            }
            column(SCount; SNo)
            {
            }
            column(JanCount; JanCount)
            {
            }
            column(FebCount; FebCount)
            {
            }
            column(MarCount; MarCount)
            {
            }
            column(ApriCount; ApriCount)
            {
            }
            column(MayCount; MayCount)
            {
            }
            column(JunCount; JunCount)
            {
            }
            column(JulCount; JulCount)
            {
            }
            column(AugCount; AugCount)
            {
            }
            column(SepCount; SepCount)
            {
            }
            column(OctCount; OctCount)
            {
            }
            column(NovCount; NovCount)
            {
            }
            column(DecCount; DecCount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                if Date2dmy(MemberApplication."Application Date", 2) = 1 then
                    JanCount += 1
                else
                    if Date2dmy(MemberApplication."Application Date", 2) = 2 then
                        FebCount += 1
                    else
                        if Date2dmy(MemberApplication."Application Date", 2) = 3 then
                            MarCount += 1
                        else
                            if Date2dmy(MemberApplication."Application Date", 2) = 4 then
                                ApriCount += 1
                            else
                                if Date2dmy(MemberApplication."Application Date", 2) = 5 then
                                    MayCount += 1
                                else
                                    if Date2dmy(MemberApplication."Application Date", 2) = 6 then
                                        JunCount += 1
                                    else
                                        if Date2dmy(MemberApplication."Application Date", 2) = 7 then
                                            JulCount += 1
                                        else
                                            if Date2dmy(MemberApplication."Application Date", 2) = 8 then
                                                AugCount += 1
                                            else
                                                if Date2dmy(MemberApplication."Application Date", 2) = 9 then
                                                    SepCount += 1
                                                else
                                                    if Date2dmy(MemberApplication."Application Date", 2) = 10 then
                                                        OctCount += 1
                                                    else
                                                        if Date2dmy(MemberApplication."Application Date", 2) = 11 then
                                                            NovCount += 1
                                                        else
                                                            if Date2dmy(MemberApplication."Application Date", 2) = 12 then
                                                                DecCount += 1
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
        JanCount: Integer;
        FebCount: Integer;
        MarCount: Integer;
        ApriCount: Integer;
        MayCount: Integer;
        JunCount: Integer;
        JulCount: Integer;
        AugCount: Integer;
        SepCount: Integer;
        OctCount: Integer;
        NovCount: Integer;
        DecCount: Integer;
}
