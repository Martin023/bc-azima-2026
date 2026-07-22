report 52186371 "Purchase Requisition Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CustomPurchaseRequisitionForm.rdl';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = CONST(Quote),
                            DocApprovalType = CONST(Requisition));

            column(PurchaseReqNo; "No.")
            {
            }
            column(Department; "Responsibility Center")
            {
            }
            column(RequestorName; "Assigned User ID")
            {
            }
            column(Date; "Document Date")
            {
            }
            column(RemarksDeptHead; "Posting Description")
            {
            }

            // ---- Company letterhead ----
            column(CompanyInformation_Name; CompanyInformation_Name)
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
            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("Document Type" = filter(Quote), Type = filter(Item));

                column(SNo; LineCounter)
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Specification; "Description 2")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }

                trigger OnPreDataItem()
                begin
                    LineCounter := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    LineCounter += 1;
                end;
            }
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
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyInformation_Name := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyInformation_Name: Text[100];
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LineCounter: Integer;
}
