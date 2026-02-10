page 52186280 "Money Market Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Investment Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Premium/Discount"; Rec."Premium/Discount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = Securities;
                }
                // field("Investment Amount"; Rec."Investment Amount")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Face Value"; Rec."Face Value")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invested Amount';
                }
                field("Investment Amount (LCY)"; Rec."Investment Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Net Interest Amount"; Rec."Net Interest Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Wht Tax Amount"; Rec."Wht Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // action("Create Asset")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            // }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*IF Header.GET("Request No.") THEN
        BEGIN
         IF Header."Deposit Type"=Header."Deposit Type"::Fixed THEN
       Fixed:=TRUE
       ELSE IF Header."Deposit Type"=Header."Deposit Type"::Call THEN
       Call:=TRUE
       ELSE IF Header."Deposit Type"=Header."Deposit Type"::Securities THEN
       Securities:=TRUE;
        END;
       */

    end;

    trigger OnInit()
    begin
        /*Securities:=FALSE;
        Fixed:=FALSE;
        Call:=FALSE;
        */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /* IF Header.GET("Request No.") THEN
         BEGIN
          IF Header."Deposit Type"=Header."Deposit Type"::Fixed THEN
        Fixed:=FALSE
        ELSE IF Header."Deposit Type"=Header."Deposit Type"::Call THEN
        Call:=FALSE
        ELSE IF Header."Deposit Type"=Header."Deposit Type"::Securities THEN
        Securities:=FALSE;
         END;
         */

    end;

    trigger OnOpenPage()
    begin
        /*IF Header.GET("Request No.") THEN
        BEGIN
         IF Header."Deposit Type"=Header."Deposit Type"::Fixed THEN
       Fixed:=TRUE
       ELSE IF Header."Deposit Type"=Header."Deposit Type"::Call THEN
       Call:=TRUE
       ELSE IF Header."Deposit Type"=Header."Deposit Type"::Fixed THEN
       Securities:=TRUE;
        END;
        */

    end;

    var
        Securities: Boolean;
        "Fixed": Boolean;
        Call: Boolean;
}

