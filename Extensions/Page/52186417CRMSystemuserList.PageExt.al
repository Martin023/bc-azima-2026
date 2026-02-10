#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186417 pageextension52186417 extends "CRM Systemuser List"
{
    Caption = 'Microsoft Dynamics CRM Users';
    Editable = false;
    layout
    {
        modify(FullName)
        {
            ApplicationArea = Basic;
        }
        modify(InternalEMailAddress)
        {
            Caption = 'E-Mail Address';
            ApplicationArea = Basic;
        }
        modify(MobilePhone)
        {
            ApplicationArea = Basic;
        }
        modify(Coupled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "FullName(Control 4)".


        //Unsupported feature: Property Deletion (Editable) on "FullName(Control 4)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on "InternalEMailAddress(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InternalEMailAddress(Control 5)".


        //Unsupported feature: Property Deletion (Editable) on "InternalEMailAddress(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MobilePhone(Control 6)".


        //Unsupported feature: Property Deletion (Editable) on "MobilePhone(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Coupled(Control 3)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on "Coupled(Control 3)".


        //Unsupported feature: Property Deletion (Editable) on "Coupled(Control 3)".

        modify(SalespersonPurchaserCode)
        {
            Visible = false;
        }
    }
    actions
    {
        // modify(ActionContainer7)
        // {
        //     Visible = false;
        // }
        modify(CreateFromCRM)
        {
            Visible = false;
        }
        modify(Couple)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Modification (Data type) on "Coupled(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Coupled : Option;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Coupled : Text;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CRMIntegrationRecord.FindRecordIDFromID(SystemUserId,DATABASE::"Salesperson/Purchaser",RecordID) THEN BEGIN
      IF SalespersonPurchaser.GET(RecordID) THEN
        InsertUpdateTempCRMSystemUser(SalespersonPurchaser.Code,FALSE)
      ELSE
        InsertUpdateTempCRMSystemUser('',FALSE);
      IF CurrentlyCoupledCRMSystemuser.SystemUserId = SystemUserId THEN BEGIN
        Coupled := Coupled::Current;
        FirstColumnStyle := 'Strong';
      END ELSE BEGIN
        Coupled := Coupled::Yes;
        FirstColumnStyle := 'Subordinate';
      END
    END ELSE BEGIN
      InsertUpdateTempCRMSystemUser('',FALSE);
      Coupled := Coupled::No;
      FirstColumnStyle := 'None';
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF CRMIntegrationRecord.FindRecordIDFromID(SystemUserId,DATABASE::"Salesperson/Purchaser",RecordID) THEN
      IF CurrentlyCoupledCRMSystemuser.SystemUserId = SystemUserId THEN BEGIN
        Coupled := 'Current';
        FirstColumnStyle := 'Strong';
      END ELSE BEGIN
        Coupled := 'Yes';
        FirstColumnStyle := 'Subordinate';
      END
    ELSE BEGIN
      Coupled := 'No';
      FirstColumnStyle := 'None';
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentlyCoupledCRMSystemuser(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).

}
