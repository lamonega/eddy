{$mode objfpc}{$H+}
program eddy;

uses
    Classes, SysUtils;

procedure loadFile (f: string);
begin
    if not FileExists(f) then
    begin
        WriteLn('Error: File does not exist.');
        Halt(1);
    end;
end;

function checkEmptyFile (f: string; b: TStringList): integer;
begin
    b.LoadFromFile(f);
    checkEmptyFile := b.Count;
end;

function checkValidInputAndReturn(lc: integer): integer;
var
    input_str: string;
    valid_input: boolean;
    line_to_edit, error_code: integer;
begin
    valid_input := false;
        repeat
            Write('Enter line number to edit (1 to ', lc, '): ');
            ReadLn(input_str);
            
            input_str := Trim(input_str);
            Val(input_str, line_to_edit, error_code);
            
            if error_code <> 0 then
            begin
                WriteLn('Error: Please enter a valid number.');
            end
            else if (line_to_edit < 1) or (line_to_edit > lc) then
            begin
                WriteLn('Error: Line number must be between 1 and ', lc, '.');
            end
            else
            begin
                valid_input := true;
            end;
        until valid_input;
    checkValidInputAndReturn := line_to_edit;
end;

procedure printFileContents(b: TStringList);
begin
    WriteLn('File content:');
        Write(b.Text);
        WriteLn('Total lines: ', b.Count);
        WriteLn;
end;

procedure editFile(var b: TStringList; ln: integer; fn: string);
var
    l: string;
begin
        WriteLn('Enter new content for line ', ln, ': ');
        ReadLn(l);
        b[ln - 1] := l;
        b.SaveToFile(fn);
end;

var
    buffer: TStringList;
begin
    if ParamCount < 1 then
    begin
        WriteLn('Usage: eddy <filename>');
        WriteLn('Example: eddy document.txt');
        Halt(1);
    end;
    loadFile(ParamStr(1));

    buffer:= TStringList.Create;
    try
        if checkEmptyFile(ParamStr(1), buffer) = 0 then
        begin
            WriteLn('Error: File is empty. No lines to edit.');
            Exit;
        end;
        
        printFileContents(buffer);
        
        editFile(buffer, checkValidInputAndReturn(buffer.Count), ParamStr(1));
        
        WriteLn;
        WriteLn('File saved successfully!');
    except
        on E: EFOpenError do
            WriteLn('Error: Cannot open file - ', E.Message);
        on E: EInOutError do
            WriteLn('Error: I/O error - ', E.Message);
        on E: Exception do
            WriteLn('Error: ', E.Message);
    end;
    
    buffer.Free;
end.