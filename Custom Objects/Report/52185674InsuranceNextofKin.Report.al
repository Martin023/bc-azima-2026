#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185674 "Insurance Next of Kin"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Insurance Next of Kin.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Child1; Child1)
            {
            }
            column(Child2; Child2)
            {
            }
            column(Child3; Child3)
            {
            }
            column(Child4; Child4)
            {
            }
            column(Spouse; Spouse)
            {
            }
            column(Parent1; Parent1)
            {
            }
            column(Parent2; Parent2)
            {
            }
            column(No_Members; Members."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                NextofKIN.Reset;
                NextofKIN.SetRange("Record ID", Members."No.");
                if NextofKIN.FindFirst then begin
                    if NextofKIN.Relationship = 'CHILD-1  Beneficiary' then begin
                        Child1 := NextofKIN.Name;
                    end;

                    /* ELSE


                  IF NextofKIN.Relationship='CHILD-2  Beneficiary' THEN BEGIN
                    Child2:=NextofKIN.Name;
                    END ELSE


                  IF NextofKIN.Relationship='CHILD-3  Beneficiary' THEN BEGIN
                    Child3:=NextofKIN.Name;
                    END ELSE

                  IF NextofKIN.Relationship='CHILD-4  Beneficiary' THEN BEGIN
                    Child4:=NextofKIN.Name;
                    END ELSE

                  IF NextofKIN.Relationship='SPOUSE' THEN BEGIN
                     Spouse:=NextofKIN.Name;
                    END;
                    */
                end;

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
        Child1: Text;
        Child2: Text;
        Child3: Text;
        Child4: Text;
        Spouse: Text;
        Parent1: Text;
        Parent2: Text;
        NextofKIN: Record "Next of KIN";
}
