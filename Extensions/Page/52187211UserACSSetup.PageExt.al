#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187211 pageextension52187211 extends "User ACS Setup" 
{
    layout
    {
        modify("User Name")
        {
            ApplicationArea = Basic;
        }
        modify(NameID)
        {
            ApplicationArea = Basic;
        }
        modify(AuthenticationID)
        {
            ApplicationArea = Basic;
        }
        modify(ACSStatus)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NameID(Control 3)".


        //Unsupported feature: Code Modification on "AuthenticationID(Control 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT (AuthenticationID = '') THEN BEGIN
              IF NOT IdentityManagement.ValidateAuthKeyStrength(AuthenticationID) THEN
                ERROR(WeakAuthKeyErr);
            END;

            IdentityManagement.SetAuthenticationKey("User Security ID",AuthenticationID);
            ACSStatus := IdentityManagement.GetACSStatus("User Security ID");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT (AuthenticationID = '') THEN BEGIN
              IF NOT IdentityManagement.ValidateAuthKeyStrength(AuthenticationID) THEN
                ERROR(Error001);
            #4..7
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "AuthenticationID(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ACSStatus(Control 5)".

    }
    actions
    {
        modify("Generate Auth Key")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Generate Auth Key"(Action 8)".

    }

    var
        Error001: label 'The Authentication Key you entered is too weak. It must be at least 8 characters long and contain both upper and lower case letters and numbers. You can use Generate Auth Key function to generate one for you.           The Authentication Key you entered is too weak. It must be at least 8 characters long and contain both upper and lower case letters and numbers. You can use the Generate Auth Key function to generate one for you.';
}
