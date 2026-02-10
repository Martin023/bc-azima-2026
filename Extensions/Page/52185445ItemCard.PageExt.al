PageExtension 52185445 pageextension52185445 extends "Item Card"
 {



    layout
    {
        modify("Gen. Prod. Posting Group")
        {
            Visible=True;
        }
        



       addlast(Item)
       {
       
            field("Inventory Stock"; Rec."Inventory Stock")
            {

            }

            field("Physical Count"; rec."Physical Count")
            {

            }
            field(Variance; Rec.Variance)
            {
                Editable = false;

            }
            field("Physical Count Date"; Rec."Physical Count Date")
            {
                Editable = false;
            }
            field("Item G/L Budget Account"; rec."Item G/L Budget Account")
            {
                ApplicationArea = Basic;
            }
            field("Created By";Rec."Created By")
            {
                Editable=false;
                
            }
           field("Disposal Date";Rec."Disposal Date")
           {

           }
           field("Disposal Reason";Rec."Disposal Reason")
           {
            
           }
           field("Disposal Method";rec."Disposal Method")
           {

           }
        }

    }
 }