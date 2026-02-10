TableExtension 52186446 exitarticles extends "Misc. Article Information"
{
    fields
    {
        field(50001; "Employee Number"; code[50])

        {
            TableRelation = "HR Employees"."No.";

        }
        modify("Employee No.")
        {
            TableRelation="HR Employees"."No.";
        }

    }
}