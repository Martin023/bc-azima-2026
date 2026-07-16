table 52185650 "HR Employees"
{

    DrillDownPageId = "HR Employee List - Active";
    LookupPageId = "HR Employee List - Active";

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            var
                HREmpCheck: Record "HR Employees";
            begin

                if "No." <> xRec."No." then begin
                    HrSetup.Get;
                    NoSeriesMgt.TestManual(HrSetup."Employee Nos.");
                    "No. Series" := '';

                    //CHECK FOR DUPLICATE EMPLOYEE NUMBER
                    if "No." <> '' then begin
                        HREmpCheck.Reset();
                        HREmpCheck.SetRange("No.", "No.");
                        if HREmpCheck.FindFirst() then
                            Error('EMPLOYEE NUMBER [%1] ALREADY EXISTS. DUPLICATE EMPLOYEE NUMBERS ARE NOT ALLOWED. PLEASE USE A DIFFERENT EMPLOYEE NUMBER.', "No.");
                    end;
                end;
            end;
        }
        field(2; "First Name"; Text[80])
        {

            trigger OnValidate()
            begin

                fn_FullName;
            end;
        }
        field(3; "Middle Name"; Text[50])
        {

            trigger OnValidate()
            begin
                fn_FullName;
            end;
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
                fn_FullName;
            end;
        }
        field(5; Initials; Text[15])
        {
        }
        field(7; "Full Name"; Text[100])
        {
        }
        field(8; "Postal Address"; Text[100])
        {
        }
        field(9; "Residential Address"; Text[40])
        {
        }
        field(10; City; Text[30])
        {
            Editable = false;
        }
        field(11; "Post Code"; Code[10])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                City := PostCode.City;
                County := '';
                "Postal Address" := '';
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Post Code");
                if PostCode.Find('-') then begin
                    City := PostCode.City;
                    County := PostCode.County;
                end;
            end;
        }
        field(12; County; Text[30])
        {
            Editable = false;
            //TableRelation = "Post Code".County;
            TableRelation = "Segment/County/Dividend/Signat".Code where(Type = const(County));
        }
        field(13; "Home Phone Number"; Code[20])
        {
        }
        field(14; "Cellular Phone Number"; Code[20])
        {
        }
        field(15; "Work Phone Number"; Code[20])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
                GlobalFunctions: Codeunit "Global Functions";
            begin
                if "E-Mail" <> '' then begin
                    MailManagement.CheckValidEmailAddresses("E-Mail");
                    // GlobalFunctions.ValidateEmailAddress("E-Mail");
                    GlobalFunctions.CheckEmailHasADot("E-Mail");
                    // Smtp.CheckValidEmailAddresses("E-Mail");
                end;
            end;
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(21; "ID Number"; code[20])
        {
        }

        field(22; "Union Code"; Code[10])
        {
            TableRelation = Union;
        }

        field(24; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(25; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }

        field(31; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Active,InActive,Suspended,Probation,interdicted,Rejected;
            Editable = false;
            trigger OnValidate()
            var
                PRPeriodTrans: Record "PR Period Transactions";
                PRPayrollPeriod: Record "PR Payroll Periods";
                PREmployerDeduc: Record "prEmployer Deductions";
            begin
                TestField("Date Of Birth");
                TestField("First Name");
                TestField("Last Name");
                //Testfield("Employee Group");
                if (Rec.Status = Status::InActive) then
                    GlobalFunctions.CommentsManagement(Rec."No.");
                //Clear entries for payroll period in PR Period Trans and PR Employer Deductions
                //Get open payroll period
                if Status = Status::InActive then begin
                    //"User ID":='';

                    PRPayrollPeriod.Reset;
                    PRPayrollPeriod.SetRange(PRPayrollPeriod.Closed, false);
                    if PRPayrollPeriod.Find('-') then begin
                        //Clear employer contributinos
                        PREmployerDeduc.Reset;
                        PREmployerDeduc.SetRange(PREmployerDeduc."Payroll Period", PRPayrollPeriod."Date Opened"); //Open Period
                        PREmployerDeduc.SetRange(PREmployerDeduc."Employee Code", "No.");
                        if PREmployerDeduc.Find('-') then begin
                            PREmployerDeduc.DeleteAll;
                        end;

                        //Clear period trans
                        PRPeriodTrans.Reset;
                        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PRPayrollPeriod."Date Opened");
                        PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "No.");
                        if PRPeriodTrans.Find('-') then begin
                            PRPeriodTrans.DeleteAll;
                        end;
                    end;
                end;
                //Clear user id
            end;
        }
        field(35; "Location/Division Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(36; "Department Code"; Code[20])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(37; Office; Code[20])
        {
            Description = 'Dimension 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }


        field(40; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(42; "Department Filter 1"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }


        field(49; "Fax Number"; Text[30])
        {
        }
        field(50; "Company E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                // Smtp.CheckValidEmailAddresses("Company E-Mail");
            end;
        }
        field(51; Title; Option)
        {
            OptionMembers = " ",Mr,Mrs,Miss,Ms,"Dr."," Eng. ",Prof;
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
        }
        field(53; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Known As"; Text[30])
        {
        }
        field(55; Position; Text[30])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(57; "Full / Part Time"; Option)
        {
            OptionMembers = " ","Full Time"," Part Time",Contract;
        }
        field(58; "Contract Type"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Contract Type"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (rec."Contract Type" <> 'CONTRACT') and (rec.age >= 60) and (rec.Disabled = rec.Disabled::No) then begin
                    error('This Employee is over employment age and cannot be on p$p');
                end else if (rec."Contract Type" = 'CONTRACT') and (rec.age >= 60) and (rec.Disabled = rec.Disabled::No) then begin
                    if not Confirm('Are you sure you want to add this employee on contract', true) then exit;
                end;
            end;
        }
        field(59; "Contract End Date"; Date)
        {
            trigger onvalidate()

            begin

            end;
        }
        field(60; "Notice Period"; DateFormula)
        {
        }
        field(61; "Union Member?"; Boolean)
        {
        }
        field(62; "Shift Worker?"; Boolean)
        {
        }

        field(64; "Pay Period"; Option)
        {
            OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
        }
        field(65; "Pay Per Period"; Decimal)
        {
        }
        field(66; "Cost Code"; Code[20])
        {
        }
        field(68; "Secondment Institution"; Text[30])
        {
        }
        field(69; "UIF Contributor?"; Boolean)
        {
        }
        field(73; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(74; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(75; "First Language (R/W/S)"; Code[10])
        {
            //NEW FIELD - ADDED TABLERELATION TO HR LOOKUP VALUES
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Language));
        }
        field(76; "Driving Licence"; Code[10])
        {
        }
        field(77; "Vehicle Registration Number"; Code[10])
        {
        }
        field(78; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
            InitValue = No;
            trigger OnValidate()
            var

            begin
                //VALIDATE DISABILITY CERTIFICATE IS PROVIDED FOR DISABLED EMPLOYEES
                if rec.Disabled = rec.Disabled::yes then begin
                    rec.testfield("Certificate No.");
                end;
                if HrSetup.get then begin
                    HrSetup.testfield("Retirement Age");
                    HrSetup.testfield("Disabled Retirement Age");
                    IF (rec.Disabled = rec.Disabled::No) or (rec.Disabled = rec.Disabled::" ") THEN BEGIN
                        "Retirement date" := CalcDate(Hrsetup."Retirement Age", "Date Of Birth");
                    end else if rec.Disabled = rec.Disabled::Yes then begin
                        "Retirement date" := CalcDate(Hrsetup."Disabled Retirement Age", "Date Of Birth");
                    end;
                END;

            end;
        }
        field(79; "Health Assesment?"; Boolean)
        {
        }
        field(80; "Health Assesment Date"; Date)
        {
        }
        field(81; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin
                "Retirement date" := 0D;

                IF (DATE2DMY(TODAY, 3) - DATE2DMY("Date Of Birth", 3)) < 18 THEN
                    ERROR('Staff is below allowed employable Limit');


                //ag := Round(((Today - "Date of Birth") / 365), 1, '=');
                ag := DATE2DMY(TODAY, 3) - DATE2DMY("Date Of Birth", 3);

                IF "Date Of Birth" >= TODAY THEN BEGIN
                    ERROR('Date of Birth cannot be after %1', TODAY);
                END;

                Age := ag;
                // HRCodeunit.DetermineAge("Date Of Birth", TODAY);
                //IF ag>20075 THEN ERROR('Your Age is above 55 years');





                //calculate age 02-05-1988
                yTODAY := DATE2DMY(TODAY, 3); //2014

                yDOB := DATE2DMY("Date Of Birth", 3);
                dDOB := DATE2DMY("Date Of Birth", 1);
                mDOB := DATE2DMY("Date Of Birth", 2);

                AppAge := yTODAY - yDOB;
                HREmp.FIND('-');

                if HrSetup.get then begin
                    HrSetup.testfield("Retirement Age");
                    HrSetup.testfield("Disabled Retirement Age");
                    IF (rec.Disabled = rec.Disabled::No) or (rec.Disabled = rec.Disabled::" ") THEN BEGIN
                        "Retirement date" := CalcDate(Hrsetup."Retirement Age", "Date Of Birth");
                    end else if rec.Disabled = rec.Disabled::Yes then begin
                        "Retirement date" := CalcDate(Hrsetup."Disabled Retirement Age", "Date Of Birth");
                    end;
                END;



            end;
        }
        field(82; Age; integer)
        {
        }
        field(84; "Length Of Service"; Text[80])
        {
        }
        field(85; "End Of Probation Date"; Date)
        {


        }
        field(86; "Pension Scheme Join"; Date)
        {
        }
        field(87; "Time Pension Scheme"; Text[80])
        {
        }
        field(88; "Medical Scheme Join"; Date)
        {
        }
        field(89; "Time Medical Scheme"; Text[80])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(90; "Date Of Leaving"; Date)
        {
        }
        field(91; Paterson; Code[10])
        {
        }
        field(92; Peromnes; Code[10])
        {
        }
        field(93; "Professional Body"; Code[20])
        {
            TableRelation = "HR Professional body Header";
            trigger OnValidate()
            var
                ProffesionalBodies: record "HR Professional body Header";
            begin
                ProffesionalBodies.reset();
                ProffesionalBodies.setrange("No.", rec."Professional Body");
                if ProffesionalBodies.findfirst() then
                    "cpd points" := ProffesionalBodies."CPD Points";

            end;
        }
        field(94; Castellion; Code[10])
        {
        }
        field(95; "Per Annum"; Decimal)
        {
        }
        field(96; "Allow Overtime"; Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(97; "Medical Scheme No."; Text[30])
        {

            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
            end;
        }
        field(98; "Medical Scheme Head Member"; Text[60])
        {

            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //   OK := MedicalAidBenefit.FIND('+');
                //  IF OK THEN BEGIN
                //  REPEAT
                //   MedicalAidBenefit."Medical Aid Head Member":= "Medical Aid Head Member";
                //    MedicalAidBenefit.MODIFY;
                //  UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(99; "Number Of Dependants"; Integer)
        {

            trigger OnValidate()
            begin
                // MedicalAidBenefit.SETRANGE("Employee No.","No.");
                // OK := MedicalAidBenefit.FIND('+');
                // IF OK THEN BEGIN
                //REPEAT
                //  MedicalAidBenefit."Number Of Dependants":= "Number Of Dependants";
                //  MedicalAidBenefit.MODIFY;
                //UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(100; "Medical Scheme Name"; Text[150])
        {

            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //OK := MedicalAidBenefit.FIND('+');
                //IF OK THEN BEGIN
                // REPEAT
                // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                //  MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(101; "Amount Paid By Employee"; Decimal)
        {

            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //  OK := MedicalAidBenefit.FIND('+');
                //   IF OK THEN BEGIN
                //     REPEAT
                //      MedicalAidBenefit."Amount Paid By Employee":= "Amount Paid By Employee";
                //       MedicalAidBenefit.MODIFY;
                //     UNTIL MedicalAidBenefit.NEXT = 0;
                //    END;
            end;
        }
        field(102; "Amount Paid By Company"; Decimal)
        {

            trigger OnValidate()
            begin
                //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //   OK := MedicalAidBenefit.FIND('+');
                //  IF OK THEN BEGIN
                // REPEAT
                //      MedicalAidBenefit."Amount Paid By Company":= "Amount Paid By Company";
                //      MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                //   END;
            end;
        }
        field(103; "Receiving Car Allowance ?"; Boolean)
        {
        }
        field(104; "Second Language (R/W/S)"; Code[10])
        {
            //NEW FIELD - ADDED TABLERELATION TO HR LOOKUP VALUES
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Language));
        }
        field(105; "Additional Language"; Code[10])
        {
            //NEW FIELD - ADDED TABLERELATION TO HR LOOKUP VALUES
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Language));
        }
        field(106; "Cell Phone Reimbursement?"; Boolean)
        {
        }
        field(107; "Amount Reimbursed"; Decimal)
        {
        }
        field(108; "UIF Country"; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(109; "Direct/Indirect"; Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(110; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(111; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(112; "Termination Category"; code[50])
        {


            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(113; "Job ID"; Code[30])
        {
            Description = 'To put description on Job title field';
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            var

            begin
                objJobs.Reset;
                objJobs.SetRange(objJobs."Job ID", "Job ID");
                if objJobs.Find('-') then begin
                    "Job Title" := objJobs."Job Description";
                    "Salary Grade" := objJobs.grade;
                    "Position Reporting To" := objJobs."Position Reporting Name";



                end;
            end;
        }
        field(114; DateOfBirth; Date)
        {

            trigger OnValidate()
            begin
                //calculate age 02-05-1988
                yTODAY := Date2DMY(Today, 3); //2014

                yDOB := Date2DMY("Date Of Birth", 3);
                dDOB := Date2DMY("Date Of Birth", 1);
                mDOB := Date2DMY("Date Of Birth", 2);

                AppAge := yTODAY - yDOB;
                HREmp.Find('-');

                if HREmp.Disabled = HREmp.Disabled::No then begin

                    //calculate how many years remaining for this employee to retire : ret yr is 65
                    noYrsToRetirement := 60 - AppAge;

                    //add noYrsToRetirement to current year to get retirement year da
                    RetirementYear := yTODAY + noYrsToRetirement;
                    //ERROR(FORMAT(RetirementYear));
                    RetirementDate := DMY2Date(dDOB, mDOB, RetirementYear);
                    "Retirement date" := RetirementDate;
                end else
                    //IF HREmp.Disabled= HREmp.Disabled::Yes THEN
                    //calculate how many years remaining for this employee to retire : ret yr is 60
                    noYrsToRetirement := 70 - AppAge;

                //add noYrsToRetirement to current year to get retirement year da
                RetirementYear := yTODAY + noYrsToRetirement;
                //ERROR(FORMAT(RetirementYear));
                RetirementDate := DMY2Date(dDOB, mDOB, RetirementYear);
                "Retirement date" := RetirementDate;
                //END;
                //END;
            end;
        }
        field(115; DateEngaged; Text[8])
        {
        }
        field(116; "Postal Address2"; Text[30])
        {
        }
        field(117; "Postal Address3"; Text[20])
        {
        }
        field(118; "Residential Address2"; Text[30])
        {
        }
        field(119; "Residential Address3"; Text[20])
        {
        }
        field(120; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(121; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(122; "Name Of Manager"; Text[45])
        {
        }
        field(123; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = true;

            // trigger OnLookup()
            // begin
            //     // UserMgt.LookupUserID("User ID");
            // end;

            trigger OnValidate()
            begin
                // UserMgt.ValidateUserID("User ID");

                if "User ID" = '' then exit;

                HREmp.RESET;
                HREmp.Setrange("User ID", rec."User ID");
                If HREmp.FindFirst() THEN
                    ERROR('UserID [%1] has already been assigned to another Employee [%2],[%3]', "User ID", HREmp."First Name", HREmp."Last Name");
            END;



        }
        field(124; "Disabling Details"; Text[20])
        {
        }
        field(125; "Disability Grade"; Text[20])
        {
        }
        field(126; "Passport Number"; Text[20])
        {
            trigger OnValidate()
            begin
                HREmp.reset();
                hremp.SetRange("Passport Number", rec."Passport Number");
                if HREmp.findfirst() then
                    Error('Passport Number Already Exists');

            end;
        }
        field(127; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(128; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(129; PensionJoin; Text[8])
        {
        }
        field(130; DateLeaving; Text[30])
        {
        }
        field(131; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGION'));
        }
        field(132; "Manager Emp No"; Code[30])
        {
        }
        field(133; Temp; Text[20])
        {
        }
        field(134; "Employee Qty"; Decimal)
        {
            FieldClass = Normal;
        }
        field(135; "Employee Act. Qty"; Decimal)
        {
            FieldClass = Normal;
        }
        field(136; "Employee Arc. Qty"; Decimal)
        {
            FieldClass = Normal;
        }
        field(137; "Contract Location"; Text[20])
        {
            Description = 'Location where contract was closed';
        }
        field(138; "First Language Read"; Boolean)
        {
        }
        field(139; "First Language Write"; Boolean)
        {
        }
        field(140; "First Language Speak"; Boolean)
        {
        }
        field(141; "Second Language Read"; Boolean)
        {
        }
        field(142; "Second Language Write"; Boolean)
        {
        }
        field(143; "Second Language Speak"; Boolean)
        {
        }
        field(144; "Custom Grading"; Code[20])
        {
        }
        field(145; "PIN No."; Code[20])
        {
            trigger OnValidate()
            begin
                //CHECK FOR DUPLICATE KRA PIN NUMBER
                if "PIN No." <> '' then begin
                    HREmp.Reset();
                    HREmp.SetRange("PIN No.", "PIN No.");
                    //EXCLUDE CURRENT RECORD FROM DUPLICATE CHECK
                    if "No." <> '' then
                        HREmp.SetFilter("No.", '<>%1', "No.");
                    if HREmp.FindFirst() then
                        Error('KRA PIN NUMBER [%1] ALREADY EXISTS FOR EMPLOYEE [%2] - [%3]. DUPLICATE KRA PIN NUMBERS ARE NOT ALLOWED. PLEASE VERIFY THE PIN NUMBER.', "PIN No.", HREmp."No.", HREmp."Full Name");
                end;

                //CHECK IF PIN MATCHES MEMBER RECORD
                if "No." <> '' then begin
                    if "Member No." <> '' then begin
                        if Members.Get("Member No.") then begin
                            if UpperCase(DelChr("PIN No.", '=', ' ')) <> UpperCase(DelChr(Members."P.I.N Number", '=', ' ')) then
                                Message('KRA PIN MISMATCH DETECTED:' + '\' + '\' +
                                    'Employee Card PIN: %1' + '\' +
                                    'Member Register PIN: %2' + '\' + '\' +
                                    'The KRA PIN number on the Employee Card differs from the Member Register. Please verify which PIN is correct and update the Member Register accordingly to maintain data consistency.',
                                    "PIN No.", Members."P.I.N Number");
                        end;
                    end;
                end;

                //VALIDATE PIN FORMAT
                // if StrPos("PIN No.", 'A') <> 1 then
                //     Error('First letter must be an A');
                // end;

                if StrLen("PIN No.") <> 11 then
                    Error('P.I.N Number length must be 11 characters');

                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                if not MemberApplication.ValidateShouldNotHaves(CopyStr("PIN No.", 1, 1), Characters) then
                    Error('First character must be a letter');

                if not MemberApplication.ValidateShouldNotHaves(CopyStr("PIN No.", 11, 1), Characters) then
                    Error('Last character must be a letter');

                Characters := '1234567890';
                if MemberApplication.ValidateShouldNotHaves(CopyStr("PIN No.", 2, 8), Characters) then
                    Error('Pin number must be alphanumeric');
            end;
        }
        field(146; "NSSF No."; Code[20])
        {
            trigger OnValidate()
            begin
                HREmp.reset();
                hremp.SetRange("NSSF No.", rec."NSSF No.");
                if HREmp.findfirst() then
                    Error('NSSF No Already Exists');

            end;
        }
        field(147; "NHIF No."; Code[20])
        {
            trigger OnValidate()
            begin
                HREmp.reset();
                hremp.SetRange("NHIF No.", rec."NHIF No.");
                if HREmp.findfirst() then
                    Error('NSSF No Already Exists');

            end;
        }
        field(148; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(149; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(150; "Sacco Staff No"; Code[20])
        {
        }
        field(151; "Period Filter"; Date)
        {
        }
        field(152; "HELB No"; Text[10])
        {
        }
        field(153; "Co-Operative No"; Text[30])
        {
        }
        field(154; "Wedding Anniversary"; Date)
        {
        }
        field(156; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(157; "Cost Center Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(158; "Position To Succeed"; Code[20])
        {
        }
        field(159; "Succesion Date"; Date)
        {
        }
        field(160; "Send Alert to"; Code[20])
        {
        }
        field(161; Tribe; Code[20])
        {
        }
        field(162; Religion; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Religion));
        }
        field(163; "Job Title"; Text[50])
        {
        }
        field(164; "Post Office No"; Text[20])
        {
        }
        field(165; "Posting Group"; Code[20])
        {
            //NotBlank = false;
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(166; "Payroll Posting Group"; Code[20])
        {
        }
        field(167; "Served Notice Period"; Boolean)
        {
        }
        field(168; "Exit Interview Date"; Date)
        {
        }
        field(169; "Exit Interview Done by"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(170; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(171; "Medical Scheme Name #2"; Text[50])
        {

            trigger OnValidate()
            begin
                //MedicalAidBenefit.SETRANGE("Employee No.","No.");
                //OK := MedicalAidBenefit.FIND('+');
                //IF OK THEN BEGIN
                // REPEAT
                // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
                //  MedicalAidBenefit.MODIFY;
                // UNTIL MedicalAidBenefit.NEXT = 0;
                // END;
            end;
        }
        field(172; "Resignation Date"; Date)
        {
        }
        field(173; "Suspension Date"; Date)
        {
        }
        field(174; "Demised Date"; Date)
        {
        }
        field(175; "Retirement date"; Date)
        {

            trigger OnValidate()
            begin
                //calculate age 02-05-1988
                // yTODAY := Date2DMY(Today, 3); //2014

                // yDOB := Date2DMY("Date Of Birth", 3);
                // dDOB := Date2DMY("Date Of Birth", 1);
                // mDOB := Date2DMY("Date Of Birth", 2);

                // AppAge := yTODAY - yDOB;
                // HREmp.Find('-');
                // if HREmp.Disabled = HREmp.Disabled::No then begin
                //     //calculate how many years remaining for this employee to retire : ret yr is 60
                //     noYrsToRetirement := 60 - AppAge;

                //     //add noYrsToRetirement to current year to get retirement year da
                //     RetirementYear := yTODAY + noYrsToRetirement;
                //     //ERROR(FORMAT(RetirementYear));
                //     RetirementDate := DMY2Date(dDOB, mDOB, RetirementYear);
                //     "Retirement date" := RetirementDate;
                // end else
                //     if HREmp.Disabled = HREmp.Disabled::Yes then
                //         //calculate how many years remaining for this employee to retire : ret yr is 60
                //         noYrsToRetirement := 65 - AppAge;

                // //add noYrsToRetirement to current year to get retirement year da
                // RetirementYear := yTODAY + noYrsToRetirement;
                // //ERROR(FORMAT(RetirementYear));
                // RetirementDate := DMY2Date(dDOB, mDOB, RetirementYear);
                // "Retirement date" := RetirementDate;
                // //END;
                // //END;
            end;
        }
        field(176; "Retrenchment date"; Date)
        {
        }
        field(177; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(178; Permanent; Boolean)
        {
        }
        field(179; "Library Category"; Option)
        {
            OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
        }

        field(180; "Staff Category"; Enum "Staff Category")
        {
        }

        field(181; "Payroll Departments"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(188; "Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
            trigger OnValidate()
            var
                salgrade: record "Salary Grades";
            begin

                salgrade.reset();
                salgrade.setrange("Salary Grade", rec."Salary Grade");
                if salgrade.findfirst then
                    "Employee Group" := salgrade."Employee Group";
                GradeGetLeaveDays();

            end;


            //must be within Salary Grade

            // if ("Basic Pay" < salGrade."Minimum Amount") then
            //     Error('Basic Pay Must be greater than ' + Format(salGrade."Minimum Amount"));
            // if ("Basic Pay" > salGrade."Maxmum Amount") then
            //     Error('Basic Pay Must be greater than ' + Format(salGrade."Maxmum Amount"));


        }
        field(189; "Company Type"; Option)
        {
            OptionCaption = 'Others,USAID';
            OptionMembers = Others,USAID;
        }
        field(190; "Main Bank"; Code[20])
        {
        }
        field(191; "Branch Bank"; Code[20])
        {
        }
        field(192; "Lock Bank Details"; Boolean)
        {
        }
        field(193; "Bank Account Number"; Code[20])
        {
        }
        field(195; "Payroll Code"; Code[20])
        {
        }
        field(196; "Holiday Days Entitlement"; Decimal)
        {
        }
        field(197; "Holiday Days Used"; Decimal)
        {
        }
        field(198; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(199; "Hourly Rate"; Decimal)
        {
        }
        field(200; "Daily Rate"; Decimal)
        {
        }
        field(300; "Social Security No."; Code[20])
        {
        }
        field(301; "Pension House"; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No" WHERE("Group No" = CONST('PENSION'));
        }
        field(302; "Salary Notch/Step"; Code[20])
        {
        }
        field(303; "Status Change Date"; Date)
        {
        }
        field(304; "Previous Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(305; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(306; "Prev. Basic Pay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(307; "Curr. Basic Pay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(308; "Prev. Gross Pay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(309; "Curr. Gross Pay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(310; "Gross Income Variation"; Decimal)
        {
            FieldClass = Normal;
        }
        field(311; "Basic Pay 2"; Decimal)
        {
            Editable = false;
        }
        field(312; "Net Pay"; Decimal)
        {
        }
        field(313; "Transaction Amount"; Decimal)
        {
        }
        field(314; "Transaction Code Filter"; Text[30])
        {
        }
        field(317; "Account Type"; Option)
        {
            OptionCaption = ' ,Savings,Current';
            OptionMembers = " ",Savings,Current;
        }
        field(318; "Location/Division Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('LOC/DIV'));
        }
        field(319; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(320; "Cost Centre Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COSTCENTRE'));
        }
        field(323; "Payroll Type"; Option)
        {
            Description = 'General,Consultants,Seconded Staff';
            OptionCaption = 'General,Consultants,Seconded Staff';
            OptionMembers = General,Consultants,"Seconded Staff";
        }
        field(324; "Employee Classification"; Code[20])
        {
            Description = 'Service';
        }
        field(328; "Department Name"; Text[80])
        {
        }
        field(2004; "Total Leave Taken"; Decimal)
        {
            Caption = 'Annual Leave Taken.';
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = CONST(Negative),
                                                                             Closed = CONST(false), "Is For Annual Leave" = const(True))
                                                                              );
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;

        }
        field(2006; "Total (Leave Days)"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             Closed = CONST(false), "Is For Annual Leave" = const(True)));
            FieldClass = FlowField;
        }
        field(2007; "Cash - Leave Earned"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(2008; "Reimbursed Leave Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = CONST(Reimbursement),
                                                                             Closed = CONST(false), "Is For Annual Leave" = const(True)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;

            // trigger OnValidate()
            // begin
            //     Validate("Allocated Leave Days");
            // end;
        }
        field(2009; "Cash per Leave Day"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(2023; "Allocated Leave Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = FILTER(Positive),
                                                                             Closed = CONST(false), "Is For Annual Leave" = const(True)));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin

                CalcFields("Total Leave Taken");
                "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
                //SUM UP LEAVE LEDGER ENTRIES
                "Leave Balance" := "Total (Leave Days)" - ABS("Total Leave Taken");
                //TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2024; "End of Contract Date"; Date)
        {

            trigger OnValidate()
            var
                MyNotification: Notification;

            begin

                if Today >= rec."End of Contract Date" then begin
                    MyNotification.Message := 'Contract has Ended';
                    //MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Send();

                end;
            end;
        }
        field(2040; "Leave Period Filter"; Code[20])
        {
        }
        field(3899; "Mutliple Bank A/Cs"; Boolean)
        {
        }
        field(3900; "No. Of Bank A/Cs"; Integer)
        {
            CalcFormula = Count("HR Employee Bank Accounts" WHERE("Bank  Code" = FILTER(<> ''),
                                                                   "Branch Code" = FILTER(<> ''),
                                                                   "A/C  Number" = FILTER(<> ''),
                                                                   "Employee Code" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(3971; "Annual Leave Account"; Decimal)
        {
            Caption = 'Total Annual Leave Days';
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE(//"Leave Type" = FILTER('LTY06' | 'LTY01' | 'LTY02'),
                                                                             "Is For Annual Leave" = const(True),
                                                                             "Staff No." = FIELD("No."),
                                                                             Closed = CONST(false)
                                                                             ));
            FieldClass = FlowField;
        }
        field(3972; "Compassionate Leave Acc."; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type Enum" = Filter(Compassionate),
                                                                             "Staff No." = FIELD("No."),
                                                                             Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(3973; "Maternity Leave Acc."; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type Enum" = Filter(Maternity),
                                                                             "Staff No." = FIELD("No."),
                                                                             Closed = CONST(false)));
            FieldClass = FlowField;

        }
        field(3974; "Paternity Leave Acc."; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type Enum" = Filter(Paternity),
                                                                             "Staff No." = FIELD("No."),
                                                                             Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(3975; "Sick Leave Acc."; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type Enum" = Filter("Sick Leave"),
                                                                             "Staff No." = FIELD("No."),
                                                                             Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(3976; "Study Leave Acc"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type Enum" = CONST("Study Leave"),
                                                                             "Staff No." = FIELD("No."),
                                                                             Closed = CONST(false)));
            FieldClass = FlowField;
        }
        field(3977; "Appraisal Method"; Option)
        {
            OptionCaption = ' ,Normal Appraisal,360 Appraisal';
            OptionMembers = " ","Normal Appraisal","360 Appraisal";
        }
        field(3988; "Leave Type"; Code[20])
        {
            TableRelation = "HR Leave Types".Code;
        }
        field(3989; "Employee Type"; Option)
        {
            OptionCaption = ' ,Primary,Secondary,Board';
            OptionMembers = " ",Primary,Secondary,Board;
        }
        field(39003900; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 1 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimensionValue.Name;
                end;
                validate(rec."Responsibility Center");
            end;
        }
        field(39003901; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            Var
                CustomSubscriber: Codeunit MySubscribers;
            begin

                "Global Dimension 2 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 2 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimensionValue.Name;
                end;
                validate(rec."Responsibility Center");



            end;

            //end;
        }
        field(39003902; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR";
            trigger OnValidate()
            var

            begin

            end;
        }
        field(39003903; HR; Boolean)
        {
        }
        field(39003904; "Date Of Join"; Date)
        {
            Caption = 'Date Of Joining the Company';

            trigger OnValidate()
            var
                PrSalInfo: record "PR Salary Card";
                HrEmployees: record "HR Employees";
                PrSalaryCodeunit: codeunit "PR Payroll Processing";
                CountDaysofMonth: integer;


            begin
                dtOpenPeriod := ProcessPayroll.fnGetOpenPeriod();

                // if "Date Of Join" <> 0D then begin
                //     "End Of Probation Date" := "Date Of Join" + 180;
                //     "Pension Scheme Join" := "Date Of Join" + 360;
                //     "Medical Scheme Join" := "Date Of Join" + 360;
                // end else
                //     "End Of Probation Date" := 0D;

                if "Date Of Join" <> 0D then begin
                    month := DATE2DMY("Date Of Join", 2);

                    if (Date2dmy("Date Of Join", 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy("Date Of Join", 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                        CountDaysofMonth := PrSalaryCodeunit.fnDaysInMonth("Date Of Join");
                        DaysWorked := PrSalaryCodeunit.fnDaysWorked("Date Of Join", false);
                    end else
                        DaysWorked := CountDaysofMonth;
                    PrSalInfo.reset();
                    PrSalInfo.setrange("Employee Code", rec."No.");
                    if PrSalInfo.findfirst() then begin
                        PrSalInfo."Days Worked" := DaysWorked;
                        PrSalInfo.Modify(true);
                    end;

                    //CALCULATE YEARS OF SERVICE
                    CalculateYearsOfService();
                end;

            End;

        }
        field(39003905; "Date Of Leaving the Company"; Date)
        {
        }
        field(39003906; "Termination Grounds"; code[50])
        {

        }
        field(39003907; "Cell Phone Number"; code[15])
        {
            ExtendedDatatype = PhoneNo;
            trigger OnValidate()
            var
                Characters: Text;
                NewMob: code[20];
            begin
                Characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';

                if not ValidateShouldNotHaves("Cell Phone Number", Characters) then Error('Phone number has invalid characters');


                NewMob := '';
                NewMob := CopyStr("Cell Phone Number", 1, 4);
                if (CopyStr("Cell Phone Number", 1, 4)) <> '+254' then
                    Error('The Mobile phone No. should take the format of ' + '+254');
                if StrLen("Cell Phone Number") <> 13 then
                    Error('Phone No. should be equal to 13 characters');
            end;
        }
        field(39003908; Grade; Code[10])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Grade));
        }
        field(39003909; "Employee UserID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(39003910; "Leave Balance"; Decimal)
        {
        }
        field(39003911; "Leave Status"; Option)
        {
            OptionCaption = ' ,On Leave,Resumed';
            OptionMembers = " ","On Leave",Resumed;
        }
        field(39003912; "Pension Scheme Join Date"; Date)
        {
        }
        field(39003913; "Medical Scheme Join Date"; Date)
        {
        }
        field(39003914; "Leave Type Filter"; Code[20])
        {
            TableRelation = "HR Leave Types";
        }
        field(39003915; "Acrued Leave Days"; Decimal)
        {
        }
        field(39003925; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                //must be within Salary Grade
                SalCard.Reset;
                salGrade.SetRange(salGrade."Salary Grade", "Salary Grade");
                if salGrade.Find('-') then begin
                    if ("Basic Pay" < salGrade."Minimum Amount") then
                        Error('Basic Pay Must be greater than ' + Format(salGrade."Minimum Amount"));
                    if ("Basic Pay" > salGrade."Maxmum Amount") then
                        Error('Basic Pay Must be greater than ' + Format(salGrade."Maxmum Amount"));
                end;
            end;
        }
        field(39003928; "Last Date Modified By"; Code[30])
        {
            Editable = false;
        }
        field(39003930; "Global Dimension 1 Name"; Text[60])
        {
            Editable = false;
        }
        field(39003931; "Global Dimension 2 Name"; Text[60])
        {
            Editable = false;
        }
        field(39003932; "Effective From Date"; Date)
        {
        }
        field(39003933; "Expiry Date"; Date)
        {

        }
        field(39003934; Activate; Option)
        {
            OptionCaption = ',re-engage,re-instate';
            OptionMembers = ,"re-engage","re-instate";

            trigger OnValidate()
            begin
                if Status = Status::InActive then begin
                    if Activate = Activate::"re-instate"
                      then begin
                        Status := Status::Active;
                    end;
                    if Activate = Activate::"re-engage"
                      then begin
                        Status := Status::Active;
                        "Date Of Join" := 0D;
                    end;
                    Modify;
                end;
            end;
        }
        field(39003935; "Supervisor Code"; Code[50])
        {
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                IndividualAppraisal: Record "HR Individual Targets Header";
                OldSupervisorID: Code[50];
                UpdateCount: Integer;
            begin
                if "Supervisor Code" <> '' then begin
                    UserSetup.Get("Supervisor Code");
                    "Supervisor Name" := UserSetup."Full Name";
                end else
                    "Supervisor Name" := '';

                // Update all open appraisals when supervisor changes
                if (xRec."Supervisor Code" <> "Supervisor Code") and (xRec."Supervisor Code" <> '') then begin
                    OldSupervisorID := xRec."Supervisor Code";
                    UpdateCount := 0;

                    IndividualAppraisal.Reset();
                    IndividualAppraisal.SetRange("Employee No", "No.");
                    IndividualAppraisal.SetRange("Supervisor ID", OldSupervisorID);
                    IndividualAppraisal.SetFilter(Status, '<%1', IndividualAppraisal.Status::Approved);
                    
                    if IndividualAppraisal.FindSet(true) then begin
                        repeat
                            IndividualAppraisal."Supervisor ID" := "Supervisor Code";
                            IndividualAppraisal."Supervisor Name" := "Supervisor Name";
                            IndividualAppraisal.Modify();
                            UpdateCount += 1;
                        until IndividualAppraisal.Next() = 0;

                        if UpdateCount > 0 then
                            Message('%1 appraisal(s) updated with new supervisor: %2', UpdateCount, "Supervisor Name");
                    end;
                end;
            end;
        }
        field(39003936; "Supervisor Name"; Text[50])
        {
            Editable = false;
        }
        field(39003937; "Probation Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "End Of Probation Date" := CalcDate("Probation Duration", "Date Of Join");
            end;

        }
        field(39003938; Users; Text[50])
        {
        }
        field(39003939; "Reason For Status Change"; Code[40])
        {
        }
        field(39003940; "Employee Group"; Code[20])
        {
            TableRelation = "Employee Group";
        }
        field(39003941; "Residential status"; Option)
        {
            OptionMembers = Resident,"Non Resident";
        }
        field(39003942; "Type of Employee"; Option)
        {
            OptionMembers = Primary,Secondary;
        }
        field(39003943; Year; Integer)
        {
        }
        field(39003944; "PF No."; code[20])
        {
        }
        //field(39003945; "Certificate No."; code[40])
        //{
        //}
        //FIELD RENAMED BACK - THIS IS FOR DISABILITY CERTIFICATE, NOT KRA
        field(39003945; "Certificate No."; code[40])
        {
            Caption = 'Disability Certificate No.';
        }
        field(39003946; "Member No."; code[20])
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            var

            begin




            end;
        }
        field(39003947; "Primary Identification Type"; Enum "Identification Type")
        {
            ValuesAllowed = "ID Number", "Passport No", "Huduma/Maisha Number";
            trigger OnValidate()
            var
                myInt: Integer;

            begin

                "Primary Identification" := '';
                if "Secondary Identification Type" <> Rec."Secondary Identification Type"::" " then
                    if "Primary Identification Type" = "Secondary Identification Type" then begin
                        if Confirm('Primary and secondary identification types cannot be the same\Should we clear the secondary identifications') then begin
                            "Secondary Identification Type" := Rec."Secondary Identification Type"::" ";
                            "Secondary Identification" := '';
                        end else begin
                            "Primary Identification Type" := xRec."Primary Identification Type";
                            "Primary Identification" := xRec."Primary Identification";
                        end;
                    end;
            end;
        }
        field(39003948; "Secondary Identification Type"; Enum "Identification Type")
        {
        }


        field(39003949; "Primary Identification"; Code[20])
        {

            trigger OnValidate()
            begin
                "Primary Identification" := ValidateIdentificationTypes("Primary Identification Type", "Primary Identification", PrimaryOrSecondaryID::Primary);
                HREmp.reset();
                hremp.SetRange("Primary Identification", rec."Primary Identification");
                if HREmp.findfirst() then
                    Error('ID No Already Exists');

            end;
        }

        field(39003950; "Secondary Identification"; Code[10])
        {

            trigger OnValidate()
            begin
                "Secondary Identification" := ValidateIdentificationTypes("Secondary Identification Type", "Secondary Identification", PrimaryOrSecondaryID::Secondary);
            end;
        }
        field(39003951; Month; integer)
        {
            trigger OnValidate()
            var
                HrEmp: record "HR Employees";
            begin

            end;
        }
        field(39003952; "Retirement Age"; DateFormula)
        {

            trigger OnValidate()
            begin

            end;

        }
        field(39003953; "Medical Insurance No."; Code[20])
        {
            trigger OnValidate()
            begin
                HREmp.reset();
                hremp.SetRange("Medical Insurance No.", rec."Medical Insurance No.");
                if HREmp.findfirst() then
                    Error('No Already Exists');

            end;
        }
        field(39003954; "Contract Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                "Contract End Date" := CalcDate("Contract Duration", "Date Of Join");
            end;




        }
        field(39003955; "Monthly Leave Days"; Decimal)
        {


        }
        field(39003956; "Position Reporting To"; Text[100])
        {
            Editable = false;


        }
        field(39003957; "County Of Birth"; Text[30])
        {
            Caption = 'County Of Birth';
            Description = 'LookUp to Member Segment Table where Type = County';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));

        }
        field(39003958; "Disciplinary Case"; code[20])
        {

        }
        field(39003959; Nature; code[20])
        {
            TableRelation = "HR Disciplinary Cases NCA"."Type Complaint";
        }
        field(39003960; "Date Reported"; date)
        {
            TableRelation = "HR Disciplinary Cases NCA"."Date of Complaint";
        }
        field(39003961; "Action Taken"; code[100])
        {
            TableRelation = "HR Disciplinary Cases NCA"."Action Taken";
            // OptionCaption = ' ,Verbal Warning,1st Letter Warning,2nd Letter Warning,3rd Letter Warning,Final Letter Warning,Interdiction,Suspension';
            // OptionMembers = " ","Verbal Warning","1st Letter Warning","2nd Letter Warning","3rd Letter Warning","Final Letter Warning",Interdiction,Suspension;

        }
        field(39003962; "Disciplinary Duration"; DateFormula)
        {
            TableRelation = "HR Disciplinary Cases NCA".Duration;
        }
        field(39003963; "Hearing Date"; date)
        {
            TableRelation = "HR Disciplinary Cases NCA"."Date To Discuss Case";
        }
        field(39003964; "Years of service"; decimal)
        {
            Caption = 'Years of Service';
            //NEW FIELD - NOT EDITABLE, 2 DECIMAL PLACES
            Editable = false;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //AUTO-CALCULATED - NO MANUAL ENTRY
            end;
        }
        field(39003965; "cpd points"; decimal)
        {

        }
        field(39003966; Title2; Option)
        {
            OptionMembers = " ",Mr,Mrs,Miss,Ms,"Dr."," Eng. ",Prof;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Title2 <> rec.Title2::" " then
                    if Title = Title2 then begin
                        Error('Cannot have Two same Titles');
                    end;
            end;
        }
        field(39003967; "Reengagement Date"; date)
        {

        }
        field(39003968; "Available Leave Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             Closed = CONST(false), "Is For Annual Leave" = const(True))
                                                                              );
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;

        }
        field(39003969; "Member Status"; enum "Member Status")
        {

        }
        field(39003970; "Current Approver ID"; Code[50])
        {
            CalcFormula = Lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."),
                                                                        Status = FILTER(Open)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Current Approver ID';
        }
        field(39003971; "Approval Status"; Enum "Approval Status")
        {
            CalcFormula = Lookup("Approval Entry".Status WHERE("Document No." = FIELD("No."),
                                                                Status = FILTER(Open)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Approval Status';
        }
        field(39003972; "Rejection Reason"; Text[250])
        {
            Caption = 'Rejection Reason';
            DataClassification = ToBeClassified;
        }




    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "First Name")
        {
        }
        key(Key3; "Middle Name")
        {
        }
        key(Key4; "Last Name")
        {
        }
        key(Key5; "Member No.")
        {
        }
        key(Key6; "ID Number")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Member No.", "ID Number", "First Name", "Middle Name", "Last Name")
        {
        }
    }

    trigger OnInsert()
    begin
        //AUTO-GENERATE EMPLOYEE NUMBER
        if "No." = '' then begin
            HrSetup.Get;
            HrSetup.TestField("Employee Nos.");
            //"No." := NoSeriesMgt.GetNextNo(HrSetup."Employee Nos.", Today, true);
            "No." := NoSeriesMgt.GetNextNo(HrSetup."Employee Nos.");
            "No. Series" := HrSetup."Employee Nos.";
        end;
    end;


    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Last Date Modified By" := UserId;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Usersetup: record "User Setup";
        Mail: text[100];
        email: codeunit Email;
        userset: Record "User Setup";

        Filename: Text;
        usermail: Text;
        username: text;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br> <P>find Documents to be approved</P> <h>';
        EmailMsg: Codeunit "Email Message";
        salGrade: Record "Salary Grades";
        GlobalFunctions: Codeunit "Global Functions";
        Res: Record Resource;
        PostCode: Record "Post Code";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        //NoSeriesMgt: Codeunit "No. Series - Batch";
        NoSeriesMgt: Codeunit "No. Series";

        HrSetup: Record "HR Setup";
        SalCard: Record "PR Salary Card";
        PRPayrollPeriod: Record "PR Payroll Periods";
        EmpTrans: Record "PR Employee Transactions";
        EmpTransR: Record "PR Employee Transactions";
        UserMgt: Codeunit "User Management";
        DimVal: Record "Dimension Value";
        objJobs: Record "HR Jobs";
        HREmp: Record "HR Employees";
        EmpFullName: Text;
        SPACER: Label ' ';
        yDOB: Integer;
        DaysWorked: Decimal;
        Days: Integer;

        yTODAY: Integer;
        noYrsToRetirement: Integer;
        member: record Members;
        RetirementYear: Integer;
        AppAge: Integer;
        RetirementYear2: Text;
        Dates: Codeunit "HR Codeunit2";
        DimensionValue: Record "Dimension Value";
        RetirementDate: Date;
        dDOB: Integer;
        mDOB: Integer;
        DaystoRetirement: Text;
        HRJobs: record "HR Jobs";
        HasHRSetup: Boolean;
        PRPeriodTrans: Record "PR Period Transactions";
        Text0005: Label 'Please note that ALL PAYROLL TRANSACTIONS PROCESSED for [EMPLOYEE  :: %1 - %2  ] in the [CURRENT PAYROLL PERIOD :: %3 ] will be deleted. \\Proceed?';
        ag: Integer;
        HRCodeunit: Codeunit "HR Codeunit";
        WorkedDays: decimal;

        dtOpenPeriod: Date;
        ProcessPayroll: Codeunit "PR Payroll Processing";
        EndMonth: date;
    // Smtp: Codeunit "SMTP Mail";


    // [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("Known As" + ' ' + "Last Name")
        else
            exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    // [Scope('OnPrem')]
    procedure CurrentPayDetails()
    begin
    end;

    // [Scope('OnPrem')]
    procedure UpdtResUsersetp(var HREmpl: Record "HR Succession Job Rotation")
    var
        Res: Record Resource;
        Usersetup: Record "User Setup";
    begin
        /*
        ContMgtSetup.GET;
        IF ContMgtSetup."Customer Integration" =
           ContMgtSetup."Customer Integration"::"No Integration"
        THEN
          EXIT;
        */
        /*
        Res.SETCURRENTKEY("No.");
        Res.SETRANGE("No.",HREmpl."Resource No.");
        IF Res.FIND('-') THEN BEGIN
          Res."Global Dimension 1 Code" := HREmpl."Department Code";
          Res."Global Dimension 2 Code" := HREmpl.Office;
          Res.MODIFY;
        END;
        
        IF Usersetup.GET(HREmpl."User ID") THEN BEGIN
          Usersetup.Department := HREmpl."Department Code";
          Usersetup.Office := HREmpl.Office;
          Usersetup.MODIFY;
        END;
        */

    end;

    // [Scope('OnPrem')]
    procedure SetEmployeeHistory()
    begin
    end;

    // [Scope('OnPrem')]
    procedure GetPayPeriod()
    begin
    end;

    local procedure fn_FullName()
    begin
        "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    end;

    //ADDED PROCEDURE TO CALCULATE YEARS OF SERVICE
    local procedure CalculateYearsOfService()
    var
        YearsDiff: Integer;
        MonthsDiff: Integer;
        TotalMonths: Decimal;
    begin
        if "Date Of Join" = 0D then begin
            "Years of service" := 0;
            exit;
        end;

        //CALCULATE YEARS AND MONTHS BETWEEN DATE OF JOIN AND TODAY
        YearsDiff := Date2DMY(Today, 3) - Date2DMY("Date Of Join", 3);
        MonthsDiff := Date2DMY(Today, 2) - Date2DMY("Date Of Join", 2);

        //ADJUST IF MONTHS ARE NEGATIVE
        if MonthsDiff < 0 then begin
            YearsDiff := YearsDiff - 1;
            MonthsDiff := MonthsDiff + 12;
        end;

        //CONVERT TO DECIMAL (YEARS.MONTHS)
        TotalMonths := (YearsDiff * 12) + MonthsDiff;
        "Years of service" := Round(TotalMonths / 12, 0.01);
    end;

    // [Scope('OnPrem')]
    procedure GetHRSetup()
    begin
        if not HasHRSetup then begin
            HrSetup.Get;
            HasHRSetup := true;
        end;
    end;

    procedure ValidateIdentificationTypes(IdentificationType: enum "Identification Type"; Identification: Code[30];
                                                                  PrimaryOrSecondaryID: Option Primary,Secondary): Code[30]
    var
        Members: Record Members;
        Characters: Text;
    begin

        if IdentificationType = IdentificationType::"ID Number" then begin
            if StrLen(Identification) > 9 then Error('ID Number cannot have more than 9 characters');
            if StrLen(Identification) < 5 then Error('ID Number cannot have less than 7 characters');
            Characters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('ID Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Passport No" then begin
            if StrLen(Identification) > 12 then Error('Passport Number cannot have more thna 12 characters');
            if StrLen(Identification) < 7 then Error('Passport Number cannot have less than 7 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('Passport Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Birth Certificate Number" then begin
            if StrLen(Identification) < 7 then Error('Birth Certificate Number cannot have less than 7 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('Birth Certificate Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Service Number" then begin
            if StrLen(Identification) < 7 then Error('Service Number cannot have less than 7 characters');
            if StrLen(Identification) > 10 then Error('Service Number cannot have more thna 10 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('Service Number has invalid characters');
        end;
        exit(Identification);
    end;

    procedure ValidateShouldNotHaves(Number: Text; CharactersToCheck: Text): Boolean
    var
        i: Integer;

    begin
        FOR i := 1 TO STRLEN(Number) DO
            IF STRPOS(CharactersToCheck, Number[i]) > 0 THEN
                exit(false);

        exit(true);
    end;

    procedure SendEmailWithAttachment(var emailadress: Text[50])
    var
        ReportExample: Report "Member Detailed Statement";
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        TxtRecipientsList: List of [Text];
    begin
        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Member Detailed Statement", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        TxtRecipientsList.Add(emailadress);
        EmailMsg.Create(emailadress, 'Subject-Request For Quotation', 'Body-Please Provide Prices for the Items Specified');
        //EmailMsg.AddAttachment('FileName.pdf', 'PDF', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;
    // procedure SendEmails()
    // var
    //     myInt: Integer;
    //     email: codeunit Email;
    //     userset: Record "User Setup";

    //     Filename: Text;
    //     usermail: Text;
    //     username: text;
    //     instr: InStream;
    //     emailbody: Label 'Dear <b>%1</b>, <br> <P>find Documents to be approved</P> <h>';
    // begin
    //     userset.Reset();
    //     userset.SetRange("User ID", UserId);
    //     if userset.FindFirst() then begin
    //         usermail := userset."E-Mail";
    //         username := userset."Full Name";
    //         Message(username);
    //     end;
    //     EmailMsg.Create(usermail, 'Request to approve', '', true);
    //     EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
    //     if UploadIntoStream('Select the file', '', 'This files|*.jpg;*.pdf;*.docx;*.png', Filename, instr) then
    //         EmailMsg.AddAttachment(Filename, '', instr)
    //     else
    //         Message('There was an error in uploading %1', GetLastErrorText());
    //     if email.Send(EmailMsg) then
    //         Message('Email sent successfully')
    //     else
    //         Message('There was an error in sendingmail,%1', GetLastErrorText());
    // end;

    procedure GradeGetLeaveDays()
    begin
        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        if HREmp.Get(Rec."No.") then begin
            if HREmp."Salary Grade" <> xRec."Salary Grade" then begin
                SalGrade.reset();
                salgrade.SetRange("Salary Grade", rec."Salary Grade");
                salgrade.SetRange("Employee Group", rec."Employee Group");
                if SalGrade.Find('-') then begin
                    HRLeaveCal.Reset;
                    HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                    if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');
                    //Filter by Leave Period from HR Setup


                    HRLeaveLedgerEntries.Reset;
                    // HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Entry No.");
                    // HRLeaveLedgerEntries.setrange("Leave Calendar Code", HRLeaveCal."Calendar Code");
                    if HRLeaveLedgerEntries.Find('+') then cbf := HRLeaveLedgerEntries."Entry No.";

                    rec.CalcFields("Allocated Leave Days");
                    if salgrade."Leave Days" <> Rec."Allocated Leave Days" then begin
                        dAlloc := 0;
                        dEarnd := salgrade."Leave Days" - rec."Allocated Leave Days";

                        cbf := cbf + 1;
                        HRLeaveLedgerEntries.Init;
                        HRLeaveLedgerEntries."Entry No." := cbf;
                        HRLeaveLedgerEntries."Staff No." := rec."No.";
                        HRLeaveLedgerEntries."Staff Name" := rec.FullName;
                        HRLeaveLedgerEntries."Posting Date" := Today;
                        HRLeaveLedgerEntries."Leave Entry Type" := HRLeaveLedgerEntries."Leave Entry Type"::Positive;
                        HRLeaveLedgerEntries."Leave Approval Date" := Today;
                        HRLeaveLedgerEntries."Document No." := rec."No.";
                        HRLeaveLedgerEntries."External Document No." := rec."No.";
                        HRLeaveLedgerEntries."Job ID" := rec."Job Title";
                        HRLeaveLedgerEntries."No. of days" := dEarnd;
                        HRLeaveLedgerEntries."Leave Calendar Code" := HRLeaveCal."Calendar Code";
                        HRLeaveLedgerEntries."Is For Annual Leave" := true;
                        //HRLeaveLedgerEntries."Leave Start Date" := "Start Date";
                        HRLeaveLedgerEntries."Leave Posting Description" := 'Grade Change';
                        //HRLeaveLedgerEntries."Leave End Date" := '';
                        //HRLeaveLedgerEntries."Leave Return Date" := '';
                        HRLeaveLedgerEntries."User ID" := rec."User ID";
                        HRLeaveLedgerEntries.Insert(true);

                    end;
                end;
            end;
        end;
    end;

    PROCEDURE SendSupervisorEmail()
    begin
        if rec.Status = rec.Status::Active then begin
            if (rec."Supervisor Code" <> '') and (rec."Responsibility Center" <> '') and (rec."Global Dimension 1 Code" <> '') and (rec."Global Dimension 2 Code" <> '') then begin
                if (rec."Responsibility Center" <> xrec."Responsibility Center") or (rec."Supervisor Code" <> xrec."Supervisor Code") or
                (rec."Global Dimension 1 Code" <> xrec."Global Dimension 1 Code") or (rec."Global Dimension 2 Code" <> xrec."Global Dimension 2 Code") then begin
                    Usersetup.reset();
                    Usersetup.setrange("Employee No.", rec."No.");
                    If Usersetup.findfirst then begin
                        Mail := Usersetup."E-Mail";
                        msg := 'Kindly Update Your Targets';


                        EmailMsg.Create(Mail, 'Update Targets', msg, true);

                        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then
                            Message('Email sent successfully')
                        else
                            Message('There was an error in sendingmail,%1', GetLastErrorText());

                    end;
                    if (rec."Responsibility Center" <> xrec."Responsibility Center") or (rec."Supervisor Code" <> xrec."Supervisor Code") or
               (rec."Global Dimension 1 Code" <> xrec."Global Dimension 1 Code") or (rec."Global Dimension 2 Code" <> xrec."Global Dimension 2 Code") then begin
                        userset.reset();
                        userset.setrange("User ID", rec."Supervisor Code");
                        if userset.FindFirst() then begin
                            Mail := Userset."E-Mail";
                            msg := 'Kindly Update Employee No' + '' + rec."No." + '' + rec.FullName + '' + 'Targets';

                            EmailMsg.Create(Mail, 'Update Employee Targets', msg, true);

                            if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then
                                Message('Email sent successfully')
                            else
                                Message('There was an error in sendingmail,%1', GetLastErrorText());
                        end;
                    end;
                end;
            end;
        end;
    end;



    var
        PrimaryOrSecondaryID: Option Primary,Secondary;
        Members: record Members;
        Characters: Text;
        MemberApplication: record "Member Application";
        dAlloc: Decimal;
        SystemEdits: record "System Edits";
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Integer;
        SendSms: codeunit SendSms;
        Msg: Text[100];
        SMSSource: enum "SMS Source";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        HRLeaveCal: record "HR Leave Calendar";


}

