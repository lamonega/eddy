program eddy;
var
    f: TextFile;
    buffer, file_name, a_single_line, line_to_add, new_buffer: string;
    line_to_edit, current_line: integer;
begin
    WriteLn('Enter file name: ');
    ReadLn(file_name);
    
    Assign(f, file_name);
    Reset(f);
    buffer := '';
    
    while not Eof(f) do
    begin
        ReadLn(f, a_single_line);
        buffer := buffer + a_single_line + LineEnding;
    end;
    Close(f);
    
    WriteLn('File content:');
    Write(buffer);
    WriteLn;
    
    WriteLn('Enter line number to edit (starting from 1): ');
    ReadLn(line_to_edit);
    WriteLn('Enter new content for line ', line_to_edit, ': ');
    ReadLn(line_to_add);
    
    Assign(f, file_name);
    Reset(f);
    
    new_buffer := '';
    current_line := 1;
    
    while not Eof(f) do
    begin
        ReadLn(f, a_single_line);
        
        if current_line = line_to_edit then
            new_buffer := new_buffer + line_to_add + LineEnding
        else
            new_buffer := new_buffer + a_single_line + LineEnding;
            
        current_line := current_line + 1;
    end;
    Close(f);
    
    Assign(f, file_name);
    Rewrite(f);
    Write(f, new_buffer);
    Close(f);
    
    WriteLn;
    WriteLn('File saved successfully!');
end.