#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186947 pageextension52186947 extends "Monthly Calendar" 
{

    //Unsupported feature: Property Insertion (DataCaptionExpr) on ""Monthly Calendar"(Page 7609)".

    local procedure Calculate()
    begin
    end;

    procedure SetCalendarCode(CalledFrom: Integer;SourceType: Option Company,Customer,Vendor,Location,"Shipping Agent";SourceCode: Code[20];AddSourceCode: Code[20];BaseCalendarCode: Code[10];CurrentDate: Date)
    begin
    end;

    local procedure GetCaption2(): Text[250]
    begin
    end;
}
