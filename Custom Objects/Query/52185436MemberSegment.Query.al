Query 52185436 MemberSegment
{

    elements
    {
        dataitem(segments_; "Segment/County/Dividend/Signat")
        {
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            filter(Type; Type)
            {
                ColumnFilter = Type = const(Segment);
            }
        }
    }
}
