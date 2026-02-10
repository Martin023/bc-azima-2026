#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186417 tableextension52186417 extends Job
{
    fields
    {
        field(39004240; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,WIP';
            OptionMembers = " ",WIP;
        }
        field(39004241; "WIP Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(39004242; "FA Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            DataClassification = ToBeClassified;
            TableRelation = "FA Class";
        }
        field(39004243; "FA Subclass Code"; Code[10])
        {
            Caption = 'FA Subclass Code';
            DataClassification = ToBeClassified;
            TableRelation = "FA Subclass";

            trigger OnValidate()
            var
                FaSubClass: Record "FA Subclass";
            begin
            end;
        }
        field(39004244; "Expected FA Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 1;
            MinValue = 1;

            trigger OnValidate()
            begin
                Rec.TestField(Rec."No. of FA Created", 0);
                Rec."FA Quantity to Register" := 0;
            end;
        }
        field(39004245; "FA No."; Code[20])
        {
            CalcFormula = lookup("Fixed Asset"."No." where("WIP No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004246; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Depreciation Book";
        }
        field(39004247; "Depreciation Method"; Option)
        {
            Caption = 'Depreciation Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(39004248; "Straight-Line %"; Decimal)
        {
            Caption = 'Straight-Line %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 8;
            MinValue = 0;
        }
        field(39004249; "FA Posting Group"; Code[10])
        {
            Caption = 'FA Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "FA Posting Group";
        }
        field(39004250; "No. of FA Created"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39004251; "FA Quantity to Register"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if Rec."FA Quantity to Register" = 0 then
                    exit;

                if (Rec."No. of FA Created" + Rec."FA Quantity to Register") > Rec."Expected FA Quantity" then
                    Error(Text103, Rec."Expected FA Quantity" - Rec."No. of FA Created", FA.TableCaption);
            end;
        }
        field(39004252; "FA Location Code"; Code[10])
        {
            Caption = 'FA Location Code';
            DataClassification = ToBeClassified;
            TableRelation = "FA Location";
        }
        // field(39004253;"Amount Posted to FA";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = sum("FA Ledger Entry".Amount where (Field50001=field("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(39004254; "WIP Re-Opened By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39004255; "WIP Re-Opened Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39004256; "Last Cost Transferred"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39004257; "Invoice Posting Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Created,Posted';
            OptionMembers = " ",Created,Posted;
        }
        field(39004258; "WIP Cost Transferred"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39004259; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(39004260; "Resource Cost"; Decimal)
        {
            CalcFormula = sum("Job Planning Line"."Total Price" where("Job No." = field("No."),
                                                                       "Line Type" = filter("Both Budget and Billable" | Billable),
                                                                       Type = const(Resource)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004261; "Usage Cost Invoice"; Decimal)
        {
            CalcFormula = sum("Job Planning Line"."Total Price" where("Job No." = field("No."),
                                                                       "Line Type" = filter("Both Budget and Billable" | Billable),
                                                                       Type = filter(<> Resource)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004262; "WIP GL Balance (LCY)"; Decimal)
        {
            CalcFormula = sum("Job WIP G/L Entry"."WIP Entry Amount" where("Job No." = field("No."),
                                                                            "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004263; "Actual Completion Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(39004264; "Planned Starting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.CheckDateConsistency;
            end;
        }
        field(39004265; "Planned Ending Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.CheckDateConsistency;
            end;
        }
        field(39004266; "Last Modified By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User;
        }
        field(39004267; "FA Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39004268; "FA Description 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39004269; "Usage (Cost)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("Entry Type" = const(Usage),
                                                                           "Job No." = field("No."),
                                                                           "Posting Date" = field("Date Filter")));
            Caption = 'Usage (Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    procedure CheckDateConsistency()
    begin
        case CurrFieldNo of
            Rec.FieldNo(Rec."Planned Starting Date"):
                begin
                    if (Rec."Planned Starting Date" > Rec."Planned Ending Date") and (Rec."Planned Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Planned Starting Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                    if (Rec."Planned Starting Date" < Rec."Starting Date") and (Rec."Starting Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Planned Starting Date"));
                    if (Rec."Planned Starting Date" > Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Planned Starting Date"), Rec.FieldCaption(Rec."Ending Date"));
                end;
            Rec.FieldNo(Rec."Starting Date"):
                begin
                    if (Rec."Starting Date" > Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Ending Date"));
                    if (Rec."Starting Date" < Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Ending Date"), Rec.FieldCaption(Rec."Starting Date"));
                    if (Rec."Starting Date" < Rec."Planned Starting Date") and (Rec."Planned Starting Date" <> 0D) and (Rec."Starting Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Planned Starting Date"));
                end;
            Rec.FieldNo(Rec."Ending Date"):
                begin
                    Rec.TestField(Rec."Starting Date");
                    if (Rec."Ending Date" < Rec."Starting Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Ending Date"));
                    if (Rec."Ending Date" < Rec."Planned Starting Date") and (Rec."Planned Starting Date" <> 0D) and (Rec."Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Ending Date"), Rec.FieldCaption(Rec."Planned Starting Date"));
                end;
            Rec.FieldNo(Rec."Planned Ending Date"):
                begin
                    Rec.TestField(Rec."Planned Starting Date");
                    if (Rec."Planned Ending Date" < Rec."Planned Starting Date") and (Rec."Planned Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Planned Starting Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                    if (Rec."Planned Ending Date" > Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Ending Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                    if (Rec."Planned Ending Date" < Rec."Starting Date") and (Rec."Starting Date" <> 0D) then
                        Error(Text115, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                end;
        end;
    end;

    procedure InitTaskLine()
    var
        Maintenance: Record Maintenance;
        JTIndent: Codeunit "Job Task-Indent";
        JT: Record "Job Task";
        JT1: Record "Job Task";
        Text102: label 'TOTAL';
        LineNo: Integer;
    begin
        if (Rec."Bill-to Customer No." = '') or (Rec.Description = '') then
            exit;

        JT.Init;
        JT."Job No." := Rec."No.";
        JT."Job Task No." := '1000';
        JT."Job Task Type" := JT."job task type"::"Begin-Total";
        JT.Description := Rec.Description;
        if not JT.Insert then
            JT.Modify;


        JT.Init;
        JT."Job No." := Rec."No.";
        JT."Job Task No." := '99999';
        JT."Job Task Type" := JT."job task type"::"End-Total";
        JT.Description := CopyStr(Text102 + ' ' + Rec.Description, 1, MaxStrLen(JT.Description));
        if not JT.Insert then
            JT.Modify;


        //Insert the task lines
        // Clear(SuggestLines);
        // if not SuggestLines.FindFirst then
        //   exit;
        // LineNo:=1;
        // repeat
        //   JT.Init;
        //   JT."Job Task No.":=Format(1000+LineNo);
        //   JT.Description:=SuggestLines.Description;
        //   if not JT.Insert then
        //   JT.Modify;

        //   LineNo+=1;
        // until SuggestLines.Next(1) = 0;

        JTIndent.Indent(Rec."No.");
    end;

    var
        Text000: label 'You cannot change %1 because one or more entries are associated with this %2.';
        Text003: label 'You must run the %1 and %2 functions to create and post the completion entries for this job.';
        Text004: label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
        Text005: label 'Contact %1 %2 is related to a different company than customer %3.';
        Text006: label 'Contact %1 %2 is not related to customer %3.';
        Text007: label 'Contact %1 %2 is not related to a customer.';
        Text008: label '%1 %2 must not be blocked with type %3.';
        Text009: label 'You must run the %1 function to reverse the completion entries that have already been posted for this job.';
        Text010: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text011: label '%1 must be equal to or earlier than %2.';
        Text012: label 'You cannot set %1 to %2, as this %3 has set %4 to %5.';
        Text013: label 'A usage link cannot be enabled for the entire %1 because usage without the usage link already has been posted.';
        Text014: label 'Do you want to set the %1 on every %2 of type %3?';
        Text015: label '%1 must be %2 because job WIP general ledger entries already were posted with this setting.';
        Text016: label '%1 cannot be modified because the job has associated job WIP entries.';
        Text017: label 'The selected %1 requires the %2 to have %3 enabled.';
        Text018: label '%1 is set to %2.';
        Text103: label 'You cannot create more than %1 %2 on this account.';
        Text115: label '%1 cannot be after %2';
        FA: Record "Fixed Asset";
}
