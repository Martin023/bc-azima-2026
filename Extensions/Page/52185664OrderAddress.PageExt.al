#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185664 pageextension52185664 extends "Order Address"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Address)
        {
            ApplicationArea = Basic;
        }
        modify("Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify(Contact)
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        // modify("Phone No.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Phone No."(Control 30)".

        // }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Home Page")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 10)".

        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 19)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 34)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Country/Region Code")
        {
            // field("Phone No.";Rec."Phone No.")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        modify("Online Map")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Online Map"(Action 40)".

    }

    var

        MapPointVisible: Boolean;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    MapPointVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //var
    //MapMgt: Codeunit "Online Map Management";
    //begin
    /*
    IF NOT MapMgt.TestSetup THEN
      MapPointVisible := FALSE;
    */
    //end;
}
