// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185428 PostBatches2
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/PostBatches2.rdl';

//     dataset
//     {
//         dataitem("Gen. Journal Line"; "Gen. Journal Line")
//         {
//             DataItemTableView = where(Posted = const(False));


//             trigger OnAfterGetRecord()
//             begin

//                 GenJnl.Init;
//                 GenJnl."Journal Template Name" := 'GENERAL';
//                 GenJnl."Journal Batch Name" := 'OPENING';
//                 GenJnl."Line No." := GenJnl."Line No." + 1000;
//                 GenJnl."Account Type" := "Gen. Journal Line"."Account Type";
//                 GenJnl."Document No." := "Gen. Journal Line"."Document No.";
//                 GenJnl."Posting Date" := "Gen. Journal Line"."Posting Date";
//                 GenJnl."Account No." := "Gen. Journal Line"."Account No.";
//                 GenJnl.Validate(GenJnl."Account No.");
//                 GenJnl.Description := "Gen. Journal Line".Description;
//                 GenJnl.Amount := "Gen. Journal Line".Amount;
//                 GenJnl.Validate(GenJnl.Amount);
//                 GenJnl."Bal. Account Type" := "Gen. Journal Line"."Bal. Account Type";
//                 GenJnl."Bal. Account No." := "Gen. Journal Line"."Bal. Account No.";
//                 GenJnl.Validate(GenJnl."Bal. Account No.");
//                 GenJnl."Loan No" := "Gen. Journal Line"."Loan No";
//                 GenJnl."Transaction Type" := "Gen. Journal Line"."Transaction Type";
//                 GenJnl."Group Code" := "Gen. Journal Line"."Group Code";
//                 GenJnl."Applies-to Doc. No." := "Gen. Journal Line"."Applies-to Doc. No.";
//                 GenJnl."External Document No." := "Gen. Journal Line"."External Document No.";
//                 GenJnl.Validate(GenJnl."Applies-to Doc. No.");
//                 GenJnl."Document Type" := "Gen. Journal Line"."Document Type";
//                 GenJnl."Currency Code" := "Gen. Journal Line"."Currency Code";
//                 GenJnl."Shortcut Dimension 1 Code" := "Gen. Journal Line"."Shortcut Dimension 1 Code";
//                 GenJnl."Shortcut Dimension 2 Code" := "Gen. Journal Line"."Shortcut Dimension 2 Code";
//                 GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
//                 GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
//                 GenJnl.Validate(GenJnl."Currency Code");
//                 GenJnl."Applies-to Doc. Type" := "Gen. Journal Line"."Applies-to Doc. Type";
//                 if GenJnl.Amount <> 0 then
//                     GenJnl.Insert;

//                 GenJnl.Reset;
//                 GenJnl.SetRange(GenJnl."Journal Template Name", 'GENERAL');
//                 GenJnl.SetRange(GenJnl."Journal Batch Name", 'OPENING');
//                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJnl);
//                 "Gen. Journal Line".Posted := true;
//                 "Gen. Journal Line".Modify;
//                 Commit;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         GenJnl: Record "Gen. Journal Line";
// }
