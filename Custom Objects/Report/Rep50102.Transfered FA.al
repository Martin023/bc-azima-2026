report 52186075 "Transfered Fixed Assets"
{
    ApplicationArea = All;
    Caption = 'Transfered Fixed Assets';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RdlcLayout = './bc-azima-2026/Layout/Transfered Fixed Assets.rdl';
    dataset
    {
        dataitem(AssetTransfer; "Asset Transfer")
        {
            DataItemTableView = where(Transferred = const(true));
            column(No; "No.")
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
                column(AssetDescription; "Asset Description")
                {
                }
                column(AssettoTransfer; "Asset to Transfer")
                {
                }
                column(FromDimension1Code; "Current Dimension 1 Code")
                {
                }
                column(FromDimension2Description; "From Dimension 2 Description")
                {
                }
                column(FromEmployeeName; "Current Employee Name")
                {
                }
                column(FromLocation; "Current Location")
                {
                }
                column(ToDimension1Code; "To Dimension Value 1 code")
                {
                }
                column(ToEmployeeName; "To Responsible Employee Name")
                {
                }
                column(ToDimension2Description; "To Dimension Value 2 code")
                {
                }
                column(ToLocation; "To Location")
                {
                }
                column(ToResponsibleEmployee; "To Responsible Employee")
                {
                }
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

}
