#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185833 "Surety Management Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Surety Management Report.rdl';

    dataset
    {
        dataitem("Surety Management"; "Surety Management")
        {
            RequestFilterFields = "Surety No", "Refference No", "Account No", "User ID";

            column(SuretyNo_SuretyManagement; "Surety Management"."Surety No")
            {
            }
            column(RefferenceNo_SuretyManagement; "Surety Management"."Refference No")
            {
            }
            column(RefferenceDetails_SuretyManagement; "Surety Management"."Refference Details")
            {
            }
            column(MemberNos_SuretyManagement; "Surety Management"."Member Nos")
            {
            }
            column(MemberName_SuretyManagement; "Surety Management"."Member Name")
            {
            }
            column(Amount_SuretyManagement; "Surety Management".Amount)
            {
            }
            column(Date_SuretyManagement; "Surety Management".Date)
            {
            }
            column(NoSeries_SuretyManagement; "Surety Management"."No. Series")
            {
            }
            column(Status_SuretyManagement; "Surety Management".Status)
            {
            }
            column(TypeOfAccount_SuretyManagement; "Surety Management"."Type Of Account")
            {
            }
            column(MemberNo_SuretyManagement; "Surety Management"."Account No")
            {
            }
            column(UserID_SuretyManagement; "Surety Management"."User ID")
            {
            }
            column(CourtName_SuretyManagement; "Surety Management"."Court Name")
            {
            }
            column(Court_SuretyManagement; "Surety Management".Court)
            {
            }
            column(Type_SuretyManagement; "Surety Management".Type)
            {
            }
            column(CaseNo_SuretyManagement; "Surety Management"."Case No")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(Accused_SuretyManagement; "Surety Management".Accused)
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(HomePage; HomePage)
            {
            }
            column(Email; Email)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // CheckReport.InitTextVariable;
                // CheckReport.FormatNoText(NumberText,"Surety Management".Amount,'');
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
        CI.Get();
        CI.CalcFields(CI.Picture);
        Name := CI.Name;
        PhoneNo := CI."Phone No.";
        Address := CI.Address;
        Email := CI."E-Mail";
        HomePage := CI."Home Page";
    end;

    var
        //CheckReport: Report Check;
        NumberText: array[2] of Text;
        Amount1: Decimal;
        CI: Record "Company Information";
        Name: Text[50];
        Address: Text;
        PhoneNo: Text;
        HomePage: Text[50];
        Email: Text[50];
}
