#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186187 pageextension52186187 extends "Trial Balance" 
{

    //Unsupported feature: Property Modification (Name) on ""Trial Balance"(Page 1393)".

    layout
    {
        modify(DescriptionCap)
        {
            ApplicationArea = Basic;
        }
        modify(Description1)
        {
            ApplicationArea = Basic;
        }
        modify(Description2)
        {
            ApplicationArea = Basic;
        }
        modify(Description3)
        {
            ApplicationArea = Basic;
        }
        modify(Description4)
        {
            ApplicationArea = Basic;
        }
        modify(Description5)
        {
            ApplicationArea = Basic;
        }
        modify(Description6)
        {
            ApplicationArea = Basic;
        }
        modify(Description7)
        {
            ApplicationArea = Basic;
        }
        modify(Description8)
        {
            ApplicationArea = Basic;
        }
        modify(Description9)
        {
            ApplicationArea = Basic;
        }
        modify("PeriodCaptionTxt[1]")
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues1)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues2)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues3)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues4)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues5)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues6)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues7)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues8)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodValues9)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Visible) on "Control22(Control 22)".

        modify("PeriodCaptionTxt[2]")
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues1)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues2)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues3)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues4)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues5)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues6)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues7)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues8)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentPeriodMinusOneValues9)
        {
            ApplicationArea = Basic;
        }
        modify(Control234)
        {
            Visible = false;
        }
        modify(Control3)
        {
            Visible = false;
        }
        modify(GetLastErrorText)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Visible) on "Control44(Control 44)".


        //Unsupported feature: Property Deletion (ShowCaption) on "DescriptionCap(Control 43)".


        //Unsupported feature: Property Deletion (Visible) on "Control33(Control 33)".


        //Unsupported feature: Property Deletion (ShowCaption) on ""PeriodCaptionTxt[1]"(Control 32)".


        //Unsupported feature: Code Modification on "CurrentPeriodValues1(Control 31).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(1,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(1,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues2(Control 30).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(2,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(2,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues3(Control 29).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(3,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(3,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues4(Control 28).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(4,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(4,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues5(Control 27).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(5,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(5,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues6(Control 26).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(6,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(6,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues7(Control 25).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(7,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(7,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues8(Control 24).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(8,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(8,1);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodValues9(Control 23).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(9,1);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(9,1);
            */
        //end;

        //Unsupported feature: Property Deletion (ShowCaption) on ""PeriodCaptionTxt[2]"(Control 21)".



        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues1(Control 20).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(1,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(1,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues2(Control 19).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(2,2)
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(2,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues3(Control 18).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(3,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(3,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues4(Control 17).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(4,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(4,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues5(Control 16).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(5,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(5,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues6(Control 15).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(6,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(6,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues7(Control 14).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(7,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(7,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues8(Control 13).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(8,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(8,2);
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentPeriodMinusOneValues9(Control 12).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DrillDown(9,2);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.DrillDown(9,2);
            */
        //end;
    }
    actions
    {
        modify(PreviousPeriod)
        {
            ToolTip = 'Next Period';
            ApplicationArea = Basic;
        }
        modify(NextPeriod)
        {
            ToolTip = 'Previous Period';
            ApplicationArea = Basic;
        }
        modify(Information)
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Code Modification on "PreviousPeriod(Action 49).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF LoadedFromCache THEN BEGIN
              TrialBalanceMgt.LoadData(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);
              LoadedFromCache := FALSE;
            END;
            TrialBalanceMgt.PreviousPeriod(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);

            SetStyles;
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.PreviousPeriod(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);
            #6..8
            */
        //end;

        //Unsupported feature: Property Deletion (Visible) on "PreviousPeriod(Action 49)".



        //Unsupported feature: Code Modification on "NextPeriod(Action 50).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF LoadedFromCache THEN BEGIN
              TrialBalanceMgt.LoadData(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);
              LoadedFromCache := FALSE;
            END;

            TrialBalanceMgt.NextPeriod(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);
            SetStyles;
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MiniTrialBalanceMgt.NextPeriod(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);
            SetStyles;
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (Visible) on "NextPeriod(Action 50)".

        modify(Setup)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Information(Action 47)".

    }

    var
        MiniTrialBalanceMgt: Codeunit "Trial Balance Mgt.";


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PeriodVisible := TRUE;
        NoOfColumns := 2;

        IF (ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone) OR AccountingPeriod.ISEMPTY THEN BEGIN
          NoOfColumns := 1;
          PeriodVisible := FALSE;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF CURRENTCLIENTTYPE = CLIENTTYPE::Phone THEN BEGIN
        #5..7
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        LoadTrialBalanceData;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        MiniTrialBalanceMgt.LoadData(Descriptions,Values,PeriodCaptionTxt,NoOfColumns);
        SetStyles;
        */
    //end;
}
