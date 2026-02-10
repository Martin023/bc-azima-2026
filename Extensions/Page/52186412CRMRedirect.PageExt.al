#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186412 pageextension52186412 extends "CRM Redirect" 
{

    //Unsupported feature: Property Modification (TextConstString) on "FilterRegexTok(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //FilterRegexTok : @@@={Locked};ENU=\A%1: @\*(.*)\*\z;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FilterRegexTok : @@@={Locked};ENU=\AFilter: @\*(.*)\*\z;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "InvalidCRMIDErr(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //InvalidCRMIDErr : @@@="%1 = Whatever was passed as CRM ID in the filter, but clearly not an actual CRM ID. %2 = CRM product name";ENU=The %2 ID in the URL is not correctly formatted: %1.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //InvalidCRMIDErr : @@@="%1 = Whatever was passed as CRM ID in the filter, but clearly not an actual CRM ID.";ENU=The CRM ID in the URL is not correctly formatted: %1.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "CRMIntegrationNotEnabledErr(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //CRMIntegrationNotEnabledErr : @@@="%1 = CRM product name";ENU=Integration with %1 is not enabled.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CRMIntegrationNotEnabledErr : ENU=Integration with Microsoft Dynamics CRM is not enabled.;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT CRMIntegrationManagement.IsCRMIntegrationEnabled THEN
          ERROR(CRMIntegrationNotEnabledErr,CRMProductName.SHORT);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT CRMIntegrationManagement.IsCRMIntegrationEnabled THEN
          ERROR(CRMIntegrationNotEnabledErr);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ExtractCRMInfoFromFilters(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "ExtractCRMInfoFromFilters(PROCEDURE 8)".

    //procedure ExtractCRMInfoFromFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FilterText := GETFILTERS;
        RegexHelper := RegexHelper.Regex(STRSUBSTNO(FilterRegexTok,FIELDCAPTION(Filter)));
        MatchHelper := RegexHelper.Match(FilterText);
        IF NOT MatchHelper.Success THEN
          ERROR(InvalidFilterErr);
        GroupCollectionHelper := MatchHelper.Groups;
        GroupHelper := GroupCollectionHelper.Item(1);
        CRMInfo := GroupHelper.Value;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        FilterText := GETFILTERS;
        RegexHelper := RegexHelper.Regex(FilterRegexTok);
        #3..8
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ExtractPartsFromCRMInfo(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "ExtractPartsFromCRMInfo(PROCEDURE 11)".

    //procedure ExtractPartsFromCRMInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        // Extract the CRM ID and CRM entity type name from the CRM info string
        RegexOptionsHelper := RegexOptionsHelper.IgnoreCase;
        RegexHelper := RegexHelper.Regex(CRMInfoRegexTok,RegexOptionsHelper);
        #4..6
        GroupCollectionHelper := MatchHelper.Groups;
        GroupHelper := GroupCollectionHelper.Item(1);
        IF NOT EVALUATE(CRMID,GroupHelper.Value) THEN
          ERROR(InvalidCRMIDErr,CRMProductName.SHORT);
        GroupHelper := GroupCollectionHelper.Item(2);
        CRMEntityTypeName := GroupHelper.Value;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
          ERROR(InvalidCRMIDErr);
        GroupHelper := GroupCollectionHelper.Item(2);
        CRMEntityTypeName := GroupHelper.Value;
        */
    //end;
}
