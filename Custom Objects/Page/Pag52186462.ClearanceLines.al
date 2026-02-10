namespace ALProject.ALProject;
using System.Security.User;

page 52186462 "Clearance Lines"
{
    Caption = 'Clearance Lines';
    PageType = ListPart;
    SourceTable = "Clearance Lines";

    layout
    {
        area(content)
        {
            Repeater(General)
            {

                field("Responsibility Centre"; Rec."Responsibility Centre")
                {

                }
                field(Liabilities; Rec.Liabilities)
                {

                }
                field("Company Assets"; rec."Company Assets")
                {

                }
                field(Name; Rec.Name)
                {

                }
                field(Designation; Rec.Designation)
                {

                }
                field(Date9; Rec.Date9)
                {
                    Caption = 'Date';
                }
                field(Comments; Rec.Comments)
                {

                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
       


    end;





    procedure fnLastLineNo() LastLineNo: Integer
    var

    begin
        ClearanceLines.Reset;
        if ClearanceLines.FindLast then begin
            LastLineNo := ClearanceLines."Line No.";
        end else begin
            LastLineNo := 1;
        end;
    end;


    var
        Usersetup: record "User Setup";
        ResponsibilityCentre: record "Responsibility CenterBR";
        ClearanceHeader: record "Clearance Form";
        ClearanceLines: record "Clearance Lines";
        HrEmp: Record "HR Employees";

}
