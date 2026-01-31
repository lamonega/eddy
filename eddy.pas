{$mode objfpc}{$H+}
program eddy;

uses
    Classes, SysUtils;

var
    file_name, line_to_add, input_str: string;
    line_to_edit, error_code: integer;
    buffer: TStringList;
    valid_input: boolean;
begin
    if ParamCount < 1 then
    begin
        WriteLn('Usage:', ParamStr(0), ' <filename>');
        WriteLn('Example: ', ParamStr(0), ' document.txt');
        Halt(1);
    end;

    file_name := ParamStr(1);
    
    if not FileExists(file_name) then
    begin
        WriteLn('Error: File does not exist.');
        Halt(1);
    end;
    
    buffer := TStringList.Create;
    try
        buffer.LoadFromFile(file_name);
        
        if buffer.Count = 0 then
        begin
            WriteLn('Error: File is empty. No lines to edit.');
            Exit;
        end;
        
        WriteLn('File content:');
        Write(buffer.Text);
        WriteLn('Total lines: ', buffer.Count);
        WriteLn;
        
        valid_input := false;
        repeat
            Write('Enter line number to edit (1 to ', buffer.Count, '): ');
            ReadLn(input_str);
            
            input_str := Trim(input_str);
            Val(input_str, line_to_edit, error_code);
            
            if error_code <> 0 then
            begin
                WriteLn('Error: Please enter a valid number.');
            end
            else if (line_to_edit < 1) or (line_to_edit > buffer.Count) then
            begin
                WriteLn('Error: Line number must be between 1 and ', buffer.Count, '.');
            end
            else
            begin
                valid_input := true;
            end;
        until valid_input;
        
        WriteLn('Enter new content for line ', line_to_edit, ': ');
        ReadLn(line_to_add);
        
        buffer[line_to_edit - 1] := line_to_add;
        buffer.SaveToFile(file_name);
        
        WriteLn;
        WriteLn('File saved successfully!');
    except
        on E: Exception do
        begin
            WriteLn('Error: ', E.Message);
            Exit;
        end;
    end;
    
    buffer.Free;
end.