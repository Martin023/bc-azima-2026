namespace MNS.MNS;

page 52186296 "File Volumes Card"
{
    Caption = 'File Volumes Card';
    PageType = Card;
    SourceTable = "File Volumes";
    PromotedActionCategories = 'New, Home, Process,Closure,Archive,Batch';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                // field("File Type"; Rec."File Type")
                // {
                //     ApplicationArea = All;
                // }
                field("Volume Entry No."; Rec."Volume Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Volume Entry No. field.';
                    Editable = false;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File No. field.';
                }
                field("File Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
                    Caption = 'File Name';
                }
                field("File Volume No."; Rec."File Volume No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Volume No. field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batch No. field.';
                }
                field("Batch"; Rec."Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batch field.';
                    Editable = false;
                }
                field("Volume Status"; Rec."Volume Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Volume Status field.';
                }
                field("Year Opened"; Rec."Year Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year Opened field.';
                    Editable = false;
                }
                field("Year of Closure"; Rec."Year of Closure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year of Closure field.';
                    Editable = false;
                }
                field(Batched; Rec.Batched)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batched field.';
                    Editable = false;
                }
                field("Batched By"; Rec."Batched By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batched By field.';
                    Editable = false;
                }

                field("Archived "; Rec."Archived")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Archived  field.';
                    Editable = false;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Archived By field.';
                    Editable = false;
                }

                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed By field.';
                    Editable = false;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Archived field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created at field.';
                    Editable = false;
                }

                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Code field.';
                    Editable = false;
                }
                field("Responsibility Centre"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Centre field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descrption field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Archive File")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category5;
                Image = Archive;
                Visible = false;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField("Archived", false);
                    Rec.TestField(Closed, true);
                    if Rec.Closed = false then Error('File must be closed before archiving.');
                    if not Confirm('Are you sure you want to archive this file?') then exit;

                    BatchLines.RESET;
                    BatchLines.SetRange("Batch No.", Rec."Batch");
                    if BatchLines.FindSet() then begin
                        BatchLines.Archived := true;
                        BatchLines.Modify();
                    end;
                    Rec."Archived" := true;
                    REc."Archived By" := UserID;
                    Rec."Date Archived" := TODAY;
                    Rec.Modify();
                end;
            }
            action("Batch File")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                Image = Marketing;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    // Rec.TestField(Closed, false);
                    If Rec."Batch No." = ' ' then
                        Error('Batch No. is required')
                    else
                        if not Confirm('Are you sure you want to batch this file?') then exit;
                    Rec."Batched" := true;
                    Rec."Batched By" := UserID;
                    Rec."Date Batched" := Today;
                    Rec.Modify()
                end;
            }
            action("Close File")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                Image = Close;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if not Confirm('Are you sure you want to close this file?') then exit;
                    Rec."Closed By" := UserID;
                    Rec."Date Closed" := CurrentDateTime;
                    Rec."Year of Closure" := Date2DMY(Today, 3);
                    Rec.Closed := True;
                    Rec.Modify();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
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

    var
        BatchLines: Record "Batch Lines Table";
}
