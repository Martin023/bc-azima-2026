#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186409 tableextension52186409 extends "Document Sending Profile"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""E-Mail Format"(Field 13)".


        //Unsupported feature: Property Modification (Data type) on ""Disk Format"(Field 16)".

    }

    //Unsupported feature: Code Modification on "SendToEMail(PROCEDURE 10)".

    //procedure SendToEMail();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "E-Mail" = "E-Mail"::No THEN
      EXIT;

    #4..8
      "E-Mail Attachment"::"Electronic Document":
        BEGIN
          ReportSelections.GetEmailBody(ServerEmailBodyFilePath,ReportUsage,RecordVariant,ToCust,SendToEmailAddress);
          ReportDistributionManagement.SendXmlEmailAttachment(
            RecordVariant,"E-Mail Format",ServerEmailBodyFilePath,SendToEmailAddress);
        END;
      "E-Mail Attachment"::"PDF & Electronic Document":
        BEGIN
    #17..24
            NOT ShowDialog,ReportUsage);
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
          ReportDistributionManagement.SendXmlEmailAttachment(RecordVariant,"E-Mail Format");
    #14..27
    */
    //end;
}
