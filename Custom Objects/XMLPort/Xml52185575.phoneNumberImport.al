xmlport 52185575 phoneNumberImport
{
    Caption = 'Import Phone Numbers';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MemberRec; "Members")
            {
                AutoSave = true;
                XmlName = 'Member';

                fieldelement(PhoneNumber; MemberRec."Phone No.")
                {
                    XmlName = 'PhoneNumber';
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}