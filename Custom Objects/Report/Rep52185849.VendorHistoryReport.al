

report 52185849 "Vendor History Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Vendor History.rdl';
    ApplicationArea = All;
    Caption = 'Vendor History Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(BalanceLCY; "Balance (LCY)")
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


            dataitem("Purchase Header"; "Purch. Inv. Header")
            {
                RequestFilterFields = "Amount Including VAT", "Posting Date";
                DataItemLink = "Buy-from Vendor No." = field("No.");
                column(PurchaseHeaderNo1; "No.")
                {

                }
                column(PostingDate1; "Posting Date")
                {

                }
                column(Amount; "Amount Including VAT")
                {

                }
                dataitem(PurchLine; "Purch. Inv. Line")

                {
                    DataItemLink = "Document No." = field("No.");
                    //DataItemTableView = where(type = filter(item));
                    column(Items; PurchLine."No.")
                    {

                    }
                    column(ItemDescription; PurchLine.Description)
                    {

                    }


                }


            }



            trigger OnAfterGetRecord()
            begin
                if Vendor."Balance (LCY)" = 0 then CurrReport.Skip();
                // Items := '';
                // Amount := 0;
                // PostingDate := 0D;
                // PurchaseHeaderNo := '';
                // "Purchase Header".reset();
                // "Purchase Header".setrange("Buy-from Vendor No.", "No.");
                // if "Purchase Header".find('-') then begin
                //     repeat
                //         PurchLine.reset();
                //         PurchLine.setrange("Document No.", "Purchase Header"."No.");
                //         if PurchLine.find('-') then begin
                //             repeat
                //                 Items := PurchLine."No.";
                //                 "Purchase Header".CalcFields("Amount Including VAT");
                //                 Amount := "Purchase Header"."Amount Including VAT";
                //                 PostingDate := "Purchase Header"."Posting Date";
                //                 PurchaseHeaderNo := "Purchase Header"."No.";
                //                 ItemDescription := PurchLine.Description;
                //             until PurchLine.Next = 0;

                //         end;
                //     until "Purchase Header".next = 0;
                // end;
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
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Items: code[40];

        Amount: decimal;
        PostingDate: date;
        PurchaseHeaderNo: code[50];
        //"Purchase Header":record "Pur
        ItemDescription: text[100];

}
