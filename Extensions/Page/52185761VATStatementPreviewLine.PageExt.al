#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185761 pageextension52185761 extends "VAT Statement Preview Line" 
{
    layout
    {
        modify("Row No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Amount Type")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Tax Jurisdiction Code")
        {
            ApplicationArea = Basic;
        }
        modify("Use Tax")
        {
            ApplicationArea = Basic;
        }
        modify(ColumnValue)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Row No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Type"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tax Jurisdiction Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Tax"(Control 12)".


        //Unsupported feature: Code Modification on "ColumnValue(Control 17).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CASE Type OF
              Type::"Account Totaling":
                BEGIN
            #4..31
                    Selection::"Open and Closed":
                      VATEntry.SETRANGE(Closed);
                  END;
                  OnBeforeOpenPageVATEntryTotaling(VATEntry,Rec);
                  PAGE.RUN(PAGE::"VAT Entries",VATEntry);
                END;
              Type::"Row Totaling",
              Type::Description:
                ERROR(Text000,FIELDCAPTION(Type),Type);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..34
            #36..41
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnValue(Control 17)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 1)".

}
