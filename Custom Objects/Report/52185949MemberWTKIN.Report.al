#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185949 "Member W/T KIN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member WT KIN.rdl';

    dataset
    {
        //dataitem(52185700;"52185700")
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.", Status, "Employer Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(Member_No; Members."No.")
            {
            }
            column(Member_Name; Members.Name)
            {
            }
            column(Member_ID; Members."Primary Identification")
            {
            }
            column(Member_Phone; Members."Phone No.")
            {
            }
            column(Member_PF; Members."Payroll/Staff No.")
            {
            }
            column(Member_EmployerName; Members."Employer Name")
            {
            }
            column(Member_EmployerCode; Members."Employer Code")
            {
            }
            column(Member_Status; Members.Status)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                NextKin.Reset;
                NextKin.SetRange("Record ID", Members."No.");
                //NextKin.SETRANGE(Type,NextKin.Type::"Benevolent Beneficiary");
                //NextKin.SETRANGE(Beneficiary,TRUE);
                if NextKin.Find('-') then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
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

    var
        Company: Record "Company Information";
        NextKin: Record "Next of KIN";
}
