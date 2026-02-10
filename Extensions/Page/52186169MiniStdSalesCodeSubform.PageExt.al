#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186169 pageextension52186169 extends "Office 365 Credentials"
{

    //Unsupported feature: Property Modification (Name) on ""Office 365 Credentials"(Page 1312)".

    Caption = 'Lines';

    //Unsupported feature: Property Modification (SourceTable) on ""Office 365 Credentials"(Page 1312)".


    //Unsupported feature: Property Modification (PageType) on ""Office 365 Credentials"(Page 1312)".


    //Unsupported feature: Property Insertion (MultipleNewLines) on ""Office 365 Credentials"(Page 1312)".


    //Unsupported feature: Property Insertion (LinksAllowed) on ""Office 365 Credentials"(Page 1312)".


    //Unsupported feature: Property Insertion (DelayedInsert) on ""Office 365 Credentials"(Page 1312)".


    //Unsupported feature: Property Insertion (AutoSplitKey) on ""Office 365 Credentials"(Page 1312)".

    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


        //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


        //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

        modify(Password)
        {

            //Unsupported feature: Property Modification (Name) on "Password(Control 4)".

            ToolTip = 'Specifies the number of a general ledger account, an item, a resource, an additional cost or a fixed asset, depending on the contents of the Type field.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Password(Control 4)".

            // LookupPageID = "Mini Item List";
        }

        //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".

        modify(Control7)
        {
            Visible = false;
        }
        modify(Email)
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on "Password(Control 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (PasswordText <> '') AND (NOT ENCRYPTIONENABLED) THEN
          IF CONFIRM(EncryptionManagement.GetEncryptionIsNotActivatedQst) THEN
            PAGE.RUNMODAL(PAGE::"Data Encryption Management");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "No." = xRec."No." THEN
          EXIT;

        IF "No." <> '' THEN
          Type := Type::Item;
        */
        //end;

        //Unsupported feature: Property Deletion (ExtendedDatatype) on "Password(Control 4)".

        modify(StatusText)
        {
            Visible = false;
        }
        modify(WhySignInIsNeededLbl)
        {
            Visible = false;
        }
        addfirst(content)
        {
        }
        // addfirst(Password)
        // {
        //     field(Description;Description)
        //     {
        //         ApplicationArea = Basic;
        //         ToolTip = 'Contains a description of the entry. The description depends on what you chose in the Type and No. fields. If the Type field is not blank, the program will fill in the field when you enter something in the No. field. You can change the contents of the field.';

        //         trigger OnValidate()
        //         begin
        //             if Description = xRec.Description then
        //               exit;

        //             if "No." = '' then
        //               Type := Type::" ";
        //         end;
        //     }
        //     field(Quantity;Quantity)
        //     {
        //         ApplicationArea = Basic;
        //         ToolTip = 'Specifies the number of units of the item on the line. The field can be blank if the quantity will vary. Then you can enter a quantity when you insert the line on a document.';
        //     }
        //     field("Unit of Measure Code";"Unit of Measure Code")
        //     {
        //         ApplicationArea = Basic;
        //         ToolTip = 'Specifies the unit of measure code to use to determine the unit price. If the line type is Item, the value is automatically copied from the Sales Unit of Measure field on the Item Card.';
        //         Visible = false;
        //     }
        //     field("Amount Excl. VAT";"Amount Excl. VAT")
        //     {
        //         ApplicationArea = Basic;
        //         ToolTip = 'Applies only to lines with the type G/L Account or Charge (Item). You cannot enter an amount on lines with types other than G/L Account or Charge (Item).';
        //         Visible = false;
        //     }
        // }
    }
    actions
    {
        addfirst(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
            }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Basic;
                Caption = 'Dimensions';
                Image = Dimensions;
                Scope = Repeater;
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'Set up default dimensions for the item, such as a department or project code. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                trigger OnAction()
                begin
                    //ShowDimensions;
                end;
            }
        }
    }


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
    /*
    Type := Type::Item;
    */
    //end;

    //Unsupported feature: Property Deletion (Permissions).


    //Unsupported feature: Property Deletion (SourceTableTemporary).

}
