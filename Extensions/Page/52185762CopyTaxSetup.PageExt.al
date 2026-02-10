#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185762 pageextension52185762 extends "Copy Tax Setup" 
{
    layout
    {
        modify("SourceCompany.Name")
        {
            ApplicationArea = Basic;
        }
        modify(CopyMode)
        {
            ApplicationArea = Basic;
        }
        modify(TaxGroups)
        {
            ApplicationArea = Basic;
        }
        modify(TaxJurisdictions)
        {
            ApplicationArea = Basic;
        }
        modify(TaxAreas)
        {
            ApplicationArea = Basic;
        }
        modify(TaxDetail)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""SourceCompany.Name"(Control 2).OnLookup".

        //trigger Name"(Control 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SourceCompany.SETFILTER(Name,'<>%1',COMPANYNAME);
            IF PAGE.RUNMODAL(PAGE::Companies,SourceCompany) = ACTION::LookupOK THEN
              IF SourceCompany.Name = COMPANYNAME THEN BEGIN
                SourceCompany.Name := '';
                ERROR(Text000);
              END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SourceCompany.SETFILTER(Name,'<>%1',COMPANYNAME);
            IF PAGE.RUNMODAL(357,SourceCompany) = ACTION::LookupOK THEN
            #3..6
            */
        //end;
    }


    //Unsupported feature: Property Modification (Id) on "i(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //i : 1003;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //i : 1005;
        //Variable type has not been exported.
}
