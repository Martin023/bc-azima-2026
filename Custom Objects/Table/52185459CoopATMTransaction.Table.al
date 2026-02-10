// table 52185459 "Coop ATM Transaction"
// {
//     DrillDownPageID = "Coop ATM Transactions";
//     LookupPageID = "Coop ATM Transactions";

//     fields
//     {
//         field(1; "Transaction ID"; Code[50])
//         {
//         }
//         field(2; "Service Name"; Text[50])
//         {
//         }
//         field(3; "Transaction Date"; Date)
//         {
//         }
//         field(4; "Transaction Time"; Time)
//         {
//         }
//         field(5; "Terminal ID"; Text[50])
//         {
//         }
//         field(6; Channel; Text[30])
//         {
//         }
//         field(7; "Sacco Account"; Code[50])
//         {
//         }
//         field(8; "Member Account"; Code[20])
//         {
//         }
//         field(9; "Institution Code"; Code[50])
//         {
//         }
//         field(10; "Institution Name"; Text[100])
//         {
//         }
//         field(11; Commission; Decimal)
//         {
//         }
//         field(12; "Commission Currency"; Code[20])
//         {
//         }
//         field(13; "Fee Charged"; Decimal)
//         {
//         }
//         field(14; "Fee Currency"; Code[20])
//         {
//         }
//         field(15; "Description 1"; Text[250])
//         {
//         }
//         field(16; Activity; Option)
//         {
//             OptionCaption = ' ,Balance Enquiry,Funds Transfer,MiniStatement,Reversal';
//             OptionMembers = " ","Balance Enquiry","Funds Transfer",MiniStatement,Reversal;
//         }
//         field(17; Amount; Decimal)
//         {
//         }
//         field(18; Posted; Boolean)
//         {
//         }
//         field(19; "Date Posted"; Date)
//         {
//         }
//         field(20; "Time Posted"; Time)
//         {
//         }
//         field(21; "Posted By"; Code[50])
//         {
//         }
//         field(22; Reversed; Boolean)
//         {
//         }
//         field(23; "Date Reversed"; Date)
//         {
//         }
//         field(24; "Time Reversed"; Time)
//         {
//         }
//         field(25; "Reversed By"; Code[50])
//         {
//         }
//         field(26; "Reversal ID"; Code[50])
//         {
//         }
//         field(27; "Transaction Type"; Code[20])
//         {
//         }
//         field(28; "Transaction Name"; Text[50])
//         {
//         }
//         field(29; "Description 2"; Text[250])
//         {
//         }
//         field(30; "Original Transaction ID"; Code[50])
//         {
//         }
//         field(31; "Amount Currency"; Code[10])
//         {
//         }
//         field(32; "ATM No."; Text[30])
//         {
//         }
//         field(33; "Document No."; Code[20])
//         {
//         }
//         field(34; "Channel Code"; Code[10])
//         {
//         }
//         field(35; "Terminal Code"; Code[10])
//         {
//         }
//         field(36; "Total Account Debit"; Decimal)
//         {
//         }
//         field(37; "Total Charges"; Decimal)
//         {
//         }
//         field(38; "Coop Fee"; Decimal)
//         {
//         }
//         field(39; "Sacco Fee"; Decimal)
//         {
//         }
//         field(40; "Sacco Excise Duty"; Decimal)
//         {
//         }
//         field(41; Skipped; Boolean)
//         {
//         }
//         field(42; Remarks; Text[250])
//         {
//         }
//         field(43; Name; Text[200])
//         {
//             CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Member Account")));
//             FieldClass = FlowField;
//         }
//         field(45; "Device Type"; Text[100])
//         {
//         }
//         field(46; Location; Text[100])
//         {
//         }
//         field(47; "Conversion Rate"; Decimal)
//         {
//         }
//         field(48; "Foreign Amount"; Decimal)
//         {
//         }
//         field(49; "Posting Attempts"; Integer)
//         {
//         }
//         field(50; "Posting Description"; Text[50])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Transaction ID", "Transaction Type")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Service Name")
//         {
//         }
//         key(Key3; "Transaction Date")
//         {
//         }
//         key(Key4; "Transaction Time")
//         {
//         }
//         key(Key5; "Terminal ID")
//         {
//         }
//         key(Key6; Channel)
//         {
//         }
//         key(Key7; "Sacco Account")
//         {
//         }
//         key(Key8; "Member Account")
//         {
//         }
//         key(Key9; "Institution Code")
//         {
//         }
//         key(Key10; "Institution Name")
//         {
//         }
//         key(Key11; Commission)
//         {
//         }
//         key(Key12; "Commission Currency")
//         {
//         }
//         key(Key13; Activity)
//         {
//         }
//         key(Key14; Amount)
//         {
//         }
//         key(Key15; Posted)
//         {
//         }
//         key(Key16; "Date Posted")
//         {
//         }
//         key(Key17; "Time Posted")
//         {
//         }
//         key(Key18; "Posted By")
//         {
//         }
//         key(Key19; Reversed)
//         {
//         }
//         key(Key20; "Date Reversed")
//         {
//         }
//         key(Key21; "Time Reversed")
//         {
//         }
//         key(Key22; "Reversed By")
//         {
//         }
//         key(Key23; "Reversal ID")
//         {
//         }
//         key(Key24; "Transaction Name")
//         {
//         }
//         key(Key25; "Original Transaction ID")
//         {
//         }
//         key(Key26; "Amount Currency")
//         {
//         }
//         key(Key27; "ATM No.")
//         {
//         }
//         key(Key28; "Document No.")
//         {
//         }
//         key(Key29; "Channel Code")
//         {
//         }
//         key(Key30; "Terminal Code")
//         {
//         }
//         key(Key31; "Total Account Debit")
//         {
//         }
//         key(Key32; "Total Charges")
//         {
//         }
//         key(Key33; "Coop Fee")
//         {
//         }
//         key(Key34; "Sacco Fee")
//         {
//         }
//         key(Key35; "Sacco Excise Duty")
//         {
//         }
//         key(Key36; Skipped)
//         {
//         }
//         key(Key37; "Device Type")
//         {
//         }
//         key(Key38; Location)
//         {
//         }
//         key(Key39; "Posting Attempts")
//         {
//         }
//         key(Key40; "Posting Description")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

