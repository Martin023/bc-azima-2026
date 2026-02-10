#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185461 "Update Images"
{
    DefaultLayout = RDLC;
    Caption = '2. Update Images';
    //RDLCLayout = './bc-kenpipe-2024/Layout/Update Images.rdl';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Pictures and Signtures"; "Pictures and Signtures")
        {
            trigger OnAfterGetRecord()
            begin
                if strlen("Pictures and Signtures"."Member No") < 6 then
                    myString := PADSTR('', 6 - strlen("Pictures and Signtures"."Member No"), '0') + "Pictures and Signtures"."Member No" else
                    myString := "Pictures and Signtures"."Member No";
                Message(myString);
                "Pictures and Signtures".CalcFields("Pictures and Signtures".Signature, "Pictures and Signtures".Picture);
                if ("Pictures and Signtures".Picture.Hasvalue) or ("Pictures and Signtures".Signature.Hasvalue) then begin
                    if not Img.Get(myString) then begin
                        Img.Init;
                        Img."Member No" := myString;
                        if "Pictures and Signtures".Picture.Hasvalue then
                            Img.Picture := "Pictures and Signtures".Picture;
                        if "Pictures and Signtures".Signature.Hasvalue then
                            Img.Signature := "Pictures and Signtures".Signature;
                        Img.Insert;
                    end else if Img.Get(myString) then begin
                        if "Pictures and Signtures".Picture.Hasvalue then
                            Img.Picture := "Pictures and Signtures".Picture;
                        if "Pictures and Signtures".Signature.Hasvalue then
                            Img.Signature := "Pictures and Signtures".Signature;
                        Img.Modify;
                    end;
                end;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SaccoAccount: Record "Social Listening Sites App.";
        Img: Record "Image Data";
        myString: Code[20];

}
