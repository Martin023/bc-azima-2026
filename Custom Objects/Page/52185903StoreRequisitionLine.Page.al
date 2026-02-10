page 52185903 "Store Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Store Requistion Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Requistion No"; Rec."Requistion No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = Quantity1;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    // Editable = EditField;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = EditField;
                    Enabled = false;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = Basic;
                     Editable = Quantity1;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Remark';
                    Editable = EditField;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    Editable = Quantity1;
                }
                field("Qty in store"; Rec."Qty in store")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {

                    ApplicationArea = Basic;
                    Editable = Quantity1;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if rec."Quantity Requested" <= 0 then Error('Please input a positive quantity');
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic;
                    //Editable = Quantity1;
                    editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic;
                    editable = false;
                     //Editable = Quantity1;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    Caption = 'Quantity To Issue';
                    Editable = EditField;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        if rec.Quantity <= 0 then Error('Please input a positive quantity');
                    end;

                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = Quantity1;
                }

                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = Quantity1;
                }

                // field("Item Status"; Rec."Item Status")
                // {
                //     ApplicationArea = Basic;
                //      Editable = false;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                }
                action("Item Tracking Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance

    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    procedure SetControlAppearance()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        EditField := TRUE;
        StoreRequistionHeader.Reset;
        StoreRequistionHeader.SetRange("No.", Rec."Requistion No");
        if StoreRequistionHeader.FindFirst then begin
            if StoreRequistionHeader.Posted = true then begin
                EditField := false;
                Quantity1 := FALSE;
            end
            else
                if StoreRequistionHeader.Status = StoreRequistionHeader.Status::open then begin
                    EditField := true;
                    Quantity1 := true;
                end else
                    if StoreRequistionHeader.Status = StoreRequistionHeader.Status::"Pending Approval" then begin
                        Quantity1 := false;
                        EditField := true;
                    end else
                        if StoreRequistionHeader.Status = StoreRequistionHeader.Status::Released then begin
                            Quantity1 := false;
                            EditField := true;
                        end;
        end;
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        EditField: Boolean;
        Quantity1: boolean;
        StoreRequistionHeader: Record "Store Requistion Header";
}

