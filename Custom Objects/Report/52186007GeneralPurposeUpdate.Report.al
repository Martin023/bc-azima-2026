#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186007 "General Purpose Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/General Purpose Update.rdl';

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            RequestFilterFields = "No.", Date, Posted, Status;
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Payments Header".Status := "Payments Header".Status::Posted;
                "Payments Header".Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Records cancelled Successfully');
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
        // CompInf.GET;
        // CompInf.CALCFIELDS(Picture);
        // website:=CompInf."Home Page";
        // Email:=CompInf."E-Mail";
        // PrintedBy := USERID;
        // Pos := STRPOS(PrintedBy,'\')+1;
        // PrintedBy := COPYSTR(PrintedBy,Pos,STRLEN(PrintedBy));
        // PrintedAt:=CURRENTDATETIME;
        // DateAndTime:= FORMAT(CURRENTDATETIME,0,'<Day,2>/<Month,2>/<Year4>');
    end;

    var
        CompInf: Record "Company Information";
        website: Text;
        Email: Text;
        PrintedBy: Text;
        Pos: Integer;
        PrintedAt: DateTime;
        DateAndTime: Text;
}
