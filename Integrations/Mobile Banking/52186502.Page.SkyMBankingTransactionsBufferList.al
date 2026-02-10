page 52186502 "Sky M-Banking Trans. Buffer"
{
    ApplicationArea = basic, suite;
    Caption = 'Sky Mobile Banking Transactions List';
    PageType = List;
    SourceTable = "Sky M-Banking Trans. Buffer";
    UsageCategory = Administration;
    CardPageId = "Sky M-Banking Trans. Buf. Card";
    SourceTableView = sorting("Transaction Date Time") Order(descending);

    InsertAllowed = false;
    DeleteAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Originator ID"; Rec."Originator ID")
                {
                    ToolTip = 'Specifies the value of the Originator ID field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transaction Status"; Rec."Transaction Status")
                {
                    ToolTip = 'Specifies the value of the Transaction Status field.';
                }
                field("Beneficiary Reference"; Rec."Beneficiary Reference")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Reference field.';
                }
                field("Savings Account"; Rec."Savings Account")
                {
                }
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Amount field.';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field("PESA Type"; Rec."PESA Type")
                {
                    ToolTip = 'Specifies the value of the PESA Type field.';
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                    ToolTip = 'Specifies the value of the Transaction Category field.';
                }
                field("Identifier Type"; Rec."Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Identifier Type field.';
                }
                field(Identifier; Rec.Identifier)
                {
                    ToolTip = 'Specifies the value of the Identifier field.';
                }
                field("Initiator Identifier Type"; Rec."Initiator Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Identifier Type field.';
                }
                field("Initiator Identifier"; Rec."Initiator Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Identifier field.';
                }
                field("Source Identifier Type"; Rec."Source Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Identifier Type field.';
                }
                field("Source Identifier"; Rec."Source Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Identifier field.';
                }
                field("Sender Identifier Type"; Rec."Sender Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Identifier Type field.';
                }
                field("Sender Identifier"; Rec."Sender Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Identifier field.';
                }
                field("Receiver Identifier Type"; Rec."Receiver Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Identifier Type field.';
                }
                field("Receiver Identifier"; Rec."Receiver Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Identifier field.';
                }
                field("Beneficiary Identifier Type"; Rec."Beneficiary Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Identifier Type field.';
                }
                field("Beneficiary Identifier"; Rec."Beneficiary Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Identifier field.';
                }

                field("Transaction Source Reference"; Rec."Transaction Source Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Reference field.';
                }
                field("Transaction Date Time"; Rec."Transaction Date Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Date Time field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field("Posted"; Rec.Posted)
                {
                    toolTip = 'Specifies the value of the Posted field.';
                }
                field("Loan No."; Rec."Loan No.") { }
                field("Loan Account"; Rec."Loan Account") { }

                field("Destination Account"; Rec."Destination Account") { }
                field("Posting Date"; Rec."Posting Date") { }
                field("Posting Time"; Rec."Posting Time") { }
                field("Posted By"; Rec."Posted By") { }
                field("Needs Change"; Rec."Needs Change")
                {
                    Editable = false;
                }
                field("Needs Change Reason"; Rec."Needs Change Reason")
                {
                    Editable = false;
                }

                field("Change Type"; Rec."Change Type") { }
                field("Changed By"; Rec."Changed By") { }
                field("Changed Date"; Rec."Changed Date") { }
                field("Changed Time"; Rec."Changed Time") { }
                field("Try Posting Count"; Rec."Try Posting Count") { }
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
        StatusPermission.SetRange("Mbanking - View", true);

        if not StatusPermission.Find('-') then begin
            // CurrPage.Editable := false;
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end
        // else begin
        //     CurrPage.Editable := true;
        // end;
    end;
}
