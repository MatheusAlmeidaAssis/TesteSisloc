object Frm_TesteSisloc: TFrm_TesteSisloc
  Left = 0
  Top = 0
  Caption = 'Teste Sisloc'
  ClientHeight = 208
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Btn_Exercicio1: TButton
    Left = 96
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Exerc'#237'cio 1'
    TabOrder = 0
    OnClick = Btn_Exercicio1Click
  end
  object Btn_QuestaoD: TButton
    Left = 96
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Quest'#227'o D'
    TabOrder = 1
    OnClick = Btn_QuestaoDClick
  end
  object Btn_QuestaoE: TButton
    Left = 96
    Top = 134
    Width = 75
    Height = 25
    Caption = 'Quest'#227'o E'
    TabOrder = 2
    OnClick = Btn_QuestaoEClick
  end
  object Con_Principal: TFDConnection
    Params.Strings = (
      'Database=TesteSisloc'
      'User_Name=sa'
      'Password=20m03B15e@'
      'Server=DESKTOP-7IPRI15'
      'DriverID=MSSQL')
    Connected = True
    Left = 8
    Top = 8
  end
  object Qry_Exec: TFDQuery
    Connection = Con_Principal
    Left = 8
    Top = 64
  end
  object fdphysmsqldrvrlnk1: TFDPhysMSSQLDriverLink
    Left = 104
    Top = 8
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 8
    Top = 128
  end
end
