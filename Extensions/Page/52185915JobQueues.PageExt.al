#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185915 pageextension52185915 extends "Concurrent Session List" 
{

    //Unsupported feature: Property Modification (Name) on ""Concurrent Session List"(Page 670)".

    Caption = 'Job Queues';

    //Unsupported feature: Property Modification (SourceTable) on ""Concurrent Session List"(Page 670)".


    //Unsupported feature: Property Insertion (CardPageID) on ""Concurrent Session List"(Page 670)".


    //Unsupported feature: Property Insertion (RefreshOnActivate) on ""Concurrent Session List"(Page 670)".

    layout
    {
        modify(CurrentSession)
        {

            //Unsupported feature: Property Modification (Name) on "CurrentSession(Control 3)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "CurrentSession(Control 3)".

        }
        // modify("Session ID")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Session ID"(Control 4)".


        //     //Unsupported feature: Property Modification (Name) on ""Session ID"(Control 4)".

        // }
        modify("User ID")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""User ID"(Control 5)".


            //Unsupported feature: Property Modification (Name) on ""User ID"(Control 5)".

        }
        modify("Client Type")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Client Type"(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""Client Type"(Control 6)".

            Editable = false;
        }
        modify("Client Computer Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Client Computer Name"(Control 7)".


            //Unsupported feature: Property Modification (Name) on ""Client Computer Name"(Control 7)".

        }

        //Unsupported feature: Property Deletion (CaptionML) on "CurrentSession(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSession(Control 3)".

        // addafter("Session ID")
        // {
        //     field("Start on This NAS Computer";"Start on This NAS Computer")
        //     {
        //         ApplicationArea = Basic;
        //         Visible = false;
        //     }
        //     field("Start on This NAS Instance";"Start on This NAS Instance")
        //     {
        //         ApplicationArea = Basic;
        //     }
        // }
        addafter("Client Computer Name")
        {
            // field("Start Automatically From NAS";"Start Automatically From NAS")
            // {
            //     ApplicationArea = Basic;
            // }
            field("Server Instance ID";Rec."Server Instance ID")
            {
                ApplicationArea = Basic;
                Editable = false;
                Visible = false;
            }
            // field("Session ID";Rec."Session ID")
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Running on Server Computer";"Running on Server Computer")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("Running on Server Instance";"Running on Server Instance")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("Running as User ID";"Running as User ID")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {

        addfirst(processing)
        {
            action(StartJobQueue)
            {
                ApplicationArea = Basic;
                Caption = 'Start Job Queue';
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action(StopJobQueue)
            {
                ApplicationArea = Basic;
                Caption = 'Stop Job Queue';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action(CheckQueuesAreRunning)
            {
                ApplicationArea = Basic;
                Caption = 'Update Status';
                Image = RefreshText;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }


    //Unsupported feature: Code Insertion on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //begin
        /*
        SaveEditedRecord;
        EXIT(FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETRANGE("Server Instance ID",SERVICEINSTANCEID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CleanupStatusForAll;
        */
    //end;

    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (ShowFilter).

}
