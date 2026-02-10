xmlport 52185424 "Fixed Assets Transfer Import"
{
    Caption = 'Fixed Assets Transfer Import';
    Format = VariableText;
    schema
    {
        textelement(Root)
        {
            tableelement(AssetTransferLine; "Asset Transfer Line")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'no';
                fieldelement(AssetTransferHeaderNo; AssetTransferLine."Asset Transfer Header No.")
                {
                }
                fieldelement(AssettoTransfer; AssetTransferLine."Asset to Transfer")
                {
                }
                // fieldelement(CurrentDimension1Code; AssetTransferLine."Current Dimension 1 Code")
                // {
                // }
                // fieldelement(CurrentDimension2Code; AssetTransferLine."Current Dimension 2 Code")
                // {
                // }
                // fieldelement(CurrentEmployeeName; AssetTransferLine."Current Employee Name")
                // {
                // }
                // fieldelement(CurrentLocation; AssetTransferLine."Current Location")
                // {
                // }
                // fieldelement(CurrentResponsibleEmployee; AssetTransferLine."Current Responsible Employee")
                // {
                // }
                fieldelement(ToDimensionValue1code; AssetTransferLine."To Dimension Value 1 code")
                {
                }
                fieldelement(ToDimensionValue2Code; AssetTransferLine."To Dimension Value 2 Code")
                {
                }
                fieldelement(ToLocation; AssetTransferLine."To Location")
                {
                }
                fieldelement(ToResponsibleEmployee; AssetTransferLine."To Responsible Employee")
                {
                }
                fieldelement(ToResponsibleEmployeeName; AssetTransferLine."To Responsible Employee Name")
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
}
