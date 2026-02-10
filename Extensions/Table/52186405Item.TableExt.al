#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186405 tableextension52186405 extends Item
{
    
    fields
    {
        field(50000;"Item G/L Budget Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                // Control to prevent Modification once Entry Exist
                //TestNoEntriesExist(FIELDCAPTION("Item G/L Budget Account"));
            end;
        }
        field(50001; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50002;"Physical Count";Integer)
        {
            trigger onValidate()
            var
            Item:record Item;
            begin
             Item.reset();
        Item.SetRange("No.",rec."No.");
        if item.findfirst() then begin
            if "Physical Count"=0 then Variance:=0 else 
            rec.Variance:=rec.Inventory - rec."Physical Count";
            "Physical Count Date":=Today;
        end;
            end;

        }
        field(50003;"Variance";Integer)
        {

        }
        field(50004;"Inventory Stock";Decimal)
        {
             CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Drop Shipment" = field("Drop Shipment Filter")));
                                                                
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005;"Physical Count Date";date)
        {
         
        }
        field(50006;"Created By";code[20])
        {
            
        }
         field(50007;"Disposal Date";date)
        {
            trigger OnValidate() begin
              
            end;
            
        }
         field(50008;"Disposal Reason";text[100])
        {
            
        }
         field(50009;"Disposal Method";text[100])
        {
            
        }
    }
    trigger OnBeforeInsert() begin
        "Created By":=UserId;
         
       
    end;
  
    
    
}
