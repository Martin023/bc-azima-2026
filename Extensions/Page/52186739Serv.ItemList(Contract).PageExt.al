#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186739 pageextension52186739 extends "Serv. Item List (Contract)" 
{
    layout
    {
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Service Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("&Warranty Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Com&ponent List")
        {
            ApplicationArea = Basic;
        }
        modify("Troubleshooting Set&up")
        {
            ApplicationArea = Basic;
        }
        modify("&Troubleshooting")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Skills")
        {
            ApplicationArea = Basic;
        }
        modify("S&killed Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Tr&endscape")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Lo&g")
        {
            ApplicationArea = Basic;
        }
        modify("Ser&vice Contracts")
        {
            ApplicationArea = Basic;
        }
        modify("&Item Lines")
        {
            ApplicationArea = Basic;
        }
        modify("&Service Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Action41)
        {
            ApplicationArea = Basic;
        }
        modify(Action42)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Ledger E&ntries"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warranty Ledger Entries"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Com&ponent List"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Troubleshooting Set&up"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Troubleshooting"(Action 27)".


        //Unsupported feature: Code Modification on ""Resource Skills"(Action 28).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CASE TRUE OF
              "Service Item No." <> '':
                BEGIN
                  ResourceSkill.SETRANGE(Type,ResourceSkill.Type::"Service Item");
                  ResourceSkill.SETRANGE("No.","Service Item No.");
                END;
              "Item No." <> '':
                BEGIN
                  ResourceSkill.SETRANGE(Type,ResourceSkill.Type::Item);
                  ResourceSkill.SETRANGE("No.","Item No.");
                END;
            END;
            PAGE.RUNMODAL(PAGE::"Resource Skills",ResourceSkill);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Service Item No." <> '' THEN BEGIN
              ResourceSkill.SETRANGE(Type,ResourceSkill.Type::"Service Item");
              ResourceSkill.SETRANGE("No.","Service Item No.");
              ResourceSkills.SETTABLEVIEW(ResourceSkill);
              ResourceSkills.RUNMODAL;
            END ELSE
              IF "Item No." <> '' THEN BEGIN
                ResourceSkill.SETRANGE(Type,ResourceSkill.Type::Item);
                ResourceSkill.SETRANGE("No.","Item No.");
                ResourceSkills.SETTABLEVIEW(ResourceSkill);
                ResourceSkills.RUNMODAL;
              END;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Skills"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&killed Resources"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tr&endscape"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Lo&g"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ser&vice Contracts"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Item Lines"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Service Lines"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action41(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action42(Action 42)".

        addafter(Card)
        {
            separator(Action21)
            {
            }
        }
        addafter("&Warranty Ledger Entries")
        {
            separator(Action24)
            {
                Caption = '';
            }
        }
        addafter("S&killed Resources")
        {
            separator(Action30)
            {
                Caption = '';
            }
        }
        addafter("Co&mments")
        {
            separator(Action32)
            {
                Caption = '';
            }
        }
        addafter("Tr&endscape")
        {
            separator(Action35)
            {
                Caption = '';
            }
        }
    }

    var
        ResourceSkills: Page "Resource Skills";
}
