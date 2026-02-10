#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186277 pageextension52186277 extends "Segment Subform" 
{
    layout
    {
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Correspondence Type")
        {
            ApplicationArea = Basic;
        }
        modify("Send Word Doc. As Attmt.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Alt. Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company Name")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("Language Code")
        {
            ApplicationArea = Basic;
        }
        modify(Subject)
        {
            ApplicationArea = Basic;
        }
        modify(Evaluation)
        {
            ApplicationArea = Basic;
        }
        modify("Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Duration (Min.)")
        {
            ApplicationArea = Basic;
        }
        modify("Initiated By")
        {
            ApplicationArea = Basic;
        }
        modify("Information Flow")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Target")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Response")
        {
            ApplicationArea = Basic;
        }
        modify(AttachmentText)
        {
            ApplicationArea = Basic;
        }
        modify("Contact Via")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Correspondence Type"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send Word Doc. As Attmt."(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Alt. Address Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Template Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Language Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Subject(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Evaluation(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost (LCY)"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duration (Min.)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initiated By"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Information Flow"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Target"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Response"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AttachmentText(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Via"(Control 36)".

    }
    actions
    {
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Create)
        {
            ApplicationArea = Basic;
        }
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(Remove)
        {
            ApplicationArea = Basic;
        }
        modify("Make &Phone Call")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 1900207104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Create(Action 1901653504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 1903099904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 1900546304)".


        //Unsupported feature: Code Modification on "Remove(Action 1901992704).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Interaction Template Code");
            RemoveAttachment;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD("Interaction Template Code");
            RemoveAttachment(TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Remove(Action 1901992704)".



        //Unsupported feature: Code Modification on ""Make &Phone Call"(Action 1900545304).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CreatePhoneCall;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CreateCall;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Make &Phone Call"(Action 1900545304)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 5)".


    local procedure SegmentLineNo(): Integer
    begin
        exit(Rec."Line No.");
    end;
}
