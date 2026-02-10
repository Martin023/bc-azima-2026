#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187150 pageextension52187150 extends "Service Credit Memos" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Time")
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
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Time"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 23)".


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 121)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
            /*
            DimMgt.LookupDimValueCodeNoUpdate(1);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 121)".



        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 119)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
            /*
            DimMgt.LookupDimValueCodeNoUpdate(2);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 1102601008)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 1102601014)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 1102601016)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Service Document Lo&g")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;
        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify(PostAndSend)
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }
        modify("Post &Batch")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601009)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601010)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Service Document Lo&g"(Action 1102601012).OnAction".

        //trigger (Variable: ServDocLog)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Service Document Lo&g"(Action 1102601012).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TempServDocLog.RESET;
            TempServDocLog.DELETEALL;
            TempServDocLog.CopyServLog(TempServDocLog."Document Type"::"Credit Memo","No.");

            TempServDocLog.RESET;
            TempServDocLog.SETCURRENTKEY("Change Date","Change Time");
            TempServDocLog.ASCENDING(FALSE);

            PAGE.RUN(0,TempServDocLog);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TempServDocLog.RESET;
            TempServDocLog.DELETEALL;

            ServDocLog.RESET;
            ServDocLog.SETRANGE("Document Type",ServDocLog."Document Type"::"Credit Memo");
            ServDocLog.SETRANGE("Document No.","No.");
            IF ServDocLog.FINDSET THEN
              REPEAT
                TempServDocLog := ServDocLog;
                TempServDocLog.INSERT;
              UNTIL ServDocLog.NEXT = 0;
            #4..9
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Document Lo&g"(Action 1102601012)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndSend(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post &Batch"(Action 1102601004)".

        addafter(Dimensions)
        {
            separator(Action1102601011)
            {
            }
        }
    }

    var
        ServDocLog: Record "Service Document Log";

    var
        DimMgt: Codeunit DimensionManagement;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;

        CopyCustomerFilter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (DataCaptionFields).


    //Unsupported feature: Property Deletion (UsageCategory).

}
