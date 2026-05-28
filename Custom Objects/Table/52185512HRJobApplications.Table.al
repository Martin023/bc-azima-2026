table 52185512 "HR Job Applications"
{
    Caption = 'HR Job Applications';
    DrillDownPageID = "HR Job Applications List";
    // LookupPageID = "HR Job Applications List";

    fields
    {
        field(1; "Job Application No."; Code[50])
        {
            Editable = false;
        }
        field(2; "First Name"; Text[100])
        {

            trigger OnValidate()
            begin
                fn_FullName;
                fn_initials;
            end;
        }
        field(3; "Middle Name"; Text[50])
        {

            trigger OnValidate()
            begin
                fn_FullName;
                fn_initials;
            end;
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            // var
            //     Reason: Text[30];
            begin
                fn_FullName;
                fn_initials;
            end;
        }
        field(5; Initials; Text[15])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[30])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Integer)
        {
        }
        field(14; "Cell Phone Number"; code[20])
        {
        }
        field(15; "Work Phone Number"; Integer)
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                // sSmtp.CheckValidEmailAddresses("E-Mail");
            end;
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(20; "ID Number"; code[20])
        {

            trigger OnValidate()
            begin
                HRJobApp.Reset;
                //HRJobApp.SETRANGE(HRJobApp."ID Number","ID Number");
                HRJobApp.SetRange(HRJobApp."ID Number", "ID Number");
                if HRJobApp.Find('-') then begin
                    Error('This ID Number has been used in a prior Job Application.');
                end;

                //HRCodeunit.fn_CheckIDNumber(FORMAT("ID Number"));
            end;
        }
        field(21; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(22; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(23; Status; Option)
        {
            OptionMembers = Application,Shortlisted,Approved,Unqualified;
            Editable = false;
            trigger OnValidate()
            begin
                if rec.status = rec.Status::Unqualified then
                    rec.TestField("Rejection Reason");
                
                //SEND AUTOMATIC EMAIL RESPONSE BASED ON STATUS CHANGE
                if xRec.Status <> Rec.Status then begin
                    case Rec.Status of
                        Rec.Status::Application:
                            SendApplicationReceivedEmail();
                        Rec.Status::Shortlisted:
                            SendShortlistedEmail();
                        Rec.Status::Approved:
                            SendApprovedEmail();
                        Rec.Status::Unqualified:
                            SendUnqualifiedEmail();
                    end;
                end;
            end;
        }
        field(24; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(25; "Fax Number"; Text[30])
        {
        }
        field(26; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27; Colour; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(29; "Driving Licence"; Code[10])
        {
        }
        field(30; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(31; "Health Assesment?"; Boolean)
        {
        }
        field(32; "Health Assesment Date"; Date)
        {
        }
        //to be changed
        field(33; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin

                Ag := Round(((Today - "Date of Birth") / 365), 1, '=');
                if Ag < 18 then Error('Your Age is below 18 years');
                if "Date Of Birth" >= Today then begin
                    Error('Date of Birth cannot be after %1', Today);
                end;

                // Age := HRCodeunit.DetermineAge("Date Of Birth", Today);


            end;
        }
        field(34; Age; Text[80])
        {
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(36; "Additional Language"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(37; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
        }
        field(41; "Postal Address3"; Text[20])
        {
        }
        field(42; "Residential Address2"; Text[30])
        {
        }
        field(43; "Residential Address3"; Text[20])
        {
        }
        field(44; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(45; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                Country.Reset;
                Country.SetRange(Country.Code, Citizenship);
                if Country.Find('-') then begin
                    "Citizenship Details" := Country.Name;
                end;
            end;
        }
        field(46; "Disabling Details"; Text[50])
        {
        }
        field(47; "Disability Grade"; Text[30])
        {
        }
        field(48; "Passport Number"; Text[30])
        {
        }
        field(49; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(52; "First Language Read"; Boolean)
        {
        }
        field(53; "First Language Write"; Boolean)
        {
        }
        field(54; "First Language Speak"; Boolean)
        {
        }
        field(55; "Second Language Read"; Boolean)
        {
        }
        field(56; "Second Language Write"; Boolean)
        {
        }
        field(57; "Second Language Speak"; Boolean)
        {
        }
        field(58; "PIN Number"; Code[20])
        {
        }
        field(59; "Job Applied For"; Text[30])
        {
            Editable = false;
        }
        field(60; "Employee Requisition No"; Code[20])
        {
            TableRelation = "HR Employee Requisitions"."Requisition No.";

            trigger OnValidate()
            begin
                "Job Applied For" := '';
                "Job Applied for Description" := '';

                HREmpReq.Reset;
                HREmpReq.SetRange(HREmpReq."Requisition No.", "Employee Requisition No");
                if HREmpReq.Find('-') then begin
                    "Job Applied For" := HREmpReq."Job ID";
                    "Job Applied for Description" := HREmpReq."Job Description";
                end;
            end;
        }
        field(61; "Total Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(62; Shortlist; Boolean)
        {
        }
        field(63; Qualified; Boolean)
        {
            Editable = true;
        }
        field(64; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(67; "Applicant Type"; Option)
        {
            OptionCaption = ' ,External,Internal';
            OptionMembers = " ",External,Internal;
        }
        field(68; "Interview Invitation Sent"; Boolean)
        {
            Editable = true;
        }
        field(69; "Date Applied"; Date)
        {
        }
        field(70; "Citizenship Details"; Text[60])
        {
        }
        field(71; Expatriate; Boolean)
        {
        }
        field(72; "Total Score After Interview"; Decimal)
        {
            CalcFormula = Sum("HR Job Interview".Score WHERE("Applicant No" = FIELD("Job Application No.")));
            FieldClass = FlowField;
        }
        field(73; "Total Score After Shortlisting"; Decimal)
        {
        }
        field(74; "Date of Interview"; Date)
        {
        }
        field(75; "From Time"; Time)
        {
        }
        field(76; "To Time"; Time)
        {
        }
        field(77; Venue; Text[100])
        {
        }
        field(78; "Job Applied for Description"; Text[100])
        {
        }
        field(79; "Regret Notice Sent"; Boolean)
        {
        }
        field(80; "Interview Type"; Option)
        {
            OptionCaption = 'Writen,Practicals,Oral';
            OptionMembers = Writen,Practicals,Oral;
        }
        field(81; Uploaded; Boolean)
        {
        }
        field(82; "Full Name"; Text[100])
        {
        }
        field(83; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center B".Code;
        }
        field(84; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(85; "Ethnic Origin"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Interview Areas"));
        }
        field(86; "Document Status"; Option)
        {
            OptionMembers = "Application Stage","Shortlisting Stage",Closed;
        }
        field(87; "Proposed Salary"; Decimal)
        {
        }
        field(89; "Email Sent"; boolean)
        {

        }
        field(90; "Is Employee"; boolean)
        {

        }
        field(91; "Reason"; text[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec."Is Employee" = false then begin
                    Validate(Reason);
                end
            end;

        }
        field(92; Ag; Integer)
        {

        }
        field(93; "Rejection Reason"; text[150])
        {

        }

        field(94; "Sent Email"; boolean)
        {

        }



    }

    keys
    {
        key(Key1; "Job Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Job Application No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Job Application Nos");
            "Job Application No." := NoSeriesMgt.GetNextNo(HRSetup."Job Application Nos");

            // NoSeriesMgt.InitSeries(HRSetup."Job Application Nos", xRec."No. Series", 0D, "Job Application No.", "No. Series");
        end;

        "Date Applied" := Today;

        //Applicant Type
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Applicant Type" := "Applicant Type"::Internal;
        end else begin
            "Applicant Type" := "Applicant Type"::External;
        end;
    end;

    var
        HREmpReq: Record "HR Employee Requisitions";
        HRSetup: Record "HR Setup";
        noSeriesMgt: Codeunit "No. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmpQual: Record "HR Employee Qualifications";
        HRAppQual: Record "HR Applicant Qualifications";
        HRAppReff: Record "HR Applicant Referees";
        HRAppHobb: Record "HR Applicant Hobbies";
        HRJobApp: Record "HR Job Applications";
        Country: Record "Country/Region";
        HREmp: Record "HR Employees";
        HRCodeunit: Codeunit "HR Codeunit2";
    // ag: Integer;
    // Smtp: Codeunit "SMTP Mail";

    // [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    local procedure fn_FullName()
    begin
        "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    end;

    local procedure fn_initials()
    var
        FstInitial: Text[1];
        MidInitial: Text[1];
        LstInitial: Text[1];
    begin
        FstInitial := CopyStr("First Name", 1, 1).ToUpper();
        MidInitial := CopyStr("Middle Name", 1, 1).ToUpper();
        LstInitial := CopyStr("Last Name", 1, 1).ToUpper();
        Initials := FstInitial + MidInitial + LstInitial;
    end;

    local procedure fn_PopulateStaffDetails()
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
        if HREmp.Find('-') then begin
            //Insert Bio Data
            "First Name" := HREmp."First Name";
            "Middle Name" := HREmp."Middle Name";
            "Last Name" := HREmp."Last Name";
            "Postal Address" := HREmp."Postal Address";
            "Residential Address" := HREmp."Residential Address";
            City := HREmp.City;
            "Post Code" := HREmp."Post Code";
            County := HREmp.County;
            // "Home Phone Number":=HREmp."Home Phone Number";
            // "Cell Phone Number":=HREmp."Cellular Phone Number";
            //    "Work Phone Number":=HREmp."Work Phone Number";
            "Ext." := HREmp."Ext.";
            "E-Mail" := HREmp."E-Mail";
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
            "ID Number" := HREmp."ID Number";

            Gender := HREmp.Gender;
            "Country Code" := HREmp."Country Code";
            "Marital Status" := HREmp."Marital Status";
            "First Language (R/W/S)" := HREmp."First Language (R/W/S)";
            "First Language Read" := HREmp."First Language Read";
            "First Language Speak" := HREmp."First Language Speak";
            "First Language Write" := HREmp."First Language Write";
            "Second Language (R/W/S)" := HREmp."Second Language (R/W/S)";
            "Second Language Read" := HREmp."Second Language Read";
            "Second Language Speak" := HREmp."Second Language Speak";
            "Second Language Write" := HREmp."Second Language Write";
            "Date Of Birth" := HREmp."Date Of Birth";
            Validate("Date Of Birth");

            //Insert Qualfications
            HRAppQual.Reset;
            HRAppQual.SetRange(HRAppQual."Application No", "Job Application No.");
            if HRAppQual.Find('-') then begin

            end else begin

            end;
        end;
    end;

    //ADDED PROCEDURES FOR AUTOMATIC EMAIL RESPONSES
    local procedure SendApplicationReceivedEmail()
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        CompInfo: Record "Company Information";
    begin
        if "E-Mail" = '' then
            exit;
        
        if "Email Sent" then
            exit;
        
        CompInfo.Get();
        
        EmailBody := '<html><body>';
        EmailBody += '<p>Dear <b>' + "Full Name" + '</b>,</p>';
        EmailBody += '<p>Thank you for your application for the position of <b>' + "Job Applied for Description" + '</b>.</p>';
        EmailBody += '<p>We have received your application (Application No: <b>' + "Job Application No." + '</b>) and it is currently under review.</p>';
        EmailBody += '<p>We will contact you if your qualifications match our requirements.</p>';
        EmailBody += '<br><p>Best Regards,<br>' + CompInfo.Name + '</p>';
        EmailBody += '</body></html>';
        
        EmailMsg.Create("E-Mail", 'Application Received - ' + "Job Applied for Description", EmailBody, true);
        
        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
            "Email Sent" := true;
            "Sent Email" := true;
            Modify();
        end;
    end;

    local procedure SendShortlistedEmail()
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        CompInfo: Record "Company Information";
    begin
        if "E-Mail" = '' then
            exit;
        
        CompInfo.Get();
        
        EmailBody := '<html><body>';
        EmailBody += '<p>Dear <b>' + "Full Name" + '</b>,</p>';
        EmailBody += '<p>Congratulations! You have been shortlisted for the position of <b>' + "Job Applied for Description" + '</b>.</p>';
        EmailBody += '<p>Your Application No: <b>' + "Job Application No." + '</b></p>';
        EmailBody += '<p>We will contact you shortly with further details regarding the next steps in the recruitment process.</p>';
        EmailBody += '<br><p>Best Regards,<br>' + CompInfo.Name + '</p>';
        EmailBody += '</body></html>';
        
        EmailMsg.Create("E-Mail", 'Shortlisted - ' + "Job Applied for Description", EmailBody, true);
        
        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
            "Sent Email" := true;
            Modify();
        end;
    end;

    local procedure SendApprovedEmail()
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        CompInfo: Record "Company Information";
    begin
        if "E-Mail" = '' then
            exit;
        
        CompInfo.Get();
        
        EmailBody := '<html><body>';
        EmailBody += '<p>Dear <b>' + "Full Name" + '</b>,</p>';
        EmailBody += '<p>Congratulations! Your application for the position of <b>' + "Job Applied for Description" + '</b> has been approved.</p>';
        EmailBody += '<p>Your Application No: <b>' + "Job Application No." + '</b></p>';
        EmailBody += '<p>We will contact you shortly with further details regarding your employment.</p>';
        EmailBody += '<br><p>Best Regards,<br>' + CompInfo.Name + '</p>';
        EmailBody += '</body></html>';
        
        EmailMsg.Create("E-Mail", 'Application Approved - ' + "Job Applied for Description", EmailBody, true);
        
        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
            "Sent Email" := true;
            Modify();
        end;
    end;

    local procedure SendUnqualifiedEmail()
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        CompInfo: Record "Company Information";
    begin
        if "E-Mail" = '' then
            exit;
        
        CompInfo.Get();
        
        EmailBody := '<html><body>';
        EmailBody += '<p>Dear <b>' + "Full Name" + '</b>,</p>';
        EmailBody += '<p>Thank you for your interest in the position of <b>' + "Job Applied for Description" + '</b>.</p>';
        EmailBody += '<p>Your Application No: <b>' + "Job Application No." + '</b></p>';
        EmailBody += '<p>After careful consideration, we regret to inform you that we will not be proceeding with your application at this time.</p>';
        if "Rejection Reason" <> '' then
            EmailBody += '<p>Reason: ' + "Rejection Reason" + '</p>';
        EmailBody += '<p>We appreciate your interest in our organization and wish you success in your future endeavors.</p>';
        EmailBody += '<br><p>Best Regards,<br>' + CompInfo.Name + '</p>';
        EmailBody += '</body></html>';
        
        EmailMsg.Create("E-Mail", 'Application Status - ' + "Job Applied for Description", EmailBody, true);
        
        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
            "Sent Email" := true;
            Modify();
        end;
    end;
}

