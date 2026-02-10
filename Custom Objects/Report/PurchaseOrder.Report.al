

report 52186062 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Purchase Order.rdl';



    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(PurchaseOrderNo_; "No.")
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
            column(ItemNo; ItemNo)
            {

            }
            column(Description; Description)
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(LineAmount; LineAmount)
            {

            }
            column(Unittotal; Unittotal)
            {

            }
            column(TotInc; TotInc)
            {

            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Email; Email)
            {

            }
            column(VATAMount; VATAMount)
            {

            }

            column(PhoneNo; PhoneNo)
            {

            }
            column(VatRegNo; VatRegNo)
            {

            }
            column(bank; bank)
            {

            }
            column(AccountNo; AccountNo)
            {

            }
            column(Prices_Including_VAT; "Prices Including VAT")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(DocumentDate; "Purchase Header"."Document Date")
            {

            }



            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemNo_; "No.")
                {

                }
                column(Descrption; Description)
                {

                }
                column(Description_2; "Description 2")
                {

                }
                column(Quanty; Quantity)
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }


                trigger OnAfterGetRecord()
                begin
                end;

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Tots := 0;
                LineAmounts := 0;
                VATAMount := 0;
                //"Purchase Header".reset();
                "Purchase Header".SetFilter("No.", OrderNo);
                //"Purchase Header".setfilter("Document Date", '%1..%2', startDate, Enddate);
                if "Purchase Header".find('-') then begin
                    PurchLine.reset();
                    PurchLine.setrange("Document No.", "Purchase Header"."No.");
                    if PurchLine.find('-') then begin
                        repeat
                            Unittotal := 0;
                            LineAmount := 0;
                            TotInc := 0;
                            ItemNo := PurchLine."No.";
                            Description := PurchLine.Description;
                            Quantity := PurchLine.Quantity;
                            Unittotal := PurchLine."Unit Cost";
                            LineAmount := PurchLine."Line Amount";
                            TotInc := PurchLine."Amount Including VAT";

                            Tots += TotInc;
                            LineAmounts += LineAmount;

                        Until PurchLine.next = 0;

                        VATAMount := Tots - LineAmounts;
                    end;
                    vendor.reset();
                    Vendor.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
                    if Vendor.FindFirst() then begin
                        Email := vendor."E-Mail";
                        PhoneNo := vendor."Phone No.";
                        VatRegNo := vendor."KRA Pin No.";
                        bank := Vendor."Preferred Bank Account Code";
                        if bankaccount.get(Vendor."No.") then
                            AccountNo := bankaccount."No.";


                    end;


                end;

            end;


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //"Purchase Header".SetFilter("No.", OrderNo);
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
                field(OrderNo; OrderNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'No';
                    TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                }
                // group("Date Filter")
                // {

                //     field(startDate; startDate)
                //     {

                //         Caption = 'Start Date';
                //         ShowMandatory = true;

                //     }
                //     field(Enddate; Enddate)
                //     {
                //         Caption = 'End Date';
                //         ShowMandatory = true;
                //     }
                // }
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
        //if OrderNo = '' then Error('Please specify Purchase Order No');

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
        VATAMount: decimal;
        LineAmount: decimal;
        Unittotal: decimal;
        OrderNo: code[40];
        LineAmounts: decimal;
        ItemNo: code[30];
        Description: text[50];
        Quantity: Integer;
        TotInc: decimal;
        PurchLine: record "Purchase Line";
        Vendor: record Vendor;
        Email: text[20];
        PhoneNo: text[20];
        VatRegNo: code[100];
        bank: code[100];
        bankaccount: record "Bank Account";
        AccountNo: code[40];
        Tots: decimal;
        startDate: date;
        Enddate: date;


}