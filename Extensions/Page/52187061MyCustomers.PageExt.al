#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187061 pageextension52187061 extends "My Customers" 
{
    layout
    {
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Name(Control 9)".


            //Unsupported feature: Property Modification (Name) on "Name(Control 9)".

            Editable = false;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Phone No."(Control 11)".


            //Unsupported feature: Property Modification (Name) on ""Phone No."(Control 11)".

            Editable = false;
        }

        //Unsupported feature: Code Modification on ""Customer No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SyncFieldsWithCustomer;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GetCustomer;
            */
        //end;

        //Unsupported feature: Property Deletion (Width) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (Width) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (Lookup) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (DrillDown) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (Width) on ""Phone No."(Control 11)".


        //Unsupported feature: Property Deletion (Lookup) on ""Phone No."(Control 11)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Phone No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 11)".

        modify("Balance (LCY)")
        {
            Visible = false;
        }
        addafter("Phone No.")
        {
            field(Balance;Cust.Balance)
            {
                ApplicationArea = Basic;
                Caption = 'Balance';
                Editable = false;
            }
        }
    }
    actions
    {
        modify(Open)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 2)".


        //Unsupported feature: Property Deletion (Scope) on "Open(Action 2)".

    }

    var
        Cust: Record Customer;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SyncFieldsWithCustomer;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetCustomer;
        */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(Customer)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CLEAR(Cust);
        */
    //end;

    local procedure GetCustomer()
    begin
        Clear(Cust);
        if Cust.Get(Rec."Customer No.") then
          Cust.CalcFields(Balance);
    end;
}
