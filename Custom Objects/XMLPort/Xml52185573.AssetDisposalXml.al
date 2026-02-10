namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;

xmlport 52185573 "Asset Disposal Xml "
{
    Caption = 'Asset Disposal Xml ';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FixedAsset; "Fixed Asset")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
