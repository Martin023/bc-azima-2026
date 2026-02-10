#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186175 pageextension52186175 extends "Adjust Inventory"
{

    //Unsupported feature: Property Modification (Name) on ""Adjust Inventory"(Page 1327)".


    //Unsupported feature: Property Modification (SourceTable) on ""Adjust Inventory"(Page 1327)".

    layout
    {
        // modify(NewInventory)
        // {
        //     ToolTip = 'Specifies the inventory quantity that will be recorded for the item when you choose the OK button. By default, the value in the Current Inventory field is inserted.';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on "NewInventory(Control 4)".

        // }
        modify(BaseUnitofMeasure)
        {

            //Unsupported feature: Property Modification (Name) on "BaseUnitofMeasure(Control 3)".

            ToolTip = 'Specifies the unit in which the item is held on inventory. The base unit of measure also serves as the conversion basis for alternate units of measure.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "BaseUnitofMeasure(Control 3)".

        }

        //Unsupported feature: Property Deletion (Visible) on "General(Control 2)".

        modify(BaseUnitofMeasureNoLocation)
        {
            Visible = false;
        }
        modify(CurrentInventoryNoLocation)
        {
            Visible = false;
        }
        modify(NewInventoryNoLocation)
        {
            Visible = false;
        }
        modify(Control5)
        {
            Visible = false;
        }
        modify("Code")
        {
            Visible = false;
        }
        modify(Name)
        {
            Visible = false;
        }
        modify(NewInventory)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Style) on "NewInventory(Control 4)".


        //Unsupported feature: Property Deletion (StyleExpr) on "NewInventory(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on "BaseUnitofMeasure(Control 3)".

        addafter(BaseUnitofMeasure)
        {
            // field(Inventory; Inventory)
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Current Inventory';
            //     ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are on inventory.';
            // }
        }
        moveafter(General; BaseUnitofMeasure)
    }

    var
        CantFindTemplateOrBatchErr: label 'Unable to find the correct Item Journal template or batch to post this change. Use the Item Journal instead.';
        SimpleInvJnlNameTxt: label 'DEFAULT', Comment = 'The default name of the item journal';
        ItemJnlMgt: Codeunit ItemJnlManagement;
        NewInventory: Decimal;


    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
    /*
    NewInventory := Inventory
    */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CloseAction IN [ACTION::OK,ACTION::LookupOK] THEN BEGIN
      TempItemJournalLine.RESET;
      ErrorText := AdjustItemInventory.PostMultipleAdjustmentsToItemLedger(TempItemJournalLine);
      IF ErrorText <> '' THEN
        MESSAGE(ErrorText);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF CloseAction IN [ACTION::OK,ACTION::LookupOK] THEN
      PostToItemLedger;
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "SelectItemTemplate(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: ItemJnlTemplate) (VariableCollection) on "SelectItemTemplate(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: ItemJnlLine) (VariableCollection) on "SelectItemTemplate(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: JnlSelected) (VariableCollection) on "SelectItemTemplate(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetItem(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Name) on "SetItem(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "SetItem(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetItem(PROCEDURE 3)".

    //procedure SetItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.GET(ItemNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlMgt.TemplateSelection(PAGE::"Item Journal",0,FALSE,ItemJnlLine,JnlSelected);

    ItemJnlTemplate.SETRANGE("Page ID",PAGE::"Item Journal");
    ItemJnlTemplate.SETRANGE(Recurring,FALSE);
    ItemJnlTemplate.SETRANGE(Type,ItemJnlTemplate.Type::Item);
    IF NOT ItemJnlTemplate.FINDFIRST THEN
      ERROR(CantFindTemplateOrBatchErr);

    EXIT(ItemJnlTemplate.Name);
    */
    //end;

    local procedure PostToItemLedger()
    var
        ItemJnlLine: Record "Item Journal Line";
        Completed: Boolean;
    begin
        // if Inventory = NewInventory then
        //     exit;

        // ItemJnlLine.Init;
        // ItemJnlLine.Validate("Journal Template Name", SelectItemTemplate);
        // ItemJnlLine.Validate("Journal Batch Name", CreateItemBatch(ItemJnlLine."Journal Template Name"));
        // ItemJnlLine.Validate("Posting Date", Today);
        // ItemJnlLine."Document No." := "No.";

        // if Inventory < NewInventory then
        //     ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::"Positive Adjmt.")
        // else
        //     ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::"Negative Adjmt.");

        // ItemJnlLine.Validate("Item No.", "No.");
        // ItemJnlLine.Validate(Description, Description);
        // ItemJnlLine.Validate(Quantity, Abs(NewInventory - Inventory));
        // ItemJnlLine.Insert(true);
        // Commit;

        Completed := Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);

        DeleteItemBatch(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");

        if not Completed then
            Message(GetLastErrorText);
    end;

    local procedure CreateItemBatch(TemplateName: Code[10]): Code[10]
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        ItemJnlBatch.Init;
        ItemJnlBatch."Journal Template Name" := TemplateName;
        ItemJnlBatch.Name := CreateBatchName;
        ItemJnlBatch.Description := SimpleInvJnlNameTxt;
        ItemJnlBatch.Insert;

        exit(ItemJnlBatch.Name);
    end;

    local procedure DeleteItemBatch(TemplateName: Code[10]; BatchName: Code[10])
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        if ItemJnlBatch.Get(TemplateName, BatchName) then
            ItemJnlBatch.Delete(true);
    end;

    local procedure CreateBatchName(): Code[10]
    var
        GuidStr: Text;
        BatchName: Text;
    begin
        GuidStr := Format(CreateGuid);
        // Remove numbers to avoid batch name change by INCSTR in codeunit 23
        BatchName := ConvertStr(GuidStr, '1234567890-', 'GHIJKLMNOPQ');
        exit(CopyStr(BatchName, 2, 10));
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "SetItem(PROCEDURE 3).ItemNo(Parameter 1000)".


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (DataCaptionExpr).


    //Unsupported feature: Property Deletion (SourceTableTemporary).

}
