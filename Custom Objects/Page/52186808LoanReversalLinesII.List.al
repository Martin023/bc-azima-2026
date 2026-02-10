page 52186808 "Loan Reversal Lines II"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Reversal Lines II";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Defaulter Member No."; Rec."Defaulter Member No.")
                {
                    Editable = false;
                }
                field("Defaulter Loan No"; Rec."Defaulter Loan No")
                {
                    Editable = false;
                }
                field("Refund Type"; Rec."Refund Type")
                {
                    Editable = false;
                }
                field("Interest Attached Amount"; Rec."Interest Attached Amount")
                {
                    Visible = false;
                }

                field("Principle Attached Amount"; Rec."Principle Attached Amount")
                {
                    Visible = false;

                }
                field("Attached Amount"; Rec."Attached Amount")
                {
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                }
                field("Opening Loan Balance"; Rec."Opening Loan Balance")
                {
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                    ;
                }

                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {
                    Editable = false;
                }

                field("Guarantor Name"; Rec."Guarantor Name")
                {
                    Editable = false;
                }

                field("Guarantor Loan No"; Rec."Guarantor Loan No")
                {
                    Editable = false;
                }

                field("Guarantor Interest Balance"; Rec."Guarantor Interest Balance")
                {
                    ToolTip = 'This money is to be posted to the main loan as principle balance//To balance with the main loan';
                    Editable = false;

                }
                field("Guarantor Principal Balance"; Rec."Guarantor Principal Balance")
                {
                    ToolTip = 'This money is to be posted to the main loan as interest balance//To balance with the main loan';
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                    ;

                }
                field("Interests Accrued"; Rec."Interests Accrued")
                {
                    Visible = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                    ;

                }

                field("Interest Paid By Guarantor"; Rec."Interest Paid By Guarantor")
                {
                    ToolTip = 'This money is to be posted to the main loan as interest balance against guarantor FOSA//Can pass through the guarantor loan';
                    Visible = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                    ;

                }
                field("Principle Paid By Guarantor"; Rec."Principle Paid By Guarantor")
                {
                    ToolTip = 'This money is to be posted to the main loan as principle balance against guarantor FOSA//Can pass through the guarantor loan';
                    Visible = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                    ;

                }
                field("Interest Refund"; Rec."Interest Refund")
                {

                }

                field("Principle Refund"; Rec."Principle Refund")
                {
                }
                field("FOSA Reappotionments"; Rec."FOSA Reappotionments")
                {
                    Caption = 'BC FOSA Reappotionments';
                    Editable = false;
                    ToolTip = 'This value is not here for computation purposes but to hel the user make informed descisions';

                }
                field("Total FOSA Refund"; Rec."Total FOSA Refund")
                {
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";
                }

                field("Total Int To Defaulter"; Rec."Total Int To Defaulter")
                {
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";

                }
                field("Total Pr To Defaulter"; Rec."Total Pr To Defaulter")
                {
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";

                }

                field("Total Loan To Defaulter"; Rec."Total Loan To Defaulter")
                {
                    Editable = Rec."Refund Type" = Rec."Refund Type"::"Deposits Reversal";

                }

            }
        }
    }
}
