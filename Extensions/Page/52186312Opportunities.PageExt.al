#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186312 pageextension52186312 extends Opportunities 
{
    layout
    {
        modify(TableOption)
        {
            ApplicationArea = Basic;
        }
        modify(OutPutOption)
        {
            ApplicationArea = Basic;
        }
        modify(RoundingFactor)
        {
            ApplicationArea = Basic;
        }
        modify(OptionStatusFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "TableOption(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OutPutOption(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OptionStatusFilter(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 2)".

    }
    actions
    {
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;
        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ShowMatrix(Action 77).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CLEAR(MatrixForm);
            CloseOppFilter := GETFILTER("Close Opportunity Filter");
            SuccesChanceFilter := GETFILTER("Chances of Success % Filter");
            #4..9

            MatrixForm.Load(MATRIX_CaptionSet,MatrixRecords,TableOption,OutPutOption,RoundingFactor,
              OptionStatusFilter,CloseOppFilter,SuccesChanceFilter,ProbabilityFilter,CompleteFilter,EstValFilter,
              CaldCurrValFilter,SalesCycleFilter,CycleStageFilter,Periods);

            MatrixForm.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..12
              CaldCurrValFilter,SalesCycleFilter,CycleStageFilter,Rec,Periods);

            MatrixForm.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".

        moveafter(ShowMatrix;"Next Set")
    }


    //Unsupported feature: Property Modification (Id) on "MatrixMgt(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixMgt : 1001;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixMgt : 1020;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1636)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionRange"(Variable 1637)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionRange" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionRange" : 1024;
        //Variable type has not been exported.

    var
        NoOfColumns: Integer;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CreateCaptionSet(SetWanted::Initial);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        NoOfColumns := GetMatrixDimension;
        CreateCaptionSet(SetWanted::Initial);
        */
    //end;

    local procedure GetMatrixDimension(): Integer
    begin
        //exit(ArrayLen(MATRIX_CaptionSet));
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
