#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186019 "Member Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Application.rdl';

    dataset
    {
        //dataitem(52185499;52185499)
        dataitem("Sky Virtual Member"; "Sky Virtual Member")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(FullName; FullName)
            {
            }
            column(Telephone_SkyVirtualMember; "Sky Virtual Member".Telephone)
            {
            }
            column(Address; Addr)
            {
            }
            column(Website; Website)
            {
            }
            column(CompEmail; CompEmail)
            {
            }
            column(Email_SkyVirtualMember; "Sky Virtual Member".Email)
            {
            }
            column(IDNumber_SkyVirtualMember; "Sky Virtual Member"."ID Number")
            {
            }
            column(Gender_SkyVirtualMember; "Sky Virtual Member".Gender)
            {
            }
            column(DateOfBirth_SkyVirtualMember; "Sky Virtual Member"."Date Of Birth")
            {
            }
            column(personalNo; PersonalNo)
            {
            }
            column(EntryNo_SkyVirtualMember; "Sky Virtual Member"."Entry No")
            {
            }
            column(DoB; DoB)
            {
            }
            column(check1; Check1)
            {
            }
            column(minimumfee; minimumfee)
            {
            }
            column(monthlySink; monthlySink)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FullName := "Sky Virtual Member".Names;
                if "Sky Virtual Member"."Date Of Birth" <> 0D then begin
                    Day := Date2dmy("Sky Virtual Member"."Date Of Birth", 1);
                    Month := Date2dmy("Sky Virtual Member"."Date Of Birth", 2);
                    Year := Date2dmy("Sky Virtual Member"."Date Of Birth", 3);
                end;
                if Month = 1 then FormatedMonth := 'Jan';
                if Month = 2 then FormatedMonth := 'Feb';
                if Month = 3 then FormatedMonth := 'Mar';
                if Month = 4 then FormatedMonth := 'Apr';
                if Month = 5 then FormatedMonth := 'May';
                if Month = 6 then FormatedMonth := 'June';
                if Month = 7 then FormatedMonth := 'July';
                if Month = 8 then FormatedMonth := 'Aug';
                if Month = 9 then FormatedMonth := 'Sept';
                if Month = 10 then FormatedMonth := 'Oct';
                if Month = 11 then FormatedMonth := 'Nov';
                if Month = 12 then FormatedMonth := 'Dec';


                DoB := Format("Sky Virtual Member"."Date Of Birth");
                DoB := Format(Day) + '/' + FormatedMonth + '/' + Format(Year);
                if ProductFactory.Get('01') then begin
                    minimumfee := ProductFactory."Minimum Contribution";
                    if ProductFactory.Get('04') then begin
                        monthlySink := ProductFactory."Minimum Contribution";
                    end;
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
        CompInf.Get;
        CompInf.CalcFields(Picture);
        Addr := CompInf.Address;
        Website := CompInf."Home Page";
        CompEmail := CompInf."E-Mail";
        if nxt.Name = '' then begin
        end;
    end;

    var
        FullName: Text;
        CompInf: Record "Company Information";
        Addr: Text;
        Website: Text;
        CompEmail: Text;
        Nom: Text;
        PersonalNo: Text;
        nxt: Record "Next of KIN";
        DoB: Text;
        Pos: Integer;
        Check1: Text;
        check2: Text;
        ProductFactory: Record "Product Factory";
        minimumfee: Decimal;
        monthlySink: Decimal;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        FormatedMonth: Text;
}
