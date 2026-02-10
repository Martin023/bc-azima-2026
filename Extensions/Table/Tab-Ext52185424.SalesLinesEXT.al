namespace MNS.MNS;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;

tableextension 52185424 "Sales Lines EXT" extends "Sales Line"
{
    fields
    {
        field(50789; "Disposal Expiry"; date)
        {

            DataClassification = ToBeClassified;

        }
        field(50800; "Disposal Reason"; Text[100])
        {

        }
        field(50801; Narration; Text[200])
        {

        }
    }

}
