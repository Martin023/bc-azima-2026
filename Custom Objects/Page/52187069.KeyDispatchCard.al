// page 52187074 "Key Dispatch Card"
// {
//     ApplicationArea = All;
//     Caption = 'Key Dispatch Card';
//     PageType = Card;
//     SourceTable = "Office Keys";
//     PromotedActionCategories = 'New,Process,Reports,Creation,Workflows,Views';
//     DeleteAllowed = false;
    
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     Caption = 'Dispatch No.';
//                     ToolTip = 'Specifies the value of the No. field.';
//                     Editable = false;
//                 }
//                 field("Key Request No."; Rec."Key Request No.")
//                 {
//                     ToolTip = 'Specifies the value of the Key Request No. field.';
//                 }

//                 field("Staff Number"; Rec."Staff Number")
//                 {
//                     ToolTip = 'Specifies the value of the Staff Number field.';
//                     Editable = false;
//                 }
//                 field("Staff Name"; Rec."Name")
//                 {
//                     ToolTip = 'Specifies the value of the First Name field.';
//                     Editable = false;
//                 }
//                 field("Department"; Rec."Department")
//                 {
//                     ToolTip = 'Specifies the value of the Department field.';
//                     Editable = false;
//                 }
//                 // field("Key Number"; Rec."Key Number")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Key Number field.';
//                 // }
//                 field("Key Room/Office Name"; Rec."Key Room Name")
//                 {
//                     Caption = 'Key Room/Office Name';
//                     ApplicationArea = All;
//                     Editable = False;
//                    // Caption = 'Key Name';
//                 }
//                 field("Purpose of Key Request"; Rec."Purpose of Key Request")
//                 {
//                     ToolTip = 'Specifies the value of the Purpose of Key Request field.';
//                     Editable = false;
//                 }
//                 // field("Originating Branch"; Rec."Originating Branch")
//                 // {
//                 //     Caption = 'Originating Branch';
//                 //     ToolTip = 'Specifies the value of the Originating Branch field.';
//                 //     Editable = false;
//                 // }
//                 field("Key Request Date"; Rec."Key Request Date")
//                 {
//                     ToolTip = 'Specifies the value of the Key Request Date field.';
//                     Editable = false;
//                 }
//                 // field("Key Dispatch Date"; Rec."Key Dispatch Date")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Key Dispatch Date field.';
//                 //     Editable = false;
//                 // }
//                 field("Received"; Rec."Received")
//                 {
//                     ToolTip = 'Specifies the value of the Received field.';
//                     Editable = false;
//                 }
//                 field("Returned"; Rec."Returned")
//                 {
//                     ToolTip = 'Specifies the value of the Returned field.';
//                     Editable = false;
//                 }
//                 field("Key Status"; Rec."Key Status")
//                 {
//                     ToolTip = 'Specifies the value of the Key Status field.';
//                     Editable = false;
//                 }

//                 field("Key Received By"; Rec."Received By")
//                 {
//                     ToolTip = 'Specifies the value of the Key Received By field.';
//                     Editable = false;
//                 }
//                 field("Received at"; Rec."Received at")
//                 {
//                     ToolTip = 'Specifies the value of the Received Date field.';
//                     Editable = false;
//                 }
//                 field("Created By"; Rec."Created By")
//                 {
//                     ToolTip = 'Specifies the value of the Created By field.';
//                     Editable = false;
//                 }
//                 field("Created at"; Rec."Created at")
//                 {
//                     ToolTip = 'Specifies the value of the Created Date field.';
//                     Editable = false;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Branch Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ToolTip = 'Specifies the value of the Branch field.';
//                     Editable = false;
//                 }
//                 field("Activity Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ToolTip = 'Specifies the value of the Department field.';
//                     Editable = false;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(creation)

//         {
//             action("Dispatch Key")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Dispatch Key';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Keys;
//                 trigger OnAction()
//                 begin
//                     KeyRequest.GET(Rec."Key Request No.");
//                     KeyRequest.SetRange(KeyRequest."No.", Rec."Key Request No.");
//                     if KeyRequest.Find('-') then
//                     begin
//                         if KeyRequest."Key Status" = KeyRequest."Key Status"::"Requested" then
//                     Rec."Key Dispatch Date" := CURRENTDATETIME;
//                     Rec."Key Status" := Rec."Key Status"::"Dispatched";
//                     Rec.MODIFY;
//                     MESSAGE('Key Dispatched');
//                     end;
//                 end;
//             }
//             action("Receive Key")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Receive Key';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Keys;
//                 trigger OnAction()
//                 begin
//                     Rec.Returned := true;
//                     Rec.Received := true;
//                     Rec."Key Status" := Rec."Key Status"::"Received";
//                     Rec.MODIFY;
//                     MESSAGE('Key Received');
//                 end;
//             }
//         }
//     }    
//     var
//     KeyRequest: Record "Key Request Table";  
// }
