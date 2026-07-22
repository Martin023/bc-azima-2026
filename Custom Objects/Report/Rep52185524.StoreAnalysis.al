namespace AzimaBC.AzimaBC;

using Microsoft.Inventory.Item;

report 52185524 "Store Analysis"
{
    ApplicationArea = All;
    Caption = 'Store Analysis';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Store Analysis.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No."){}
            column(Description;Description) {}
            column(Item_Category_Code;"Item Category Code") {}
            
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
