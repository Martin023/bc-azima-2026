#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185472 "Images Upload+"
{
    Caption = '1. Upload Images';
    DefaultLayout = RDLC;
    //RDLCLayout = './BC-2023-V2/Layout/Images Upload+.rdl';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Pictures and Signtures"; "Image Data")
        {
            trigger OnAfterGetRecord()
            var
                PicFileName: Text[1024];
                PicFileName2: Text[1024];
                fileMgt: codeunit "File Management";
            begin
                "Pictures and Signtures".CalcFields(Picture, Signature);

                if "Pictures and Signtures".Picture.Hasvalue then
                    Clear("Pictures and Signtures".Picture);


                PicFileName := StrSubstNo('%1%2.png', FilePath, "Pictures and Signtures"."Old Member No.");
                PicFileName := 'D:\000002.png';
                if FILE.Exists(PicFileName) then begin
                    InputFile.Open(PicFileName);
                    InputFile.CreateInstream(InStream1);
                    "Pictures and Signtures".Picture.CreateOutstream(OutStream1);
                    CopyStream(OutStream1, InStream1);
                    "Pictures and Signtures".Modify;
                    InputFile.Close;
                end;

                //Signature
                if "Pictures and Signtures".Signature.Hasvalue then
                    Clear("Pictures and Signtures".Signature);

                PicFileName2 := StrSubstNo('%1%2.png', FilePath2, "Pictures and Signtures"."Old Member No.");
                if FILE.Exists(PicFileName2) then begin
                    InputFile.Open(PicFileName2);
                    InputFile.CreateInstream(InStream1);
                    "Pictures and Signtures".Signature.CreateOutstream(OutStream1);
                    CopyStream(OutStream1, InStream1);
                    "Pictures and Signtures".Modify;
                    InputFile.Close;
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message('Done Successfully');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(FilePath; FilePath)
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture Path';
                }
                field(FilePath2; FilePath2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature Path';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        FilePath: Text[1024];
        Imge: Codeunit "File Management";
        //PicTable: Record TempBlob;
        InStream1: InStream;
        InputFile: File;
        OutStream1: OutStream;
        FilePath2: Text[1024];
}
