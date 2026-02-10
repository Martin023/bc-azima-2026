#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186652 pageextension52186652 extends "Service Email Queue" 
{

    //Unsupported feature: Property Modification (Name) on ""Service Email Queue"(Page 5961)".

    Caption = 'Service E-Mail Queue';
    layout
    {
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Sending Date")
        {
            ApplicationArea = Basic;
        }
        modify("Sending Time")
        {
            ApplicationArea = Basic;
        }
        modify("To Address")
        {
            ApplicationArea = Basic;
        }
        modify("Subject Line")
        {
            ApplicationArea = Basic;
        }
        modify("Body Line")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sending Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sending Time"(Control 12)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""To Address"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Address"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Subject Line"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Body Line"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Send by Email")
        {
            Caption = '&Send E-Mail';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""&Send by Email"(Action 23)".

        }
        modify("&Delete Service Order Email Queue")
        {
            ApplicationArea = Basic;
        }
        modify("D&elete Service Email Queue")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""&Send by Email"(Action 23).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ISEMPTY THEN
              ERROR(Text001);

            IF Status = Status::Processed THEN
              ERROR(Text000);
            #6..10
            IF ServMailMgt.RUN(Rec) THEN BEGIN
              Status := Status::Processed;
              CurrPage.UPDATE;
            END ELSE
              ERROR(GETLASTERRORTEXT);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ISEMPTY THEN BEGIN
              ERROR(Text001);
              EXIT;
            END;
            #3..13
            END ELSE BEGIN
              ERROR(GETLASTERRORTEXT);
              CLEARLASTERROR;
            END;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Send by Email"(Action 23)".



        //Unsupported feature: Code Modification on ""&Delete Service Order Email Queue"(Action 24).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CLEAR(EMailQueue);
            EMailQueue.SETCURRENTKEY("Document Type","Document No.");
            EMailQueue.SETRANGE("Document Type","Document Type");
            EMailQueue.SETRANGE("Document No.","Document No.");
            REPORT.RUN(REPORT::"Delete Service Email Queue",FALSE,FALSE,EMailQueue);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            REPORT.RUN(REPORT::"Delete Service E-Mail Queue",FALSE,FALSE,EMailQueue);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Delete Service Order Email Queue"(Action 24)".



        //Unsupported feature: Code Modification on ""D&elete Service Email Queue"(Action 16).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            REPORT.RUNMODAL(REPORT::"Delete Service Email Queue");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            REPORT.RUNMODAL(REPORT::"Delete Service E-Mail Queue");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""D&elete Service Email Queue"(Action 16)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
