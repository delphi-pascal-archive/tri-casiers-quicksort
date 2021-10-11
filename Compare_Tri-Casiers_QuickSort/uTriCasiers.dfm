object frmTriK: TfrmTriK
  Left = 229
  Top = 125
  Width = 761
  Height = 675
  Caption = 'Compare Tri-Casiers and QuickSort'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 616
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 15
      Top = 21
      Width = 278
      Height = 241
      Caption = ' Tri Entiers >= 0  (LongWord) '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object btnTriCasiers: TSpeedButton
        Left = 20
        Top = 118
        Width = 248
        Height = 26
        Caption = 'Cr'#1081'er tableau + Tri_Casiers'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTriCasiersClick
      end
      object btnQuickSortRecursif: TSpeedButton
        Left = 20
        Top = 151
        Width = 248
        Height = 26
        Caption = 'Cr'#1081'er tableau + QuickSortRecursif'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnQuickSortRecursifClick
      end
      object Label3: TLabel
        Left = 21
        Top = 82
        Width = 97
        Height = 16
        Caption = 'Valeur Plafond : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 21
        Top = 55
        Width = 121
        Height = 16
        Hint = 'Nombre de valeurs  du tableau'
        Caption = 'Nombre de valeurs :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 15
        Top = 30
        Width = 144
        Height = 16
        Caption = 'Tableau de valeurs :'
      end
      object bCreerTableauQuickSortIteratif: TSpeedButton
        Left = 20
        Top = 187
        Width = 248
        Height = 26
        Caption = 'Cr'#1081'er tableau + QuickSortIteratif'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = bCreerTableauQuickSortIteratifClick
      end
      object edNbValLongWord: TEdit
        Left = 169
        Top = 49
        Width = 71
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '10000'
        OnChange = edNbValLongWordChange
      end
      object edValPlafond: TEdit
        Left = 169
        Top = 79
        Width = 71
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '10000'
        OnChange = edValPlafondChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 15
      Top = 326
      Width = 278
      Height = 278
      Caption = ' Tri de cha'#1086'nes (de texte al'#1081'atoire) : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object bCreerListeChainesPuisTrierCasiers: TSpeedButton
        Left = 20
        Top = 202
        Width = 248
        Height = 26
        Caption = 'Cr'#1081'er liste + Tri_Casiers'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = bCreerListeChainesPuisTrierCasiersClick
      end
      object bCreerListePuisQuickSortRecursif: TSpeedButton
        Left = 20
        Top = 236
        Width = 248
        Height = 26
        Caption = 'Cr'#1081'er liste + QuickSortRecursif'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = bCreerListePuisQuickSortRecursifClick
      end
      object Label7: TLabel
        Left = 21
        Top = 84
        Width = 138
        Height = 16
        Caption = 'Longueur max cha'#1086'ne :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 21
        Top = 55
        Width = 129
        Height = 16
        Caption = 'Nombre de cha'#1086'nes :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 15
        Top = 30
        Width = 127
        Height = 16
        Caption = 'Liste de cha'#1086'nes :'
      end
      object Label10: TLabel
        Left = 21
        Top = 170
        Width = 165
        Height = 16
        Caption = 'Profondeur Max du Tri : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edNbChaines: TEdit
        Left = 174
        Top = 49
        Width = 71
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '20'
        OnChange = edNbChainesChange
      end
      object edLongueurChaine: TEdit
        Left = 174
        Top = 79
        Width = 71
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '15'
        OnChange = edLongueurChaineChange
      end
      object edProfMaxTri: TEdit
        Left = 193
        Top = 166
        Width = 72
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '15'
        OnChange = edLongueurChaineChange
      end
      object rbLongConstante: TRadioButton
        Left = 25
        Top = 113
        Width = 231
        Height = 16
        Caption = 'Cha'#1086'nes de Longueur constante'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = True
      end
      object rbLongVariable: TRadioButton
        Left = 25
        Top = 137
        Width = 222
        Height = 16
        Caption = 'Longueur al'#1081'toire de 1 '#1072'  Lg max'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  object ckBoxAfficherTableaux: TCheckBox
    Left = 315
    Top = 15
    Width = 255
    Height = 21
    Caption = 'Afficher tableaux (pour petits tableaux)'
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 305
    Top = 44
    Width = 213
    Height = 566
    Caption = 'Panel2'
    TabOrder = 2
    DesignSize = (
      213
      566)
    object Label1: TLabel
      Left = 10
      Top = 4
      Width = 87
      Height = 16
      Caption = 'Tableau '#1072' trier'
    end
    object labCountNonTrie: TLabel
      Left = 10
      Top = 23
      Width = 4
      Height = 16
      Caption = '-'
    end
    object ListBox1: TListBox
      Left = 10
      Top = 55
      Width = 197
      Height = 505
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 532
    Top = 44
    Width = 218
    Height = 566
    Caption = 'Panel3'
    TabOrder = 3
    DesignSize = (
      218
      566)
    object Label2: TLabel
      Left = 10
      Top = 4
      Width = 81
      Height = 16
      Caption = 'Tableau tri'#1081' : '
    end
    object labCountTrie: TLabel
      Left = 10
      Top = 23
      Width = 4
      Height = 16
      Caption = '-'
    end
    object ckBoxDecroissant: TCheckBox
      Left = 100
      Top = 4
      Width = 98
      Height = 21
      Caption = 'D'#1081'croissant'
      TabOrder = 0
    end
    object ListBox2: TListBox
      Left = 10
      Top = 55
      Width = 197
      Height = 505
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 616
    Width = 753
    Height = 31
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      753
      31)
    object Label11: TLabel
      Left = 319
      Top = 6
      Width = 62
      Height = 16
      Caption = 'Chrono : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edMemDispo: TEdit
      Left = 21
      Top = 6
      Width = 258
      Height = 20
      BorderStyle = bsNone
      TabOrder = 0
      Text = 'edMemDispo'
    end
    object edChrono: TEdit
      Left = 385
      Top = 6
      Width = 359
      Height = 19
      Hint = 
        'Chrono : Hors dur'#1081'e de cr'#1081'ation de la liste, et hors dur'#1081'e d'#39'aff' +
        'ichage  '#1081'ventuel'
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'edChrono'
    end
  end
end
