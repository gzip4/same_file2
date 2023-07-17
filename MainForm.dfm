object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Same File'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    635
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object RescanButton: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Rescan'
    Default = True
    TabOrder = 0
    OnClick = RescanButtonClick
  end
  object FilesListView1: TListView
    Left = 8
    Top = 39
    Width = 619
    Height = 252
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        AutoSize = True
        Caption = 'Filename'
        MinWidth = 256
      end
      item
        AutoSize = True
        Caption = 'Size'
        MaxWidth = 100
        MinWidth = 64
      end
      item
        AutoSize = True
        Caption = 'SHA256'
        MaxWidth = 512
        MinWidth = 400
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = FilesListView1DblClick
  end
  object DirectoryEdit: TEdit
    Left = 168
    Top = 8
    Width = 459
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'DirectoryEdit'
  end
  object DirButton: TButton
    Left = 96
    Top = 8
    Width = 66
    Height = 25
    Caption = 'Dir...'
    TabOrder = 3
    OnClick = DirButtonClick
  end
end
