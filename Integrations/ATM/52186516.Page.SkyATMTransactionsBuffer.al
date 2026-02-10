page 52186516 "Sky ATM Transactions Buffer"
{
    ApplicationArea = All;
    Caption = 'Sky ATM Transactions List';
    PageType = List;
    SourceTable = "Sky ATM Transactions Buffer";
    UsageCategory = Administration;
    CardPageId = "Sky ATM Trans. Buffer Card";
    SourceTableView = sorting("Transaction Date Time") Order(descending);

    PromotedActionCategories = 'Generate';

    InsertAllowed = false;
    DeleteAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Date Time"; Rec."Transaction Date Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Date Time field.';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(Location; Rec.Location)
                {
                    editable = false;
                }
                field("Debit Account"; Rec."Debit Account")
                {
                    Caption = 'Card Number';
                    ToolTip = 'Specifies the value of the SACCO Member Identifier Number field.';
                }
                field("Fee Amount"; Rec."Fee Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Fee field.';
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Commission field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    editable = false;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    editable = false;
                }
                field("Reversed Date"; Rec."Reversed Date")
                {
                    editable = false;
                }
                field("Reversed Time"; Rec."Reversed Time")
                {
                    editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Service Name"; Rec."Service Name")
                {
                    ToolTip = 'Specifies the value of the Service Name field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Member Savings Account"; Rec."Member Savings Account")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member Savings Account Name"; Rec."Member Savings Account Name")
                {
                    ToolTip = 'Specifies the value of the Name field.';
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
                field("Institution Code"; Rec."Institution Code")
                {
                    ToolTip = 'Specifies the value of the SACCO Code field.';
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ToolTip = 'Specifies the value of the SACCO Name field.';
                }
                field("Charge Currency"; Rec."Charge Currency")
                {
                    ToolTip = 'Specifies the value of the Transaction Commission Currency field.';
                }
                field("Fee Currency"; Rec."Fee Currency")
                {
                    ToolTip = 'Specifies the value of the Transaction Fee Currency field.';
                }
                field("Transaction Narration"; Rec."Transaction Narration")
                {
                    ToolTip = 'Specifies the value of the Transaction Narration field.';
                }
                field("Additional Info"; Rec."Additional Info")
                {
                    ToolTip = 'Specifies the value of the Additional Info field.';
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ToolTip = 'Specifies the value of the Transaction ID/Reference field.';
                }
                field("API Request ID"; Rec."API Request ID")
                {
                    ToolTip = 'Specifies the value of the API Request ID/Reference field.';
                }
                field(Posted; Rec.Posted)
                {
                    editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    editable = false;
                }
                field("Posting Remarks"; Rec."Posting Remarks")
                {
                    editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    editable = false;
                }
                field("Posting Time"; Rec."Posting Time")
                {
                    editable = false;
                }
                field("Try Posting Count"; Rec."Try Posting Count")
                {
                    editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Document No.")
            {
                Caption = 'Generate Transactions Coop Document No.';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;
                Image = BulletList;
                trigger OnAction()
                var
                    SkyATMTransactions: Record "Sky ATM Transactions Buffer";
                begin
                    SkyATMTransactions.Reset;
                    SkyATMTransactions.SetRange("Document No.", '');
                    if SkyATMTransactions.FindSet() then begin
                        repeat begin
                            SkyATMTransactions."Document No." := SkyATMTransactions."Message ID".Split('_').Get(1);
                            SkyATMTransactions.Modify;
                        end until SkyATMTransactions.Next = 0;
                        Message('Document No.s generated successfully!');
                    end else begin
                        Message('No transactions with missing Document No.s');
                    end;
                end;
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
