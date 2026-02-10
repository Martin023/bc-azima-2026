report 52185696 "Fixed Asset Transfer Report"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Transfer Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Fixed Asset Transfer Report.rdl';
    dataset
    {
        dataitem(AssetTransfer; "Asset Transfer")
        {
            column(No; "No.")
            {
            }
            column(RaisedBy; "Raised By")
            {
            }
            column(Transfer_Date; "Transfer Date")
            {
            }
            column(TransferType; "Transfer Type")
            {
            }
            column(Barcode; BarCode)
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
            dataitem(AssetTransferLine; "Asset Transfer Line")
            {
                DataItemLink = "Asset Transfer Header No." = field("No.");
                column(AssettoTransfer; "Asset to Transfer")
                {
                }
                column(AssetDescription; "Asset Description")
                {
                }
                column(FromLocation; "Current Location")
                {
                }
                column(FromResponsibleEmployee; "Current Responsible Employee")
                {
                }
                column(FromDimension1Code; "Current Dimension 1 Code")
                {
                }
                column(FromDimension2Code; "Current Dimension 2 Code")
                {
                }
                column(ToEmployeeName; "To Responsible Employee Name")
                {
                }
                column(ToLocation; "To Location")
                {
                }
                column(ToResponsibleEmployee; "To Responsible Employee")
                {
                }
                column(To_Dimension_Value_1_code; "To Dimension Value 1 code")
                {
                }
                column(To_Dimension_Value_2_code; "To Dimension Value 2 code")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    FAsset.RESET;
                    FAsset.SETRANGE("No.", AssetTransferLine."Asset to Transfer");
                    if FAsset.Find('-') then begin
                        BarCode := FAsset."Asset Tag";
                    end;

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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];
        FAsset: Record "Fixed Asset";
        BarCode: Code[100];

}
