table 52185954 Jobs
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    JobSetup.Get;
                    NoSeriesMgt.TestManual(JobSetup."Job Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Search Description"; Code[250])
        {
            Caption = 'Search Description';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
                TestField("Approval Status", "Approval Status"::Open);
            end;
        }
        field(4; "Description 2"; Text[80])
        {
            Caption = 'Description 2';
        }
        field(5; "Bill-to Partner No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';

            trigger OnValidate()
            begin
                /*IF ("Bill-to Partner No." = '') OR ("Bill-to Partner No." <> xRec."Bill-to Partner No.") THEN
                  IF JobLedgEntryExist OR JobPlanningLineExist THEN
                    ERROR(Text000,FIELDCAPTION("Bill-to Partner No."),TABLECAPTION);
                //UpdateCust;
                */

            end;
        }
        field(12; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                //CheckDate;
            end;
        }
        field(14; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                if "Period of Performance" = "Period of Performance"::"Open Ended" then Error('You cannot insert and end date if status is open ended');
                //CheckDate;
            end;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Concept Formulation,Proposal,Contract,Project,Completed';
            OptionMembers = "Concept Formulation",Proposal,Contract,Project,Completed;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job-Planning Line";
            begin
                if xRec.Status <> Status then begin
                    if Status = Status::Project then
                        Validate(Complete, true);
                    if xRec.Status = xRec.Status::Project then begin
                        if DIALOG.Confirm(Text004) then
                            Validate(Complete, false)
                        else begin
                            Status := xRec.Status;
                        end;
                    end;
                    JobPlanningLine.SetCurrentKey("Grant No.");
                    JobPlanningLine.SetRange("Grant No.", "No.");
                    JobPlanningLine.ModifyAll(Status, Status);
                    Modify;
                end;
            end;
        }
        field(20; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

                Modify;
            end;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

                Modify;
            end;
        }
        field(23; "Job Posting Group"; Code[10])
        {
            Caption = 'Kind of Program';
        }
        field(24; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(32; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(49; "Scheduled Res. Qty."; Decimal)
        {
            CalcFormula = Sum("Job-Planning Line"."Quantity (Base)" WHERE("Grant No." = FIELD("No."),
                                                                           "Schedule Line" = CONST(true),
                                                                           Type = CONST(Resource),
                                                                           "No." = FIELD("Resource Filter"),
                                                                           "Planning Date" = FIELD("Planning Date Filter")));
            Caption = 'Scheduled Res. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(51; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(55; "Resource Gr. Filter"; Code[20])
        {
            Caption = 'Resource Gr. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(56; "Scheduled Res. Gr. Qty."; Decimal)
        {
            CalcFormula = Sum("Job-Planning Line"."Quantity (Base)" WHERE("Grant No." = FIELD("No."),
                                                                           "Schedule Line" = CONST(true),
                                                                           Type = CONST(Resource),
                                                                           "Resource Group No." = FIELD("Resource Gr. Filter"),
                                                                           "Planning Date" = FIELD("Planning Date Filter")));
            Caption = 'Scheduled Res. Gr. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(58; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';
        }
        field(59; "Bill-to Address"; Text[50])
        {
            Caption = ' Address';
        }
        field(60; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Email Address';
            ExtendedDatatype = EMail;
        }
        field(61; "Bill-to City"; Text[50])
        {
            Caption = 'Bill-to City';
        }
        field(63; County; Text[30])
        {
            CalcFormula = Lookup(Customer.County WHERE("No." = FIELD("Bill-to Partner No.")));
            Caption = 'County';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(66; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(67; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = true;
            TableRelation = "Country/Region";
        }
        field(68; "Bill-to Name 2"; Text[50])
        {
            CalcFormula = Lookup(Customer."Name 2" WHERE("No." = FIELD("Bill-to Partner No.")));
            Caption = 'Bill-to Name 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; Contractor; Option)
        {
            Caption = 'Contractor';
            OptionCaption = ' ,Prime Contractor,Sub Contractor';
            OptionMembers = " ","Prime Contractor","Sub Contractor";
        }
        field(1001; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                /*IF "Currency Code" <> xRec."Currency Code" THEN
                  IF NOT JobLedgEntryExist THEN
                    CurrencyUpdatePlanningLines
                  ELSE
                    ERROR(Text000,FIELDCAPTION("Currency Code"),TABLECAPTION);
                
                TESTFIELD("Approval Status","Approval Status"::Open);
                */

            end;
        }
        field(1002; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';

            trigger OnLookup()
            begin
                /*
                IF ("Bill-to Partner No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                  Cont.SETRANGE("Company No.",Cont."Company No.")
                ELSE
                  IF Cust.GET("Bill-to Partner No.") THEN BEGIN
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
                    ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
                    ContBusinessRelation.SETRANGE("No.","Bill-to Partner No.");
                    IF ContBusinessRelation.FIND('-') THEN
                      Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.");
                  END ELSE
                    Cont.SETFILTER("Company No.",'<>''''');
                
                IF "Bill-to Contact No." <> '' THEN
                  IF Cont.GET("Bill-to Contact No.") THEN ;
                */

            end;

            trigger OnValidate()
            begin
                /*IF Blocked >= Blocked::Posting THEN
                  ERROR(Text000,FIELDCAPTION("Bill-to Contact No."),TABLECAPTION);
                
                IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
                   (xRec."Bill-to Contact No." <> '')
                THEN BEGIN
                  IF ("Bill-to Contact No." = '') AND ("Bill-to Partner No." = '') THEN BEGIN
                    INIT;
                    "No. Series" := xRec."No. Series";
                    VALIDATE(Description,xRec.Description);
                  END;
                END;
                
                IF ("Bill-to Partner No." <> '') AND ("Bill-to Contact No." <> '') THEN BEGIN
                  Cont.GET("Bill-to Contact No.");
                  ContBusinessRelation.RESET;
                  ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
                  ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
                  ContBusinessRelation.SETRANGE("No.","Bill-to Partner No.");
                  IF ContBusinessRelation.FIND('-') THEN
                    IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                     ERROR(Text005,Cont."No.",Cont.Name,"Bill-to Partner No.");
                END;
                UpdateBillToCust("Bill-to Contact No.");
                */

            end;
        }
        field(1003; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(1004; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        // field(1005; "Total WIP Cost Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Total WIP Cost Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(1006; "Total WIP Cost G/L Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Total WIP Cost G/L Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(1007; "WIP Posted To G/L"; Boolean)
        {
            Caption = 'WIP Posted To G/L';
            Editable = false;
        }
        field(1008; "WIP Posting Date"; Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(1009; "WIP G/L Posting Date"; Date)
        {
            Caption = 'WIP G/L Posting Date';
            Editable = false;
            
        }
        field(1010; "Posted WIP Method Used"; Option)
        {
            Caption = 'Posted WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1011; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1012; "Exch. Calculation (Cost)"; Option)
        {
            Caption = 'Exch. Calculation (Cost)';
            OptionCaption = 'Fixed LCY,Fixed FCY';
            OptionMembers = "Fixed LCY","Fixed FCY";
        }
        field(1013; "Exch. Calculation (Price)"; Option)
        {
            Caption = 'Exch. Calculation (Price)';
            OptionCaption = 'Fixed FCY,Fixed LCY';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1014; "Allow Schedule/Contract Lines"; Boolean)
        {
            Caption = 'Allow Schedule/Contract Lines';
        }
        field(1015; Complete; Boolean)
        {
            Caption = 'Complete';

            trigger OnValidate()
            begin
                // if Complete <> xRec.Complete then
                //     ChangeJobCompletionStatus;
            end;
        }
        field(1016; "Calc. WIP Method Used"; Option)
        {
            Caption = 'Calc. WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1017; "Amount Awarded"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Awarded';
            Editable = true;
        }
        // field(1018; "Recog. Sales G/L Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Recog. Sales G/L Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(1019; "Recog. Costs Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Recog. Costs Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(1020; "Recog. Costs G/L Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Recog. Costs G/L Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(1021; "Total WIP Sales Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Total WIP Sales Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(1022; "Total WIP Sales G/L Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Total WIP Sales G/L Amount';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(1023; "Completion Calculated"; Boolean)
        // {
        //     Caption = 'Completion Calculated';
        //     FieldClass = FlowField;
        // }
        field(1024; "Next Invoice Date"; Date)
        {
            CalcFormula = Min("Job-Planning Line"."Planning Date" WHERE("Grant No." = FIELD("No."),
                                                                         "Contract Line" = FILTER(= true),
                                                                         Invoiced = FILTER(= false)));
            Caption = 'Next Invoice Date';
            FieldClass = FlowField;
        }
        field(50000; "Grant Phases"; Code[10])
        {
        }
        field(50001; "Approval Status"; Enum "Approval Status")
        {
            Editable = true;
            // OptionCaption = 'Open,Pending Approval,Approved';
            // OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50002; "Responsibility Center"; Code[10])
        {
        }
        field(50003; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Job-Planning Line"."Total Cost" WHERE("Grant No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Total Cost(LCY)"; Decimal)
        {
            CalcFormula = Sum("Job-Planning Line"."Total Cost (LCY)" WHERE("Grant No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Contract Description"; Text[150])
        {
        }
        field(50006; "Contract Type"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(50007; "Disbursed Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line".Amount WHERE("Shortcut Dimension 2 Code" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50008; "Allow OverExpenditure"; Boolean)
        {
        }
        // field(50009; "Accounted Amount"; Decimal)
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50010; "Received Amount"; Decimal)
        {
            CalcFormula = Sum("Receipt Line"."Total Amount" WHERE("Shortcut Dimension 2 Code" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50011; "Proposal No"; Code[20])
        {
            Editable = false;
            TableRelation = Jobs."No." WHERE("No." = FIELD("Proposal No"),
                                              Status = CONST(Proposal));
        }
        field(50012; "Converted To Proposal"; Boolean)
        {
            Editable = false;
        }
        field(50013; "Project No"; Code[20])
        {
            Editable = true;
            TableRelation = Jobs."No." WHERE("No." = FIELD("Project No"),
                                              Status = CONST(Contract));
        }
        field(50014; "Converted To Project"; Boolean)
        {
            Editable = true;
        }
        field(50015; "Concept Number"; Code[20])
        {
        }
        field(50016; Objective; Text[150])
        {
        }
        field(50017; "Contract No"; Code[20])
        {
        }
        // field(50018; "Reporting dates generated"; Boolean)
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50019; "Condition for budget realloca"; Code[10])
        {
        }
        field(50020; "Principal Investigator"; Text[100])
        {
            TableRelation = Resource;

            trigger OnValidate()
            begin
                objReso.Reset;
                objReso.SetRange(objReso."No.", "Principal Investigator");
                if objReso.Find('-') then begin
                    "Principal Investigator name" := objReso.Name;
                    "Bill-to Address" := objReso.Address;
                    //"Bill-to Address 2":=objReso.Email;
                    //Institution:=objReso.Institution;
                end;
            end;
        }
        field(50021; "Expected Receipt Amount"; Decimal)
        {
            CalcFormula = Sum("Project Donors"."Expected Donation" WHERE("Grant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50022; Partners; Boolean)
        {
            CalcFormula = Exist("Project Partners" WHERE("Grant No" = FIELD("No.")));
            Caption = 'Collaborative Grants';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Project Location"; Text[70])
        {
        }
        field(50024; "Income Account"; Code[10])
        {
        }
        field(50025; "Concept Approval Date"; DateTime)
        {
            Editable = false;
        }
        field(50026; "Project Filter"; Code[10])
        {
        }
        field(50027; Title; Text[30])
        {
        }
        field(50028; "Project Coordinator"; Text[100])
        {
            TableRelation = Resource;
        }
        field(50029; Task; Option)
        {
            OptionCaption = ' ,Research,Service';
            OptionMembers = " ",Research,Service;
        }
        field(50030; "Project Status"; Option)
        {
            OptionCaption = 'Setup,In Progress,Halted,Completed';
            OptionMembers = Setup,"In Progress",Halted,Completed;
        }
        field(50031; "Audit Indicator"; Boolean)
        {
        }
        field(50032; "Approved Funding Start Date"; Date)
        {
        }
        field(50033; "Approved Funding End Date"; Date)
        {
        }
        field(50034; "Justification Narration"; Text[200])
        {
            Description = 'Narrations defined esp. when modifying  the project/contract info';
        }
        // field(50035; "Amount Invoiced"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(50036; "Grant Level"; Option)
        {
            OptionCaption = 'Grant,Sub-Grant';
            OptionMembers = Grant,"Sub-Grant";
        }
        field(50037; "RSPO No."; Code[30])
        {
        }
        field(50038; "Alert sent"; Boolean)
        {
        }
        field(50039; "Proposal Application due Date"; Date)
        {
        }
        field(50040; Submission; Option)
        {
            OptionCaption = ' ,Paper Submission,Electronic Submission';
            OptionMembers = " ","Paper Submission","Electronic Submission";
        }
        field(50041; "PI Name"; Text[100])
        {
            Caption = 'PI At Collaborative Institution';

            trigger OnValidate()
            begin
                /*objPImaster.RESET;
                objPImaster.SETRANGE(objPImaster."PI Code","PI Name");
                IF objPImaster.FIND('-') THEN BEGIN
                 "PI Address":=objPImaster."PI Address";
                 "PI Telephone":=objPImaster."PI Telephone";
                 "PI EMail":=objPImaster."PI EMail";
                 MODIFY;
                END;
                */

            end;
        }
        field(50042; "PI Address"; Text[30])
        {
        }
        field(50043; "PI Telephone"; Text[30])
        {
        }
        field(50044; "PI EMail"; Text[30])
        {
            ExtendedDatatype = EMail;
        }
        field(50045; "Collaborative Grant"; Boolean)
        {
        }
        field(50046; "IREC Approval"; Option)
        {
            OptionCaption = 'Pending Approval,Approved,Exempt';
            OptionMembers = "Pending Approval",Approved,Exempt;
        }
        field(50047; "IREC Approval Date"; Date)
        {
        }
        field(50048; "Cost Share"; Boolean)
        {
        }
        field(50049; "Cost Share Details"; Text[100])
        {
        }
        field(50050; Matching; Boolean)
        {
        }
        field(50051; "Matching Details"; Text[150])
        {
        }
        field(50052; "Application disposition Status"; Option)
        {
            OptionCaption = ' ,Signed By Institutions Authorities,Returned to PI,Forwarded to funding Agency';
            OptionMembers = " ","Signed By Institutions Authorities","Returned to PI","Forwarded to funding Agency";
        }
        field(50053; "SubAward No."; Code[20])
        {
            Description = 'Project Sub award';
        }
        field(50054; "Payment Methods"; Code[20])
        {
            TableRelation = "Payment Method".Code;
        }
        field(50055; Schools; Code[10])
        {
            Caption = 'Kind of Program';
        }
        field(50056; "Application Due Date"; Date)
        {
        }
        field(50057; "Funding Request"; Boolean)
        {
        }
        field(50058; Budget; Boolean)
        {
        }
        field(50059; "Budget Justification"; Boolean)
        {
        }
        field(50060; "Project Summary Abstract"; Boolean)
        {
        }
        field(50061; "RSPO Completion List"; Boolean)
        {
        }
        field(50062; Donors; Boolean)
        {
            CalcFormula = Exist("Project Donors" WHERE("Grant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        // field(50063; Workplan; Boolean)
        // {
        //     FieldClass = FlowField;
        // }
        field(50064; "Period of Performance"; Option)
        {
            OptionMembers = "Multiple Years","One Year","Open Ended";

            trigger OnValidate()
            begin
                if "Period of Performance" = "Period of Performance"::"Open Ended" then "Ending Date" := 0D;
            end;
        }
        field(50065; "Principal Investigator name"; Text[100])
        {
        }
        field(50066; "Response To fund Opportunity"; Boolean)
        {
        }
        field(50067; "Main Donor"; Code[50])
        {
        }
        field(50068; "Main Sub"; Code[50])
        {
        }
        field(50069; "Special Contract Provision"; Text[250])
        {
        }
        field(50070; "Funding Agency No."; Code[20])
        {
        }
        field(50071; "Type Of Funding"; Option)
        {
            OptionCaption = ',Discretionary,Donations,Supplimental Funds,Others';
            OptionMembers = ,Discretionary,Donations,"Supplimental Funds",Others;
        }
        field(50072; "Responsible Officer"; Code[50])
        {
        }
        field(50073; "RFA/A Receipt Date"; Date)
        {
        }
        field(50074; "Project Team"; Code[20])
        {
            TableRelation = "Resource Group"."No.";
        }
        field(50075; Institution; Option)
        {
            OptionCaption = ' ,MTRH,MU,OTHERS';
            OptionMembers = " ",MTRH,MU,OTHERS;
        }
        field(50076; "Moi/MTRH Collaborator"; Boolean)
        {
            Caption = 'Do you have a previous Collaboration with Moi/MTRH ?';
        }
        field(50077; "AMPATH Affiliation Consortium"; Boolean)
        {
        }
        field(50078; "Previous MU Consortium School?"; Boolean)
        {
        }
        field(50079; "Which MU Consortium School"; Text[50])
        {
        }
        field(50080; "ASANTE Collaborator?"; Boolean)
        {
        }
        field(50081; "ASANTE Collaborator Details"; Text[50])
        {
        }
        field(50082; "Assist identifying Collabotor?"; Boolean)
        {
        }
        field(50083; "Study Type"; Option)
        {
            OptionCaption = ' ,Retrospective Cohort,Propective Cohort,Clinical trial,Others';
            OptionMembers = " ","Retrospective Cohort","Propective Cohort","Clinical trial",Others;
        }
        field(50084; "Study Type Details"; Text[50])
        {
        }
        field(50085; "Brief Description of Study"; Text[20])
        {
        }
        field(50086; "Study Funded"; Boolean)
        {
        }
        field(50087; "Funding Source/Funding Sought"; Text[50])
        {
        }
        field(50088; "Application Deadline"; Date)
        {
        }
        field(50089; "Lab Services"; Boolean)
        {

            trigger OnValidate()
            begin
                /*IF "Lab Services"=TRUE THEN BEGIN
                  IF CONFIRM('Are you sure you want to update the Lab Request')=TRUE THEN BEGIN
                    objLabRequest.RESET;
                    objLabRequest.SETRANGE(objLabRequest."Proposal No.","No.");
                    IF objLabRequest.FIND('-') THEN EXIT
                    ELSE BEGIN
                     objLabRequest.INIT;
                     objLabRequest."Proposal No.":="No.";
                     objLabRequest.INSERT;
                    END;
                  END;
                END;
                */

            end;
        }
        field(50090; "AMPATH Data Mgt Core Required"; Boolean)
        {
        }
        field(50091; "Contracted To"; Text[150])
        {
            Description = 'Added:'' for capturing details of subs in commas form  -came up during data import';
        }
        field(50092; "Biostats Core Required"; Boolean)
        {
        }
        field(50093; "Prime Institution"; Code[50])
        {
            Description = 'Added:'' for capturing details prime institution -came up during data import';
        }
        field(50094; "Workgroup Recomendation"; Option)
        {
            OptionCaption = ' ,Do not support further Development,Support further Development,Support Study and feel no further input is needed';
            OptionMembers = " ","Do not support further Development","Support further Development","Support Study and feel no further input is needed";
        }
        field(50095; "Recomendation Description"; Text[50])
        {
        }
        field(50096; "Approved Budget Start Date"; Date)
        {
        }
        field(50097; "Approved Budget End Date"; Date)
        {
        }
        field(50098; "Financial Reporting Due Date"; DateFormula)
        {
        }
        field(50099; "Technical  Reporting Due Date"; DateFormula)
        {
        }
        field(50100; "Obligated Amount"; Decimal)
        {
            CalcFormula = Sum(Committment.Amount WHERE("Shortcut Dimension 2 Code" = FIELD("No.")));
            Description = 'An alert to be provided when the grant expenditure is 95% of the project expenditure';
            FieldClass = FlowField;
        }
        field(50101; "Re:"; Text[100])
        {
        }
        field(50102; "System Contract No"; Code[20])
        {
        }
        field(50103; "Converted To Contract"; Boolean)
        {
        }
        field(50104; "Indirect Cost"; Boolean)
        {
        }
        field(50105; "Allowed Indirect Cost"; Decimal)
        {
        }
        field(50106; "Consistence with inst. Objs."; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        JobSetup: Record "Jobs-Setup";
        PostCode: Record "Post Code";
        Job: Record Jobs;
        Cust: Record Customer;
        Cont: Record Contracts;
        ContBusinessRelation: Record "Contact Business Relation";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        MoveEntries: Codeunit MoveEntries;
        JobPlanningLine: Record "Job-Planning Line";
        JobPlanningLines: Record "Job-Planning Line";
        ProjectPartners: Record "Project Partners";
        ProjectDonors: Record "Project Donors";
        ProjectPartner: Record "Project Partners";
        ProjectDonor: Record "Project Donors";
        LastEntryNo: Integer;
        JobEntryNo: Record "Job Entry No.";
        ApprovalEntries: Record "Approval Entry";
        ApprovalDate: DateTime;
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        ProjectCode: Code[10];
        objReso: Record Resource;
        Text000: Label 'You cannot change %1 because one or more entries are associated with this %2.';
        Text003: Label 'You must run the %1 and %2 functions to create and post the completion entries for this job.';
        Text004: Label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
        Text005: Label 'Contact %1 %2 is related to a different company than customer %3.';
        Text006: Label 'Contact %1 %2 is not related to customer %3.';
        Text007: Label 'Contact %1 %2 is not related to a customer.';
        Text008: Label '%1 %2 must not be blocked with type %3.';
        Text009: Label 'You must run the %1 function to reverse the completion entries that have already been posted for this job.';
        Text010: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text011: Label '%1 must be equal to or earlier than %2.';

    [Scope('OnPrem')]
    procedure AssistEdit(OldJob: Record Jobs): Boolean
    begin
        with Job do begin
            Job := Rec;
            JobSetup.Get;
            JobSetup.TestField("Job Nos.");
            if NoSeriesMgt.SelectSeries(JobSetup."Job Nos.", OldJob."No. Series", "No. Series") then begin
                JobSetup.Get;
                JobSetup.TestField("Job Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Job;
                exit(true);
            end;
        end;
    end;

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Jobs, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    [Scope('OnPrem')]
    procedure UpdateBillToCont(CustomerNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
    begin
        if Cust.Get(CustomerNo) then begin
            if Cust."Primary Contact No." <> '' then
                "Bill-to Contact No." := Cust."Primary Contact No."
            else begin
                ContBusRel.Reset;
                ContBusRel.SetCurrentKey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SetRange("No.", "Bill-to Partner No.");
                if ContBusRel.Find('-') then
                    "Bill-to Contact No." := ContBusRel."Contact No.";
            end;
            "Bill-to Contact" := Cust.Contact;
        end;
    end;

    local procedure JobPlanningLineExist(): Boolean
    var
        JobPlanningLine: Record "Job-Planning Line";
    begin
        JobPlanningLine.Init;
        JobPlanningLine.SetRange("Grant No.", "No.");
        exit(JobPlanningLine.Find('-'));
    end;

    [Scope('OnPrem')]
    procedure UpdateBillToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record Customer;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo) then begin
            "Bill-to Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then
                "Bill-to Contact" := Cont.Name
            else
                if Cust.Get("Bill-to Partner No.") then
                    "Bill-to Contact" := Cust.Contact
                else
                    "Bill-to Contact" := '';
        end else begin
            "Bill-to Contact" := '';
            exit;
        end;

        ContBusinessRelation.Reset;
        ContBusinessRelation.SetCurrentKey("Link to Table", "Contact No.");
        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
        if ContBusinessRelation.Find('-') then begin
            if "Bill-to Partner No." = '' then
                Validate("Bill-to Partner No.", ContBusinessRelation."No.")
            else
                if "Bill-to Partner No." <> ContBusinessRelation."No." then
                    Error(Text006, Cont."No.", Cont.Name, "Bill-to Partner No.");
        end else
            Error(Text007, Cont."No.", Cont.Name);
    end;

    [Scope('OnPrem')]
    procedure UpdateCust()
    begin
        if "Bill-to Partner No." <> '' then begin
            Cust.Get("Bill-to Partner No.");
            Cust.TestField("Customer Posting Group");
            Cust.TestField("Bill-to Customer No.", '');
            "Bill-to Name" := Cust.Name;
            "Bill-to Name 2" := Cust."Name 2";
            "Bill-to Address" := Cust.Address;
            "Bill-to Address 2" := Cust."Address 2";
            "Bill-to City" := Cust.City;
            "Bill-to Post Code" := Cust."Post Code";
            "Bill-to Country/Region Code" := Cust."Country/Region Code";
            "Currency Code" := Cust."Currency Code";
            "Customer Disc. Group" := Cust."Customer Disc. Group";
            "Customer Price Group" := Cust."Customer Price Group";
            "Language Code" := Cust."Language Code";
            County := Cust.County;
            // UpdateBillToCont("Bill-to Partner No.");
        end else begin
            "Bill-to Name" := '';
            "Bill-to Name 2" := '';
            "Bill-to Address" := '';
            "Bill-to Address 2" := '';
            "Bill-to City" := '';
            "Bill-to Post Code" := '';
            "Bill-to Country/Region Code" := '';
            "Currency Code" := '';
            "Customer Disc. Group" := '';
            "Customer Price Group" := '';
            "Language Code" := '';
            County := '';
            Validate("Bill-to Contact No.", '');
        end;
    end;

    [Scope('OnPrem')]
    procedure InitWIPFields()
    begin
        "WIP Posted To G/L" := false;
        "WIP Posting Date" := 0D;
        "WIP G/L Posting Date" := 0D;
        "Posted WIP Method Used" := 0;
    end;

    [Scope('OnPrem')]
    procedure TestBlocked()
    begin
        if Blocked = Blocked::" " then
            exit;
        Error(Text008, TableCaption, "No.", Blocked);
    end;

    [Scope('OnPrem')]
    procedure CurrencyUpdatePlanningLines()
    var
        PlaningLine: Record "Job-Planning Line";
    begin
        PlaningLine.SetRange("Grant No.", "No.");
        if PlaningLine.Find('-') then
            repeat
                if PlaningLine.Transferred then
                    Error(Text000, FieldCaption("Currency Code"), TableCaption);
                PlaningLine.Validate("Currency Code", "Currency Code");
                PlaningLine.Validate("Currency Date");
                PlaningLine.Modify;
            until PlaningLine.Next = 0;
    end;

    [Scope('OnPrem')]
    procedure ChangeJobCompletionStatus()
    var
        AllObjwithCaption: Record AllObjWithCaption;
        JobCalcWIP: Codeunit "Job Calculate WIP";
        ReportCaption1: Text[250];
        ReportCaption2: Text[250];
    begin
        //AllObjwithCaption.GET(AllObjwithCaption."Object Type"::Report,REPORT::"Job Calculate WIP");
        //ReportCaption1 := AllObjwithCaption."Object Caption";
        //AllObjwithCaption.GET(AllObjwithCaption."Object Type"::Report,REPORT::"Job Post WIP to G/L");
        //ReportCaption2 := AllObjwithCaption."Object Caption";

        /*IF Complete = TRUE THEN
          MESSAGE(Text003,ReportCaption1,ReportCaption2)
        ELSE BEGIN
          JobCalcWIP.ReOpenJob("No.");
          "WIP Posting Date" := 0D;
          "Calc. WIP Method Used" := 0;
          MESSAGE(Text009,ReportCaption2);
        END;
        */

    end;

    [Scope('OnPrem')]
    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.Find('-') then
            MapMgt.MakeSelection(DATABASE::Jobs, GetPosition)
        else
            Message(Text010);
    end;

    [Scope('OnPrem')]
    procedure GetQuantityAvailable(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]; InEntryType: Option Usage,Sale,Both; Direction: Option Possitive,Negative,Both) QtyBase: Decimal
    begin
        /*CLEAR(JobLedgEntry);
        WITH JobLedgEntry DO BEGIN
          SETCURRENTKEY("Job No.","Entry Type",Type,"No.");
          SETRANGE("Job No.",Rec."No.");
          IF NOT (InEntryType = InEntryType::Both) THEN
            SETRANGE("Entry Type",InEntryType);
          SETRANGE(Type,Type::Item);
          SETRANGE("No.",ItemNo);
          IF FINDSET THEN
            REPEAT
              IF ("Location Code" = LocationCode) AND
                 ("Variant Code" = VariantCode) AND
                 ((Direction = Direction::Both) OR
                  ((Direction = Direction::Possitive) AND ("Quantity (Base)" > 0)) OR
                  ((Direction = Direction::Negative) AND ("Quantity (Base)" < 0)))
              THEN
                QtyBase := QtyBase + "Quantity (Base)";
            UNTIL NEXT = 0;
        END;
        */

    end;

    local procedure CheckDate()
    begin
        if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
            Error(Text011, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
    end;

    [Scope('OnPrem')]
    procedure AddtoDimensionValues(ProjectCode: Code[10])
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        //Job.RESET;
        //Job.SETRANGE(Job."No.",ProjectCode);
        if Job.Get(ProjectCode) then begin
            with DimVal do begin
                Init;
                DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                DimVal.Code := ProjectCode;
                DimVal.Name := Job.Description;
                DimVal."Global Dimension No." := 2;
                Insert
            end;
            Message('Project ID' + ' ' + ProjectCode + ' ' + 'successfully added to dimension values for global dimension'
            + ' ' + GLSetup."Global Dimension 2 Code");
        end;
    end;
}

