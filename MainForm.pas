unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    RescanButton: TButton;
    FilesListView1: TListView;
    DirectoryEdit: TEdit;
    DirButton: TButton;
    procedure RescanButtonClick(Sender: TObject);
    procedure DirButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FilesListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ShellApi, SameFileScan;

procedure TForm1.DirButtonClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(Self) do
    try
      Title := 'Select Directory';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
      OkButtonLabel := 'Select';
      DefaultFolder := DirectoryEdit.Text;
      FileName := DirectoryEdit.Text;
      if Execute then
        DirectoryEdit.Text := FileName;
    finally
      Free;
    end
end;

procedure TForm1.FilesListView1DblClick(Sender: TObject);
var
  F: string;
begin
  F := DirectoryEdit.Text + '\' + FilesListView1.ItemFocused.Caption;
  //ShowMessage(FilesListView1.ItemFocused.Caption);
  ShellExecute(Handle, 'open', PChar(F), nil, nil, SW_SHOW);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DirectoryEdit.Text := GetCurrentDir;
end;

procedure TForm1.RescanButtonClick(Sender: TObject);
var
  FileInfoList: TFileInfoList;
  Item: TListItem;
  I: Integer;
begin
  FileInfoList := ScanDirectory(DirectoryEdit.Text + '\');
  FilesListView1.Items.BeginUpdate;
  FilesListView1.Clear;
  try
    for I := 0 to FileInfoList.Count - 1 do
    begin
      Item := FilesListView1.Items.Add;
      Item.Caption := FileInfoList.Items[I].Filename;
      Item.SubItems.Add(FileInfoList.Items[I].Filesize);
      Item.SubItems.Add(FileInfoList.Items[I].Hash);
    end;
  finally
    FilesListView1.Items.EndUpdate;
    FileInfoList.Free;
  end;
end;

end.
