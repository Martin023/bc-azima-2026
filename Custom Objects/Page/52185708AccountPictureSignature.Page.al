page 52185708 "Account  Picture & Signature"
{
    Caption = 'Account  Picture & Signature';
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Savings Account Application";

    layout
    {
        area(content)
        {
            group(Pictures)
            {
                field(Picture; Rec.Picture)
                {
                    Caption = 'Picture';
                    ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Signatures)
            {
                field(Signature; Rec.Signature)
                {
                    Caption = 'Signature';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Take Picture")
            {
                Caption = 'Take Picture';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = CameraAvailable;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    // IF NOT CameraAvailable THEN
                    //  EXIT;
                    // CameraOptions := CameraOptions.CameraOptions;
                    // CameraOptions.Quality := 100;
                    // CameraProvider.RequestPictureAsync(CameraOptions);
                end;
            }
        }
    }

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
        CameraAvailable: Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    var
        MemberAppl: Record "Member Application";
    begin
        if MemberAppl.Get(rec."No.") then begin
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
}

