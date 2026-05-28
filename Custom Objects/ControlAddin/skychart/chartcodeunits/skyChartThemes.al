codeunit 52185439 "sky Chart Themes"
{
    procedure GetThemeColor(Theme: Text; Index: Integer): Text
    begin
        case LowerCase(Theme) of
            'default':
                exit(GetDefaultColor(Index));
            'pastel':
                exit(GetPastelColor(Index));
            'vibrant':
                exit(GetVibrantColor(Index));
            'corporate':
                exit(GetCorporateColor(Index));
            'earth':
                exit(GetEarthColor(Index));
            'ocean':
                exit(GetOceanColor(Index));
            'sunset':
                exit(GetSunsetColor(Index));
            'monochrome':
                exit(GetMonochromeColor(Index));
            else
                exit(GetDefaultColor(Index));
        end;
    end;

    procedure GetThemeColors(Theme: Text): List of [Text]
    var
        Colors: List of [Text];
        i: Integer;
    begin
        for i := 0 to 7 do
            Colors.Add(GetThemeColor(Theme, i));
        exit(Colors);
    end;

    local procedure GetDefaultColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(54,162,235,0.8)'); // Blue
            1:
                exit('rgba(255,99,132,0.8)'); // Red
            2:
                exit('rgba(75,192,192,0.8)'); // Green
            3:
                exit('rgba(255,159,64,0.8)'); // Orange
            4:
                exit('rgba(153,102,255,0.8)'); // Purple
            5:
                exit('rgba(255,205,86,0.8)'); // Yellow
            6:
                exit('rgba(0,188,212,0.8)'); // Teal
            7:
                exit('rgba(233,30,99,0.8)'); // Pink
        end;
    end;

    local procedure GetPastelColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(179,229,252,0.8)'); // Pastel Blue
            1:
                exit('rgba(255,204,203,0.8)'); // Pastel Red
            2:
                exit('rgba(200,247,197,0.8)'); // Pastel Green
            3:
                exit('rgba(255,224,178,0.8)'); // Pastel Orange
            4:
                exit('rgba(225,190,231,0.8)'); // Pastel Purple
            5:
                exit('rgba(255,245,157,0.8)'); // Pastel Yellow
            6:
                exit('rgba(178,235,242,0.8)'); // Pastel Teal
            7:
                exit('rgba(248,187,208,0.8)'); // Pastel Pink
        end;
    end;

    local procedure GetVibrantColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(0,123,255,0.8)'); // Vibrant Blue
            1:
                exit('rgba(220,53,69,0.8)'); // Vibrant Red
            2:
                exit('rgba(40,167,69,0.8)'); // Vibrant Green
            3:
                exit('rgba(253,126,20,0.8)'); // Vibrant Orange
            4:
                exit('rgba(111,66,193,0.8)'); // Vibrant Purple
            5:
                exit('rgba(255,193,7,0.8)'); // Vibrant Yellow
            6:
                exit('rgba(23,162,184,0.8)'); // Vibrant Teal
            7:
                exit('rgba(232,62,140,0.8)'); // Vibrant Pink
        end;
    end;

    local procedure GetCorporateColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(0,51,102,0.8)'); // Navy Blue
            1:
                exit('rgba(102,102,102,0.8)'); // Gray
            2:
                exit('rgba(0,102,68,0.8)'); // Forest Green
            3:
                exit('rgba(153,51,0,0.8)'); // Brown
            4:
                exit('rgba(51,51,102,0.8)'); // Dark Purple
            5:
                exit('rgba(153,102,0,0.8)'); // Gold
            6:
                exit('rgba(0,102,102,0.8)'); // Dark Teal
            7:
                exit('rgba(102,0,51,0.8)'); // Burgundy
        end;
    end;

    local procedure GetEarthColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(139,90,43,0.8)'); // Brown
            1:
                exit('rgba(107,142,35,0.8)'); // Olive Green
            2:
                exit('rgba(205,133,63,0.8)'); // Peru
            3:
                exit('rgba(160,82,45,0.8)'); // Sienna
            4:
                exit('rgba(85,107,47,0.8)'); // Dark Olive
            5:
                exit('rgba(210,180,140,0.8)'); // Tan
            6:
                exit('rgba(188,143,143,0.8)'); // Rosy Brown
            7:
                exit('rgba(112,128,144,0.8)'); // Slate Gray
        end;
    end;

    local procedure GetOceanColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(0,119,190,0.8)'); // Ocean Blue
            1:
                exit('rgba(0,150,136,0.8)'); // Teal
            2:
                exit('rgba(3,169,244,0.8)'); // Light Blue
            3:
                exit('rgba(0,188,212,0.8)'); // Cyan
            4:
                exit('rgba(63,81,181,0.8)'); // Indigo
            5:
                exit('rgba(33,150,243,0.8)'); // Blue
            6:
                exit('rgba(0,172,193,0.8)'); // Dark Cyan
            7:
                exit('rgba(96,125,139,0.8)'); // Blue Gray
        end;
    end;

    local procedure GetSunsetColor(Index: Integer): Text
    begin
        case Index mod 8 of
            0:
                exit('rgba(255,87,34,0.8)'); // Deep Orange
            1:
                exit('rgba(255,152,0,0.8)'); // Orange
            2:
                exit('rgba(255,193,7,0.8)'); // Amber
            3:
                exit('rgba(255,235,59,0.8)'); // Yellow
            4:
                exit('rgba(244,67,54,0.8)'); // Red
            5:
                exit('rgba(233,30,99,0.8)'); // Pink
            6:
                exit('rgba(156,39,176,0.8)'); // Purple
            7:
                exit('rgba(103,58,183,0.8)'); // Deep Purple
        end;
    end;

    local procedure GetMonochromeColor(Index: Integer): Text
    var
        Intensity: Integer;
    begin
        Intensity := 50 + (Index * 25);
        if Intensity > 255 then
            Intensity := 255;
        exit('rgba(' + Format(Intensity) + ',' + Format(Intensity) + ',' + Format(Intensity) + ',0.8)');
    end;
}
