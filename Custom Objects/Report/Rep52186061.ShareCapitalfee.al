report 52186061 "Share Capital fee"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Share Capital Transfer fee Report.rdl';
    dataset
    {
        dataitem(ShareCapitalTransferBuffer; "Share Capital Transfer Buffer")
        {
            DataItemTableView = where(Status = filter(Approved));
            column(BookBalance; "Book Balance")
            {
            }
            column(CRMApplicationNo; "CRM Application No.")
            {
            }
            column(CRMNotes; "CRM Notes")
            {
            }
            column(CRMOriginatingBranch; "CRM Originating Branch")
            {
            }
            column(Description; Description)
            {
            }
            column(DestinationBalance; "Destination Balance")
            {
            }
            column(DestinationEmployerCode; "Destination Employer Code")
            {
            }
            column(DestinationMemberName; "Destination Member Name")
            {
            }
            column(DestinationMemberNo; "Destination Member No.")
            {
            }
            column(DestinatonAccNo; "Destinaton Acc No")
            {
            }
            column(DocumentNo; "Document No")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ReferenceNo; "Reference No")
            {
            }
            column(SourceAccountNo; "Source Account No")
            {
            }
            column(SourceBalance; "Source Balance")
            {
            }
            column(SourceIDNo; "Source ID No.")
            {
            }
            column(SourceMemberName; "Source Member Name")
            {
            }
            column(SourceMemberNo; "Source Member No")
            {
            }
            column(SourceMobileNumber; "Source Mobile Number")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(TransferReason; "Transfer Reason")
            {
            }
            column(Transfered; Transfered)
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
            column(Receipt_Amount; "Receipt Amount")
            {

            }
            column(PFNO; PFNO)
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
                column(DestinationPFNO; DestinationPFNO)
                {

                }

            }

            dataitem(TransactionCharges; "Transaction Charges")
            {
                DataItemLink = "Transaction Type" = field("Transaction Type");
                column(Charge_Amount; "Charge Amount")
                {

                }

            }
            trigger OnAfterGetRecord()
            var
                Members: record Members;
            begin

                IF Members.get(ShareCapitalTransferBuffer."Source Member No") then begin
                    PFNO := Members."Payroll/Staff No.";
                end;
                IF Members.get("Share Capital Transfer Lines"."Destination Member No") then
                    DestinationPFNO := Members."Payroll/Staff No.";


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
        PFNO: code[30];
        DestinationPFNO: code[30];

}
