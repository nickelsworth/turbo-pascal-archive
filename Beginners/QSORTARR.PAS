
Program SortArray;
Uses Objects;

const
   N = 4; { ���-�� ������⮢ � ���ᨢ� }
   SORT_STR: boolean = true;

type
   PInteger = ^Integer;

   List = array[1..N] of Pointer; { ᯨ᮪ 㪠��⥫�� �� �祩�� ������ }

   { ��楤��� ⨯ ��� �맮�� �㭪樨 �ࠢ����� }
   TSortFunc = function (a,b: pointer): integer;

var
  Data: List;

{$I sortfunc.inc} { ������砥� �������⥫�� ��� - �㭪�� StrCmp }

{ ����� 㪠�뢠�� ��� �㤥� ���஢��� �����.
  ����� ��� �ࠢ����� ��।�� � ����⢥ 㪠��⥫��, ��� � ��ப�,
  �᫠, ��� ���� �������� ������ ⨯� ������ }

function CompareNumbers (a,b: pointer): integer; FAR; { ���쭨� ⨯ �裡 }
begin
     if PInteger (a)^ > PInteger (b)^ then
        CompareNumbers := 1
     else
        if PInteger (a)^ = PInteger (b)^ then
           CompareNumbers := 0
        else
           CompareNumbers := -1
end;

function CompareStrings (a,b: pointer): integer; FAR;
begin
     CompareStrings := strcmp (PString (a)^, PString (b)^)
end;

procedure QuickSort (var A: List; SortFunc: TSortFunc; Lo, Hi: Integer);
{ "������ ���஢��". ����� �ਬ����� �� ��㣮� ��� ���஢�� }
var
  i,j: integer;
  x, y: pointer;

procedure Sort (l, r: Integer);
begin
     repeat
           x := A[(l+r) div 2];
           i := l; j := r;
           repeat
                 while SortFunc (A[i], x) < 0 do inc (i);
                 while SortFunc (A[j], x) > 0 do dec (j);
                 if i <= j then
                 begin
                      y := A[i]; A[i] := A[j]; A[j] := y; { �������� 㪠��⥫� ���⠬� }
                      inc (i);
                      dec (j);
                 end;
           until i > j;

           if l < j then Sort (l, j);
           l := i;
     until l >= r;
end;

begin
      Sort (Lo,Hi);
end;

procedure Input_Array;
var
  i: Integer;
  S: string;
  Num: PInteger;

begin
     Randomize; { ���樠������ ������� ��砩��� �ᥫ }
     writeln (#13#10'*** Data input ***'#13#10);
     if SORT_STR then
     for i := 1 to N do
     begin
          write ('Enter string: ');
          readln (s);
          Data[i] := pointer (NewStr (s)); { १�ࢨ�㥬 ������ ��� ��ப� }
     end
     else
     for i := 1 to N do
     begin
          New (Num); { १�ࢨ�㥬 ������ ��� �᫠ }
          Num^ := random (100); { ��砩�� �᫠ }
          Data[i] := Num;
     end;
end;

procedure View_Array;
var
  i: Integer;
begin
     writeln (#13#10'*** Data output ***'#13#10);

     if SORT_STR then
     for i := 1 to N do
     begin
          writeln (PString (Data[i])^); { �뢮� ��ப� }
          DisposeStr (PString (Data[i]));
           { �᢮������� ������, ������ ��� �᫠ }
     end
     else
     for i := 1 to N do
     begin
          write (PInteger (Data[i])^ : 4); { �뢮� �᫠ }
          Dispose (Data[i]);
           { �᢮������� ������, ������ ��� ��ப� }
     end;

     readln;
end;

begin
     Input_Array; { ���� ������ }

     { �맮� ��楤��� ���஢�� }
     if SORT_STR then
        QuickSort (Data, CompareStrings, 1, N)
         { ����㥬 ���ᨢ ��ப }
     else
        QuickSort (Data, CompareNumbers, 1, N);
         { ����㥬 ���ᨢ �ᥫ }

     View_Array; { �뢮� ������ }
end.