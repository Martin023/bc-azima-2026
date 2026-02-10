#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186003 "Membership Declaration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Membership Declaration.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";

            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(IDNo_Members; Members."Primary Identification")
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(PrintedAt; PrintedAt)
            {
            }
            column(MembersDOB; MembersDOB)
            {
            }
            dataitem("Next of KIN"; "Next of KIN")
            {
                DataItemLink = "Record ID" = field("No.");
                //DataItemTableView = where(Beneficiary=const(Yes),Deceased=const(No),Type=const("Benevolent Beneficiary"));
                column(ReportForNavId_2; 2)
                {
                }
                column(Name_NextofKIN; "Next of KIN".Name)
                {
                }
                column(Relationship_NextofKIN; "Next of KIN".Relationship)
                {
                }
                column(Beneficiary_NextofKIN; "Next of KIN"."Is a Beneficiary")
                {
                }

                column(IDNo_NextofKIN; "Next of KIN".Identification)
                {
                }
                column(DateOfBirth; DateOfBirth)
                {
                }
                column(BBFEnt; BBFEnt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DateOfBirth := '';

                    if "Next of KIN"."Date of Birth" <> 0D then
                        //DateOfBirth := SkyHarambeePortal.FormatDate("Next of KIN"."Date of Birth");
                        BBFEntitlement.Reset;
                    // if BBFEntitlement.FindFirst then BBFEnt := BBFEntitlement.Description;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NextofKIN.Reset;
                NextofKIN.SetRange("Record ID", Members."No.");
                NextofKIN.SetRange(Deceased, false);
                NextofKIN.SetRange("Is a Beneficiary", true);
                if not NextofKIN.FindFirst then CurrReport.Skip;

                //MembersDOB := SkyHarambeePortal.FormatDate(Members."Date of Birth");
            end;

            trigger OnPreDataItem()
            begin
                PrintedBy := CopyStr(UserId, StrPos(UserId, '\') + 1, StrLen(UserId));
                //PrintedAt := SkyHarambeePortal.FormatDateTimeReverse(CurrentDatetime);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DateOfBirth: Text;
        //SkyHarambeePortal: Codeunit "Sky Harambee Portal";
        NextofKIN: Record "Next of KIN";
        BBFEnt: Text;
        BBFEntitlement: Record "BBF Entitlement";
        MembersDOB: Text;
        PrintedBy: Code[50];
        PrintedAt: Text;
}
