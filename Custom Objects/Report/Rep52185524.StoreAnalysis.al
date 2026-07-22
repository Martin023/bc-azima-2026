namespace AzimaBC.AzimaBC;

using Microsoft.Inventory.Item;

report 52185524 "Store Analysis"
{
    ApplicationArea = All;
    Caption = 'Store Analysis';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No."){}
            
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
