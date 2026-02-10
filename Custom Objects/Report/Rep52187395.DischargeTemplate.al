report 52187395 "Discharge Template"
{
    ApplicationArea = All;
    Caption = 'Discharge Template';
    // UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-kenpipe-2024/Layout/Discharge Template.docx';
    dataset
    {
        //dataitem(SecurityPerfection; "Security Perfection")
        dataitem(CollateralCollection; "Securities Collection Register")
        {
            // column(AmountToCharge; "Amount To Charge")
            // {
            // }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            // column(DateofRegistration; "Date of External Registration")
            // {
            // }
            // column(PropertyNumber; "Property Number")
            // {
            // }
            // column(Discharge_Date; "Discharge Date")
            // {
            // }
            dataitem(Members; Members)
            {
                DataItemLink = "No." = FIELD("Member No.");
                column(MembersNo; "No.")
                {
                }
                column(Primary_Identification_Type; "Primary Identification Type")
                {
                }
                column(Primary_Identification_Number; "Primary Identification")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Primary_Identification_Type := Primary_Identification_Type::" ";
                    Primary_Identification_Number := '';


                    if Members.Get("No.") then begin
                        Primary_Identification_Type := Members."Primary Identification Type";
                        Primary_Identification_Number := Members."Primary Identification";
                    end;
                end;
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    Var
        Primary_Identification_Type: Enum "Identification Type";
        Primary_Identification_Number: Text[50];
}
