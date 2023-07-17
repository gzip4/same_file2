unit SameFileScan;

interface

uses System.Generics.Collections;

type
  TFileInfo = record
    Filename: string;
    Hash: string;
    Filesize: string;
  end;

  TFileInfoList = TList<TFileInfo>;

function ScanDirectory(Path: string): TFileInfoList;

implementation

uses
  SysUtils, System.Classes, System.Hash;

function ScanDirectory(Path: string): TFileInfoList;
type
  TFileSize = Int64;
  TFileNames = TStringList;
var
  FileInfo: TFileInfo;
  Rec: TSearchRec;
  Dir: string;
  TempFiles: TDictionary<TFileSize, TFileNames>;
  Names: TFileNames;
  Filesize: TFileSize;
  I: Integer;
begin
  Result := TFileInfoList.Create;
  Dir := ExtractFileDir(Path);

  TempFiles := TDictionary<TFileSize, TFileNames>.Create;
  try
    if FindFirst(Dir + '\*', faAnyFile, Rec) = 0 then
      try
        repeat
          if (Rec.Name = '.') or (Rec.Name = '..') then
            continue;
          if (Rec.Attr and faVolumeID) = faVolumeID then
            continue; // nothing useful to do with volume IDs
          if (Rec.Attr and faHidden) = faHidden then
            continue; // honor the OS "hidden" setting
          if (Rec.Attr and faDirectory) = faDirectory then
            continue; // This is a directory. Might want to do something special.

          if Rec.Size = 0 then
            continue;

          if TempFiles.TryGetValue(Rec.Size, Names) then
            Names.Add(Rec.Name)
          else
          begin
            Names := TStringList.Create;
            Names.Add(Rec.Name);
            TempFiles.Add(Rec.Size, Names)
          end;

        until FindNext(Rec) <> 0;
      finally
        FindClose(Rec);
      end;

    for Filesize in TempFiles.Keys do
    begin
      Names := TempFiles.Items[Filesize];
      if Names.Count > 1 then // two or more files with same size
      begin
        for I := 0 to Names.Count - 1 do
        begin
          FileInfo.Filename := Names[I];
          FileInfo.Filesize := IntToStr(Filesize);
          try
            FileInfo.Hash := THashSHA2.GetHashStringFromFile
              (Dir + '\' + FileInfo.Filename);
          except
            FileInfo.Hash := 'cannot open file';
          end;
          Result.Add(FileInfo);
        end;
      end;
    end;
  finally
    for Names in TempFiles.Values do
      Names.Free;
    TempFiles.Free;
  end;
end;

end.
