#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185870 pageextension52185870 extends "IC G/L Account List" 
{
    Caption = 'IC G/L Account List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        addfirst(navigation)
        {
            group("IC A&ccount")
            {
                Caption = 'IC A&ccount';
                Image = Intercompany;
            }
            action("&Card")
            {
                ApplicationArea = Basic;
                Caption = '&Card';
                Image = EditLines;
                RunObject = Page "IC G/L Account Card";
                RunPageLink = "No."=field("No.");
                ShortCutKey = 'Shift+F7';
            }
        }
    }

    //Unsupported feature: Property Deletion (CardPageID).

}
