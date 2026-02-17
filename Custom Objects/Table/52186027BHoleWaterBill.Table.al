// table 52186027 "B/Hole Water Bill"
// {
//     DrillDownPageID = "B/hole Water Bill List";
//     LookupPageID = "B/hole Water Bill List";

//     fields
//     {
//         field(1; "Property No."; Code[30])
//         {
//             TableRelation = "Property Details"."No.";

//             trigger OnValidate()
//             begin
//                 /*
//                 TESTFIELD("Billing date");
//                 PropDetails.RESET;
//                 PropDetails.SETRANGE(PropDetails."No.","Property No.");
//                 IF PropDetails.FIND('-') THEN BEGIN
//                 "L/R No.":=PropDetails."L.R. No.";
//                 PropDetails.CALCFIELDS(PropDetails."total Units[Occupied]");
//                 "Total No Of Units":=PropDetails."total Units[Occupied]";
                
//                 UnitsDetails.RESET;
//                 UnitsDetails.SETRANGE(UnitsDetails."Property No.","Property No.");
                
//                 UnitsDetails.SETFILTER(Blocked,'%1',FALSE);
//                 UnitsDetails.SETFILTER(Commenced,'%1',TRUE);
                
//                 IF UnitsDetails.FIND('-') THEN BEGIN
//                 //update meter details
//                 REPEAT
//                 UnitMReading.INIT;
//                 UnitMReading."Water Bill No":="No.";
//                 UnitMReading."Property No":=UnitsDetails."Property No.";
//                 UnitMReading."Property Name":=UnitsDetails."Property Name";
//                 UnitMReading."Floor Code":=UnitsDetails."Floor No.";
//                 UnitMReading."Unit Code":=UnitsDetails."Unit Code";
//                 UnitMReading."Meter No":=UnitsDetails."Meter No.";
//                 UnitMReading."Tenant No.":=UnitsDetails."Tenant No.";
//                 UnitMReading."Tenant Name":=UnitsDetails."Tenant Name";
//                 UnitMReading.Water:=Water;
//                 UnitMReading."Sewer charge":="Sewer charge";
//                 UnitMReading."Global Dimension 1 Code":=UnitsDetails."Global Dimension 1 Code";
//                 UnitMReading."Global Dimension 2 Code":=UnitsDetails."Global Dimension 2 Code";
//                 UnitMReading."Previous Reading":=UnitsDetails."Previous Reading";
//                 UnitMReading."Current Reading":=UnitsDetails."Current Reading";
//                 UnitMReading.Consumption:=0;
//                 UnitMReading."Total Water due":=0;
//                 UnitMReading."Total Sewer Due":=0;
//                 UnitMReading."Total Due":=0;
                
//                 UnitMReading.INSERT(TRUE);
//                 UnitMReading.MODIFY;
                
//                 UNTIL  UnitsDetails.NEXT=0;
//                 END
//                 END;
//                 */

//             end;
//         }
//         field(2; "Meter Category"; Option)
//         {
//             OptionCaption = ' ,Residential,Commercial';
//             OptionMembers = " ",Residential,Commercial;
//         }
//         field(3; "L/R No."; Code[80])
//         {
//         }
//         field(5; "Bill No."; Decimal)
//         {
//         }
//         field(6; "Property Sequence"; Decimal)
//         {
//         }
//         field(7; "Meter Reading Date"; Date)
//         {
//         }
//         field(8; "Bill Item"; Option)
//         {
//             OptionCaption = ' ,Water,Sewer';
//             OptionMembers = " ",Water,Sewer;
//         }
//         field(9; "Meter No."; Text[100])
//         {
//         }
//         field(13; "Charge[KES.]"; Decimal)
//         {
//         }
//         field(14; "Total Water due"; Decimal)
//         {
//         }
//         field(15; "Due Date"; Date)
//         {
//         }
//         field(16; "Billing date"; Date)
//         {
//         }
//         field(18; "Total Sewer Due"; Decimal)
//         {
//         }
//         field(19; "Total Due"; Decimal)
//         {
//         }
//         field(21; Water; Boolean)
//         {
//         }
//         field(22; "Sewer charge"; Boolean)
//         {
//         }
//         field(23; "Consumption[ComputingSewer]"; Decimal)
//         {
//         }
//         field(24; "Total No Of Units"; Integer)
//         {
//         }
//         field(25; "Units Total [Water]"; Decimal)
//         {
//             CalcFormula = Sum("B/Hole Units meter Ratings"."Total Water due" WHERE("Property No" = FIELD("Property No."),
//                                                                                     "Water Bill No" = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(26; "Units total [Sewer]"; Decimal)
//         {
//             CalcFormula = Sum("B/Hole Units meter Ratings"."Total Sewer Due" WHERE("Property No" = FIELD("Property No."),
//                                                                                     "Water Bill No" = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(27; "No."; Code[30])
//         {
//         }
//         field(28; "No. Series"; Code[20])
//         {
//         }
//         field(29; "billed tenants"; Boolean)
//         {
//         }
//         field(30; "Zone Code"; Code[20])
//         {
//             TableRelation = Zones.Code;

//             trigger OnValidate()
//             begin
//                 //clear entries
//                 UnitMReading.Reset;
//                 UnitMReading.SetRange(UnitMReading."Water Bill No", "No.");
//                 if UnitMReading.Find('-') then begin
//                     UnitMReading.DeleteAll;
//                 end;

//                 Zones.Reset;
//                 Zones.SetRange(Zones.Code, "Zone Code");
//                 if Zones.Find('-') then begin
//                     "Zone Description" := Zones."Zone Name";
//                 end;
//                 //clear entries before inerting new
//             end;
//         }
//         field(31; "Zone Description"; Text[100])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "No.")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         if "No." = '' then begin
//             GSetup.Get();
//             GSetup.TestField(GSetup."B/Hole W/B Nos.");
//             NoSeriesMgt.InitSeries(GSetup."B/Hole W/B Nos.", xRec."No. Series", Today, "No.", "No. Series");
//         end;
//     end;

//     var
//         PropDetails: Record "Property Details";
//         "Water Rating": Record "Water Billing rate";
//         Sewer: Record "Sewer Billing rate";
//         keepCount: Integer;
//         CurrAmount: Decimal;
//         keepCounts: Integer;
//         CurrAmountS: Decimal;
//         UnitsDetails: Record Lease;
//         UnitMReading: Record "B/Hole Units meter Ratings";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         NoSeriesMgt: Codeunit "No. Series";
//         GSetup: Record "General Setup";
//         Leaseline: Record "Lease Line";
//         CAreaCharge: Record "Common Area Charges";
//         Zones: Record Zones;
// }

