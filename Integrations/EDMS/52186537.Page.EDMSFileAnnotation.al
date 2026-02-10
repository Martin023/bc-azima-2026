page 52186537 "EDMS File Annotation"
{
    ApplicationArea = All;
    Caption = 'EDMS File Annotation';
    AboutTitle = 'EDMS File Annotation';
    PageType = Card;
    SourceTable = "EDMS Files";

    DataCaptionFields = "Application No.", "EDMS Document Name";

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Website)
            {
                ShowCaption = False;
                usercontrol(OmniDocs; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = All;
                }
            }
            // field("Origination No."; Rec."Application No.")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Origination No.';
            //     Editable = False;
            //     // ExtendedDatatype = URL;
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if EDMSAPISetup.FindFirst then begin

            PostURL := EDMSAPISetup."Web API POST URL";

            if PostURL = '' then begin
                Error('Incomplete EDMS API setup. Contact the system administrator for assistance');
            end;

            case Rec."EDMS Data Class Name" of
                Rec."EDMS Data Class Name"::BusinessLoansFile:
                    begin
                        HTMLTextLoan := '<html> <head> <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"> <script> function onSubmit() { window.open("","newWin","location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no,left=100,top=20,width=1000,height=1000"); this.sharedEmitterService.viewOpenedInNewTab = true } </script> </script> <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script> </head> <body> <form style="width: 13rem ; " class="m-2 col-6" id="webAPiFormRequest" method="POST" onsubmit="onSubmit()"  action="' + PostURL + '"  target="newWin" > <input type="hidden" name="Application" value="Loan"> <input type="hidden" name="cabinetName" value="MNSUAT"> <input type="hidden" name="sessionIndexSet" value="false"> EDMS UserName<br> <input class="form-control form-control-sm" type="text" id="username" aria-label = "UserName" name="UserName" value=""><br> EDMS Password<br> <input class="form-control form-control-sm" type="password" aria-label = "Password" name="UserPassword" value=""><br> <input type="hidden" name="DataClassName" required value="' + Format(Rec."EDMS Data Class Name") + '">CRM_number<br> <input type="text" class="form-control form-control-sm" pattern="\s*\S.*" title="Enter atleast one non-whitespace character ." id="firstField"  aria-label=" CRM_number " name="DC.CRM_number" value="' + Rec."Application No." + '" readonly><br> <input type="hidden" name="sessionIndexSet" value="false"><br> <input type="hidden" name="enableDCInfo" value="true"/> <input type="hidden" name="S" value="S" /> <input aria-describedby="openinnewtab" class="btn btn-default btn-sm theme-background-color theme-background-color-6-7 theme-border-color theme-white-color1 color-white" type="submit" value=Search onclick="onSubmit();"><br> <p class="d-none" id="openinnewtab">preview will Open in new tab</p> </form> </body> </html>';

                        CurrPage.OmniDocs.SetContent(HTMLTextLoan);
                    end;
                Rec."EDMS Data Class Name"::MemberFile:
                    begin
                        HTMLTextMember := '<html> <head> <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"> <script> function onSubmit() { window.open("","newWin","location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no,left=100,top=20,width=1000,height=1000"); this.sharedEmitterService.viewOpenedInNewTab = true } </script> </script> <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script> </head> <body> <form style="width: 13rem ; " class="m-2 col-6" id="webAPiFormRequest" method="POST" onsubmit="onSubmit()"  action="' + PostURL + '"  target="newWin" > <input type="hidden" name="Application" value="Member"> <input type="hidden" name="cabinetName" value="MNSUAT"> <input type="hidden" name="sessionIndexSet" value="false"> EDMS UserName<br> <input class="form-control form-control-sm" type="text" id="username" aria-label = "UserName" name="UserName" value=""><br> EDMS Password<br> <input class="form-control form-control-sm" type="password" aria-label = "Password" name="UserPassword" value=""><br> <input type="hidden" name="DataClassName" required value="' + Format(Rec."EDMS Data Class Name") + '">CRM_number<br> <input type="text" class="form-control form-control-sm" pattern="\s*\S.*" title="Enter atleast one non-whitespace character ." id="firstField"  aria-label=" CRM_number " name="DC.CRM_number" value="' + Rec."Application No." + '" readonly><br> <input type="hidden" name="sessionIndexSet" value="false"><br> <input type="hidden" name="enableDCInfo" value="true"/> <input type="hidden" name="S" value="S" /> <input aria-describedby="openinnewtab" class="btn btn-default btn-sm theme-background-color theme-background-color-6-7 theme-border-color theme-white-color1 color-white" type="submit" value=Search onclick="onSubmit();"><br> <p class="d-none" id="openinnewtab">preview will Open in new tab</p> </form> </body> </html>';

                        CurrPage.OmniDocs.SetContent(HTMLTextMember);
                    end;
                else
            end;

        end else begin
            Error('Incomplete EDMS API setup. Contact the system administrator for assistance');
        end;
    end;

    var
        HTMLTextLoan: Text;
        HTMLTextMember: Text;
        PostURL: Text;

        EDMSAPISetup: Record "EDMS API Setup";
}
