program eddy;
uses
    Classes, SysUtils;

var
    file_name, line_to_add, input_str: string;
    line_to_edit, error_code: integer;
    buffer: TStringList;
    valid_input: boolean;
begin
    WriteLn('Enter file name: ');
    ReadLn(file_name);
    
    if not FileExists(file_name) then
    begin
        WriteLn('Error: File does not exist.');
        Halt(1);
    end;
    
    buffer := TStringList.Create;
    buffer.LoadFromFile(file_name);
    
    WriteLn('File content:');
    Write(buffer.Text);
    WriteLn('Total lines: ', buffer.Count);
    WriteLn;
    
    valid_input := false;
    repeat
        Write('Enter line number to edit (1 to ', buffer.Count, '): ');
        ReadLn(input_str);
        
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
    buffer.Free;
    
    WriteLn;
    WriteLn('File saved successfully!');
end.