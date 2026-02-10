report 52187418 "Share Capital Transfer"
{
    DefaultLayout = RDLC;

    RDLCLayout = './bc-kenpipe-2024/Layout/Share Capital Transfer.rdl';

    dataset
    {
        dataitem(ShareCapitalTransfer; "Share Capital Transfer Buffer")
        {
            DataItemTableView = where(Transfered = const(true));
            column(ReportForNavId_1; 1)
            {
            }
            // column(CompanyName; CI.Name)
            // {

            // }
            // column(CompanyAddress; CI.Address)
            // {

            // }
            // column(PhoneNo; CI."Phone No.")
            // {

            // }
            // column(Picture; CI.Picture)
            // {

            // }
            column(Source_Member_No; ShareCapitalTransfer."Source Member No")
            {

            }
            column(Source_Member_Name; ShareCapitalTransfer."Source Member Name")
            {

            }
            column(CRM_Notes; "CRM Notes")
            {

            }
            column(Document_No; "Document No")
            {

            }
            column(PFNO; PFNO)
            {

            }
            column(PostedBY; "Posted BY")
            {

            }
            column(DestinationPFNO; DestinationPFNO)
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
            dataitem("Share Capital Transfer Lines"; "Share Capital Transfer Lines")
            {
                DataItemLink = "Document No." = field("Document No");
                column(Destination_Member_No; "Destination Member No")
                {

                }
                column(Destination_Member_Name; "Destination Member Name")
                {

                }
                column(Allocation_Amount; "Allocation Amount")
                {

                }
                column(Application_Date; "Application Date")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    DestinationPFNO := '';
                    IF Members.get("Share Capital Transfer Lines"."Destination Member No") then
                        DestinationPFNO := Members."Payroll/Staff No.";
                end;

            }
            trigger OnAfterGetRecord()
            var

            begin
                PFNO := '';
                //DestinationPFNO := '';
                IF Members.get(ShareCapitalTransfer."Source Member No") then begin
                    PFNO := Members."Payroll/Staff No.";
                end;

            end;

        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {

            }
        }



        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // trigger OnPreReport()
    // begin
    //     CI.Reset;
    //     CI.Get();
    //     CI.CalcFields(CI.Picture);
    // end;
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        myInt: Integer;
        CI: Record "Company Information";
        DestinationPFNO: code[30];
        PFNO: code[30];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: record Members;
}