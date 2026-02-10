#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186211 pageextension52186211 extends "Workflow Event Conditions" 
{
    layout
    {
        modify(Condition)
        {
            ApplicationArea = Basic;
        }
        modify(FilterConditionText)
        {
            ApplicationArea = Basic;
        }
        modify("Field")
        {
            ApplicationArea = Basic;
        }
        modify(FieldCaption2)
        {
            ApplicationArea = Basic;
        }
        modify(is)
        {
            ApplicationArea = Basic;
        }
        modify(Operator)
        {
            ApplicationArea = Basic;
        }
        modify(AddChangeValueConditionLbl)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Condition(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Field(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Operator(Control 4)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetRule(PROCEDURE 10)".


    //Unsupported feature: Code Modification on "FindAndFilterToField(PROCEDURE 57)".

    //procedure FindAndFilterToField();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Field.FILTERGROUP(2);
        Field.SETRANGE(TableNo,"Table ID");
        Field.SETFILTER(Type,STRSUBSTNO('%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11|%12|%13',
        #4..14
            Field.Type::Duration,
            Field.Type::RecordID));
        Field.SETRANGE(Class,Field.Class::Normal);
        Field.SETFILTER(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);

        IF CaptionToFind = "Field Caption" THEN
          Field.SETRANGE("No.","Field No.")
        ELSE
          Field.SETFILTER("Field Caption",'%1','@' + CaptionToFind + '*');

        EXIT(Field.FINDFIRST);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..17
        #19..25
        */
    //end;
}
