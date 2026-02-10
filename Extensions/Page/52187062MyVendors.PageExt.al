#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187062 pageextension52187062 extends "My Vendors" 
{
    layout
    {
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Phone No."(Control 11)".


            //Unsupported feature: Property Modification (Name) on ""Phone No."(Control 11)".

            Editable = false;
        }
        modify(Name)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Name(Control 9)".


            //Unsupported feature: Property Modification (Name) on "Name(Control 9)".

            Editable = false;
        }
        // modify("<Balance>")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""<Balance>"(Control 13)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""<Balance>"(Control 13)".

        //     Editable = false;
        // }

        //Unsupported feature: Code Modification on ""Vendor No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SyncFieldsWithVendor
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GetVendor;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (Lookup) on ""Phone No."(Control 11)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Phone No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 11)".


        //Unsupported feature: Property Deletion (Lookup) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (DrillDown) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 9)".

        // modify("<Balance>")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""<Balance>"(Control 13)".

    }
    actions
    {
        modify(Open)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 2)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SyncFieldsWithVendor
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetVendor;
        */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(Vendor)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CLEAR(Vendor);
        */
    //end;

    local procedure GetVendor()
    begin
        // Clear(Vendor);

        // if Vendor.Get(Rec."Vendor No.") then
        //   Vendor.CalcFields(Balance);
    end;
}
