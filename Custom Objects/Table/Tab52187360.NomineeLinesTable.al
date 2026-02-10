table 52187360 "Nominee Lines Table"
{
    Caption = 'Nominee Lines Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation =  "Nominee Legal";
        }
        field(2; "Nominee Name"; Text[50])
        {
            Caption = 'Nominee Name';
            TableRelation =  "Next of KIN";
            
            // trigger OnValidate()
            // begin
            //     if ("Nominee Name" <> '') then
            //         begin
            //             NextofKIN.SetRange("Name", "Nominee Name");
            //             NextofKIN.SetRange("Is Nominee", true);
            //             NextofKIN.SetRange("Record ID", NomineeLegal."Member No.");
            //             NextofKIN.FindFirst();
            //             if NextofKin."Is Nominee" = true then
            //             begin
            //                 if NextofKIN.FindFirst then
            //                 repeat
            //                 NextofKIN.init();   
            //                 NextofKIN.Insert();
            //                 "Nominee Name" := NextofKIN."Name";
            //                 Allocation := NextofKIN."Allocation";
            //                 Removed := NextofKIN."Removed";
            //                 Deceased := NextofKIN."Deceased";
            //                 until NextofKIN.Next = 0;   
            //             end;
            //         end;
            // end;
        }
        field(3; Allocation; Decimal)
        {
            Caption = 'Allocation';
        }
        field(4; Removed; Boolean)
        {
            Caption = 'Updated';
        }
        field(5; Deceased; Boolean)
        {
            Caption = 'Deceased';
        }
        field(6; "Nominee Identification"; Code [20]){}
    }
    keys
    {
        key(PK; "No.", "Nominee Identification")
        {
            Clustered = true;
        }
    }
    var
    NomineeLegal: Record "Nominee Legal";
    NextofKIN: Record "Next of KIN";
}
