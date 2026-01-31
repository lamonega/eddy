program eddy;
uses
    Classes, SysUtils;

var
    file_name, line_to_add: string;
    line_to_edit: integer;
    buffer: TStringList;
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
    WriteLn;
    
    WriteLn('Enter line number to edit (1 to ', buffer.Count, '): ');
    ReadLn(line_to_edit);
    
    if (line_to_edit < 1) or (line_to_edit > buffer.Count) then
    begin
        WriteLn('Error: Line number out of range.');
        buffer.Free;
        Halt(1);
    end;
    
    WriteLn('Enter new content for line ', line_to_edit, ': ');
    ReadLn(line_to_add);
    
    buffer[line_to_edit - 1] := line_to_add;
    
    buffer.SaveToFile(file_name);
    
    WriteLn;
    WriteLn('File saved successfully!');
    buffer.Free;
end.