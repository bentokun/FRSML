unit nmmintrin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TArr1Single = array[0..3] of Single;

  //Work like C++ header. Damn!
  //Also, unaligned.
  //You dont need asm knowledge to understand the code
  //Must say that intel asm is the easiest asm i have learned

  floatp4 = class(TObject)
     private
        mainPack: TArr1Single;

    public

        class constructor Create;

        property ps: TArr1Single read mainPack write mainPack;

        constructor v2(a,b,c,d: single);

        property n0: single read mainPack[0] write mainPack[0];
        property n1: single read mainPack[1] write mainPack[1];
        property n2: single read mainPack[2] write mainPack[2];
        property n3: single read mainPack[3] write mainPack[3];

  end;

function set_floatp4(a,b,c,d: single): floatp4;
operator + (para1, para2: floatp4) add: floatp4;
operator - (para1, para2: floatp4) sub: floatp4;
operator * (para1, para2: floatp4) mul: floatp4;
operator / (para1, para2: floatp4) divide: floatp4;

implementation

              function set_floatp4(a,b,c,d: single): floatp4;
              begin
                   set_floatp4:= floatp4.v2(a,b,c,d);
              end;

              //Gag will see this is an Intel asm
              operator + (para1, para2: floatp4) add: floatp4;
              var t1, t2, t3: TArr1Single;
              begin
                   add:= floatp4.Create;
                   t1:= para1.ps;
                   t2:= para2.ps;

                   asm
                      movups xmm0, [t1]
                      movups xmm1, [t2]
                      addps xmm0, xmm1
                      movups [t3], xmm0
                   end;

                   add.ps := t3;
              end;

              operator - (para1, para2: floatp4) sub: floatp4;
              var t1, t2, t3: TArr1Single;
              begin
                   sub:= floatp4.Create;
                   t1:= para1.ps;
                   t2:= para2.ps;

                   asm
                      movups xmm0, [t1]
                      movups xmm1, [t2]
                      subps xmm0, xmm1
                      movups [t3], xmm0
                   end;

                   sub.ps := t3;
              end;

            operator * (para1, para2: floatp4) mul: floatp4;
            var t1, t2, t3: TArr1Single;
            begin
                 mul:= floatp4.Create;
                 t1:= para1.ps;
                 t2:= para2.ps;

                 asm
                    movups xmm0, [t1]
                    movups xmm1, [t2]
                    mulps xmm0, xmm1
                    movups [t3], xmm0
                 end;

                 mul.ps := t3;
            end;

            operator / (para1, para2: floatp4) divide: floatp4;
            var t1, t2, t3: TArr1Single;
            begin
                 divide:= floatp4.Create;
                 t1:= para1.ps;
                 t2:= para2.ps;

                 asm
                    movups xmm0, [t1]
                    movups xmm1, [t2]
                    divps xmm0, xmm1
                    movups [t3], xmm0
                 end;

                 divide.ps := t3;
            end;

              constructor floatp4.v2(a,b,c,d: single);
              begin
                   mainPack[3]:= a;
                   mainPack[2]:= b;
                   mainPack[1]:= c;
                   mainPack[0]:= d;
              end;

              class constructor floatp4.Create;
              begin
                   Create.mainPack[0] := 0;
                   Create.mainPack[1] := 0;
                   Create.mainPack[2] := 0;
                   Create.mainPack[3] := 0;
              end;


end.
