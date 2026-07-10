namespace MNS.MNS;
using AZIMA.AZIMA;

page 52187371 "Files Card"
{
    ApplicationArea = All;
    Caption = 'File Card';
    PageType = Card;
    SourceTable = "Files Table";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("File Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    ToolTip = 'Specifies the value of the File Type field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."File Type" = Rec."File Type"::"Business Loans File" then begin
                            VisibleBusinessLoansFileTypes := true;
                            VisiblePolicyFilesTypes := false
                        end;
                        if Rec."File Type" = Rec."File Type"::"Policy Files" then begin
                            VisiblePolicyFilesTypes := true;
                            VisibleBusinessLoansFileTypes := false;
                        end;
                    end;
                }
                // field("File Sub Type"; Rec."File Sub Type")
                // {
                //     ToolTip = 'Specifies the value of the File Sub Type field.';
                // }
                field("Business Loans File Types"; Rec."Business Loan Types")
                {
                    ToolTip = 'Specifies the value of the Business Loan Type field.';
                    //Visible = VisibleBusinessLoansFileTypes;
                    visible = false;
                }
                field("Policy Files Types"; Rec."Policy Files Types")
                {
                    ToolTip = 'Specifies the value of the Policy Files Types field.';
                    Visible = VisiblePolicyFilesTypes;
                }
                field("File/Member No."; Rec."File/Member No.")
                {
                    ToolTip = 'Specifies the value of the File/Member No. field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'File No.';
                }
                field("File Name/Descrption"; Rec."File Name/Descrption")
                {
                    ToolTip = 'Specifies the value of the File Name/Descrption field.';
                }
                field("Staff PF No."; Rec."Staff PF No.")
                {
                    ToolTip = 'Specifies the value of the Staff PF No. field.';
                    //Editable = false;
                }
                field("File Custodian"; Rec."File Custodian")
                {
                    ToolTip = 'Specifies the value of the File Custodian field.';
                }
                field("File Status"; Rec."File Status")
                {
                    ToolTip = 'Specifies the value of the Stage field.';
                    Editable = false;
                }
                field("Member Status"; Rec."Member Status")
                {
                    Editable = false;
                }
                //HR Files
                // field("Staff No."; Rec."Staff No.")
                // {
                //     ToolTip = 'Specifies the value of the Staff No. field.';
                //     //Visible = false;
                // }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.';
                    //Visible = false;
                }
                field("File Volume No."; Rec."File Volume No.")
                {
                    ToolTip = 'Specifies the value of the File Volume No. field.';
                }
                field("File Batch No."; Rec."File Batch No.")
                {
                    ToolTip = 'Specifies the value of the File Batch No. field.';
                }
                field("Archived"; Rec.Archived)
                {
                    ToolTip = 'Specifies the value of the Archived field.';
                    Editable = false;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ToolTip = 'Specifies the value of the Date Archived field.';
                    Editable = false;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ToolTip = 'Specifies the value of the Archived By field.';
                }

            }
            part(Control1; "Member Form Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Member No." = field("File/Member No.");
            }
        }

    }
    //local procedure PageControl()
    trigger OnOpenPage()
    begin
        FileTypes();
        restrictfilescardesit()
    end;

    trigger OnAfterGetCurrRecord()
    begin
        restrictfilescardesit();
    end;

    local procedure restrictfilescardesit()
    var
        UserStations: Record "User Stations";
    begin
        UserStations.Reset();
        UserStations.SetRange("User Id", UserId);
        UserStations.SetRange("Can Edit File Card", true);
        if not UserStations.Find('-') then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;

    local procedure FileTypes()
    begin
        VisiblePolicyFilesTypes := false;
        VisibleBusinessLoansFileTypes := false;

        // if Rec."File Type" = Rec."File Type"::"Business Loans File" then begin
        //     VisibleBusinessLoansFileTypes := true;
        //     VisiblePolicyFilesTypes := false;
        // end;
        if Rec."File Type" = Rec."File Type"::"Policy Files" then begin
            VisiblePolicyFilesTypes := true;
            VisibleBusinessLoansFileTypes := false;
        end;
    end;
    //trigger OnAfterGetRecord()
    var
        VisiblePolicyFilesTypes: Boolean;
        VisibleBusinessLoansFileTypes: Boolean;
}
