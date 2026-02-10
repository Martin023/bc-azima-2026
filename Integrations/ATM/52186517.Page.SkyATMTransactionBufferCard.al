page 52186517 "Sky ATM Trans. Buffer Card"
{
    ApplicationArea = All;
    Caption = 'Sky ATM Transaction';
    PageType = Card;
    SourceTable = "Sky ATM Transactions Buffer";

    DataCaptionFields = "Document No.", "Transaction Type";

    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            group("Primary Information")
            {
                Caption = 'Primary Information';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Member Savings Account"; Rec."Member Savings Account")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member Savings Account Name"; Rec."Member Savings Account Name")
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ToolTip = 'Specifies the value of the Transaction ID/Reference field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Service Name"; Rec."Service Name")
                {
                    ToolTip = 'Specifies the value of the Service Name field.';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.';
                }
                field("Original Message ID"; Rec."Original Message ID")
                {
                    ToolTip = 'Specifies the value of the Original Message ID field.';
                }
                field("Is Coop Reversal"; Rec."Is Coop Reversal")
                {
                    ToolTip = 'Specifies the value of the Original Message ID field.';
                }
                field("Transaction Date Time"; Rec."Transaction Date Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Date Time field.';
                }
                field("Terminal ID"; Rec."Terminal ID")
                {
                    ToolTip = 'Specifies the value of the Terminal ID field.';
                }
                field(Channel; Rec.Channel)
                {
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("Credit Account"; Rec."Credit Account")
                {
                    ToolTip = 'Specifies the value of the SACCO Bank Account Number field.';
                }
                // field("Debit Account"; Rec."Debit Account")
                // {
                //     ToolTip = 'Specifies the value of the SACCO Member Identifier Number field.';
                // }
                field("Institution Code"; Rec."Institution Code")
                {
                    ToolTip = 'Specifies the value of the SACCO Code field.';
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ToolTip = 'Specifies the value of the SACCO Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Commission field.';
                }
                field("Charge Currency"; Rec."Charge Currency")
                {
                    ToolTip = 'Specifies the value of the Transaction Commission Currency field.';
                }
                field("Fee Amount"; Rec."Fee Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Fee field.';
                }
                field("Fee Currency"; Rec."Fee Currency")
                {
                    ToolTip = 'Specifies the value of the Transaction Fee Currency field.';
                }
                field("Transaction Narration"; Rec."Transaction Narration")
                {
                    ToolTip = 'Specifies the value of the Transaction Narration field.';
                    MultiLine = true;
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Transaction Location field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posting Remarks"; Rec."Posting Remarks")
                {
                    ToolTip = 'Specifies the value of the Posting Remarks field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posting Time"; Rec."Posting Time")
                {
                    ToolTip = 'Specifies the value of the Posting Time field.';
                }

                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ToolTip = 'Specifies the value of the Reversed By field.';
                }
                field("Reversed Date"; Rec."Reversed Date")
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Reversed Time"; Rec."Reversed Time")
                {
                    ToolTip = 'Specifies the value of the Reversed Time field.';
                }
                field("Try Posting Count"; Rec."Try Posting Count")
                {
                    editable = false;
                }
            }
            group("Other Information")
            {
                Caption = 'Other Information';

                field("Mobile Number"; Rec."Mobile Number")
                {
                    ToolTip = 'Specifies the value of the Mobile Number field.';
                }
                field("API Request ID"; Rec."API Request ID")
                {
                    ToolTip = 'Specifies the value of the API Request ID/Reference field.';
                }
                field("Additional Info"; Rec."Additional Info")
                {
                    ToolTip = 'Specifies the value of the Additional Info field.';
                    MultiLine = true;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        FnRestrictAccess
    end;

    var
        StatusPermission: Record "Status Change Permissions.";

    //[Scope('OnPrem')]
    procedure FnRestrictAccess()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do not have permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("ATM - View", true);

        if not StatusPermission.Find('-') then begin
            // CurrPage.Editable := false;
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end
        // else begin
        //     CurrPage.Editable := true;
        // end;
    end;
}
