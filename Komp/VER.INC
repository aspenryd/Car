{
 This file creates some additional defines according to the current version of
 Delphi / C-builder to ease conditional compilation where some versions of the
 compiler deviates in implementation.
 * If a feature is present up to (and including) version XX, use
   the defined constant "XX_AND_DOWN"
 * If a feature is available starting with XX and onwards, use the defined
   constant "XX_AND_UP"
 * When adding a new version, the following rules should be followed:
   1. Add defines for "XX_AND_DOWN" for this and all previous versions and all
      following versions
   2. Add defines for  "XX_AND_UP" for this and all previous versions
   3. Add "XX_AND_DOWN" to all previous defines, where "XX" is the new version

}

{$IFDEF VER80 }   // Delphi 1
  {$DEFINE D1_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF }
{$IFDEF VER90 }   // Delphi 2
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF }
{$IFDEF VER93 }   // CBuilder 1
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF }
{$IFDEF VER100 }  // Delphi 3
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF}

{$IFDEF VER110 }  // CBuilder 3
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF}
{$IFDEF VER120 }  // Delphi 4
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}
  {$DEFINE D4_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF}

{$IFDEF VER130 }  // Delphi 5
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}
  {$DEFINE D4_AND_UP}
  {$DEFINE D5_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
{$ENDIF}

{$IFDEF VER140 }  // Delphi 6
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}
  {$DEFINE D4_AND_UP}
  {$DEFINE D5_AND_UP}
  {$DEFINE D6_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
  {$DEFINE D6_AND_DOWN}
{$ENDIF}

{$IFDEF VER140 }  // Delphi 6
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}
  {$DEFINE D4_AND_UP}
  {$DEFINE D5_AND_UP}
  {$DEFINE D6_AND_UP}

{$ENDIF}


{$IFDEF VER150 }  // Delphi 7
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}
  {$DEFINE D4_AND_UP}
  {$DEFINE D5_AND_UP}
  {$DEFINE D6_AND_UP}

  {$DEFINE D1_AND_DOWN}
  {$DEFINE D2_AND_DOWN}
  {$DEFINE C1_AND_DOWN}
  {$DEFINE D3_AND_DOWN}
  {$DEFINE C3_AND_DOWN}
  {$DEFINE D4_AND_DOWN}
  {$DEFINE D5_AND_DOWN}
  {$DEFINE D6_AND_DOWN}
{$ENDIF}

{$IFDEF VER150 }  // Delphi 7
  {$DEFINE D1_AND_UP}
  {$DEFINE D2_AND_UP}
  {$DEFINE C1_AND_UP}
  {$DEFINE D3_AND_UP}
  {$DEFINE C3_AND_UP}
  {$DEFINE D4_AND_UP}
  {$DEFINE D5_AND_UP}
  {$DEFINE D6_AND_UP}

{$ENDIF}



