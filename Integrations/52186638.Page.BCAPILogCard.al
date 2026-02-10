page 52186638 "BC API Log Card"
{
    ApplicationArea = All;
    Caption = 'BC API Log';
    PageType = Card;
    SourceTable = "BC API Logs";

    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Details)
            {
                Caption = 'Details';
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field("Large Text"; Rec."Large Text")
                {
                    Caption = 'Large Text';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Large Text field.';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        SetLargeText(LargeText);
                    end;
                }
                field(Miscellaneous; Rec.Miscellaneous)
                {
                    ToolTip = 'Specifies the value of the Miscellaneous field.';
                    MultiLine = true;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
            }
            group(Request)
            {
                Caption = 'Request';

                field("Request URL"; Rec."Request URL")
                {
                    ToolTip = 'Specifies the value of the Request URL field.';
                }
                field("Request Headers"; Rec."Request Headers")
                {
                    ToolTip = 'Specifies the value of the Request Headers field.';
                    MultiLine = true;
                }
                field("Request Data"; Rec."Request Data")
                {
                    ToolTip = 'Specifies the value of the Request Data field.';
                    MultiLine = true;
                }
            }
            group(Response)
            {
                Caption = 'Response';

                field("Response Data"; Rec."Response Data")
                {
                    ToolTip = 'Specifies the value of the Response Data field.';
                    MultiLine = true;
                }
                field("Response Headers"; Rec."Response Headers")
                {
                    ToolTip = 'Specifies the value of the Response Headers field.';
                    MultiLine = true;
                }
                field("Response Status Code"; Rec."Response Status Code")
                {
                    ToolTip = 'Specifies the value of the Response Status Code field.';
                }
            }
        }
    }

    var
        LargeText: Text;

    trigger OnAfterGetCurrRecord()
    begin
        LargeText := GetLargeText;
    end;

    local procedure SetLargeText(NewLargeText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."Large Text");
        Rec."Large Text".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(LargeText);
        Rec.Modify;
    end;

    local procedure GetLargeText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields("Large Text");
        Rec."Large Text".CreateInStream(InStream, TextEncoding::UTF8);
        exit(
            TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator, Rec.FieldName("Large Text"))
        );
    end;

    // -------------------------------------------------------------------------------------------------------------------------------------------
    trigger OnOpenPage()
    begin
        FnRestrictAccess();
    end;

    procedure FnRestrictAccess()
    var
        StatusPermission: Record "Status Change Permissions.";
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do not have permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("Edit Setup", true);
        StatusPermission.SetRange("Function Extended", StatusPermission."Function Extended"::Administrator);

        if not StatusPermission.Find('-') then begin
            // CurrPage.Editable := false;
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end
        // else begin
        //     CurrPage.Editable := true;
        // end;
    end;
}
