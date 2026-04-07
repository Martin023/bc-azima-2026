page 52185722 "Member App Picture & Signature"
{
    Caption = 'Member App Picture & Signature';
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Member Application";

    layout
    {
        area(content)
        {
            group(Pictures)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Picture';
                    ShowMandatory = true;

                }
            }
            group(Signatures)
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Signature';
                    ShowMandatory = true;
                }
            }
            group("ID Cards")
            {
                // field("ID Card"; Rec."ID Card")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("ID Card Front"; Rec."ID Card Front")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("ID Card Back"; Rec."ID Card Back")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
            }
        }
    }

    // actions
    // {
    //     area(creation)
    //     {
    //         action("Take Picture")
    //         {
    //             ApplicationArea = Basic, Suite;
    //             Caption = 'Take Picture';
    //             Image = Camera;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;

    //             trigger OnAction()
    //             var
    //                 Camera: Codeunit Camera;
    //                 Ins: InStream;
    //                 Out: OutStream;
    //                 FileName: Text;
    //             begin
    //                 // if Camera.IsAvailable() then begin
    //                 //     if Camera.GetPicture(Ins, FileName) then begin
    //                 //         Rec.Picture.CreateOutStream(Out);
    //                 //         CopyStream(Out, Ins);
    //                 //         Rec.Modify();
    //                 //     end;
    //                 // end else
    //                 //     Message('Camera is not avalable');
    //             end;
    //         }
    //     }
    // }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        // CameraAvailable := CameraProvider.IsAvailable;
        // IF CameraAvailable THEN
        //  CameraProvider := CameraProvider.Create;

        UpdateControl;
    end;

    var
        // [RunOnClient]
        // [WithEvents]
        // CameraProvider: DotNet CameraProvider;
        CameraAvailable: Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    var
        MemberAppl: Record "Member Application";
    begin
        if MemberAppl.Get(Rec."No.") then begin
            case MemberAppl.Status of
                MemberAppl.Status::Pending, MemberAppl.Status::Approved, MemberAppl.Status::Rejected:
                    begin
                        CurrPage.Editable := false;
                    end;

                MemberAppl.Status::Open:
                    begin
                        CurrPage.Editable := true;
                    end;
            end;
        end;
    end;

    //trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    var
        File: File;
        OutStream: OutStream;
        Instream: InStream;
    //begin
    // if (PictureName = '') or (PictureFilePath = '') then
    //     exit;
    // File.Open(PictureFilePath);
    // File.CreateInStream(Instream);

    // Picture.CreateOutStream(OutStream);
    // CopyStream(OutStream, Instream);
    // Modify(true);

    // File.Close;
    // if Erase(PictureFilePath) then;
    //end;
}

