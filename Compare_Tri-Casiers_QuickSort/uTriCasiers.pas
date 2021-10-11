unit uTriCasiers;

                               //************************************
                               //         TRI par CASIERS          //
                               //     Développé sous Delphi-5      //
                               //         Gilbert Geyer            //
                               //************************************

{ Principe du Tri par casiers ( bucket sort ) :
       Un tableau trié n'étant rien d'autre que la restitution, dans l'ordre d'apparition des occurrences des valeurs, du tableau non trié,
       ce tri procède en 3 à 4 étapes très simples (tri en temps linéaire) :
       - Si la valeur maxi de celles à trier est inconnue, on est obligé de la rechercher lors d'un premier parcours du tableau.
       - Par contre l'utilisation est optimimsée si on fournit en entrée cette valeur maxi ou une Valeur_Plafond (estimation) supérieure ou égale à ce maxi, et alors le tri se réduit aux 3 étapes suivantes :
       - on crée un tableau de comptage des Occurrences de taille au moins égale à Valeur_Plafond +1 dont les cases sont initialisées à zéro,
       - ensuite on parcourt le tableau à trier et pour chaque valeur 'va' on incrémente la case d'indice 'va' du tableau de comptage des Occurrences,
       - et enfin on restitue le tri en parcourant le tableau de comptage des Occurrences et dès qu'une case Occurrence[va] = n <> 0 on remplace les n premières valeurs du tableau à trier par la valeur 'va' correspondante
         et ainsi de suite avec les valeurs suivantes.

       Illustration du principe avec l'exemple de la table suivante à trier : 34,55,88,55,99,55
       - Dimensionnement du tableau de comptage 'nbOcc' des occurences : Maxi des valeurs = 99 donc SetLength(nbOcc,99)
       - Comptages : nbOcc(34)=1, nbOcc(55)=3, nbOcc(88)=1, nbOcc(99)=1
       - Restituition en ordre croissant : 1 fois 34 suivi de 3 fois 55 suivi de 1 fois 88 suivi de 1 fois 99 -> 34,55,55,55,88,99 = tableau trié

 A) TRI de VALEURS ENTIERES : Comparatif des performances du Tri_Casiers par rapport à QuickSort :

          Récapitulatif résultats de tests avec processeur Intel Core i7-2700K à 3,5 GHz :
          A.1) Tri_Casiers avec Valeur Plafond donnée ET transmise = 1000000 (utilisation optimale) :
             - pour Nombre de Valeurs =  1000000 : mis en moyenne = 15 ms
             - pour Nombre de Valeurs = 10000000 : mis en moyenne = 55 ms

          A.1bis) Tri_Casiers Valeur Plafond donnée NON transmise = 1000000 (utilisation non optimale) :
             - pour Nombre de Valeurs =  1000000 : mis en moyenne =  39 ms
             - pour Nombre de Valeurs = 10000000 : mis en moyenne = 102 ms soit environ 2 fois plus lent que Tri-casiers-utilisation-optimale

          A.2) QuickSortRecursif avec Valeur Plafond donnée = 1000000 :
             - pour Nombre de Valeurs =  1000000 : mis en moyenne = 117 ms soit 117/15 =  7,8 fois plus lent que Tri-casiers-optimal
             - pour Nombre de Valeurs = 10000000 : mis en moyenne = 954 ms soit 954/55 = 17,3 fois plus lent que Tri-casiers-optimal

          A.3) QuickSortIteratif avec Valeur Plafond donnée = 1000000 :
             - pour Nombre de Valeurs =  1000000 : mis en moyenne =  94 ms soit  94/15 =  6,2 fois plus lent que Tri-casiers-optimal
             - pour Nombre de Valeurs = 10000000 : mis en moyenne = 834 ms soit 834/55 = 15,1 fois plus lent que Tri-casiers-optimal

          Et Tri_Casiers même en utilisation non-optimale est au minimum entre 94/39 = 2,4 et 834/102 = 8,1 fois plus rapide que le QuickSort Itératif

          Dans tous les cas les valeurs triées ont été prises égales à Random(Valeur Plafond)

      Principal avantage du Tri_Casiers : Rapidité optimale si toutes les valeurs à trier sont entières et positives et si leur valeur plafond est transmise.
      - Peut cependant être utilisé si toutes les valeurs à trier sont négatives (en les rendant positives avant le tri, puis négatives à la restitution : légère perte de performances)
      - Peut être modifié pour trier un mélange de valeurs entières positives et négatives : performances divisées par deux.
      - Sa modification pour trier des valeurs réelles est possible (en les multipliant avant le tri par 10^k et en retenant les parts entières, si on se contente de k décimales) mais ne présente pas d'intérêt
        car les complications requises plombent assez rapidement les performances.

      Principal inconvénient du Tri_Casiers : gourmand en mémoire vive pour le tri de valeurs numériques, mais ceci n'était un problème qu'aux débuts de la micro-informatique pauvre en mem-vive.

  B) TRI de CHAINES de CARACTERES : Le principe du Tri_Casiers est aussi applicable au tri de chaînes de caractères avec les avantages suivants.
     Comme la table des caractères ne comporte que 256 codes, la taille du tableau d'occurrences "nbOcc[valeur]" ne dépasse donc jamais 256 et ne risque donc plus d'être la cause d'une saturation de la mémoire disponible.
     De plus, dès le tri sur le 1er caractère des chaînes on se retrouve avec au maximum 256 sous-listes (partitionnement) dont les chaînes commençent par un même caractère.
     Et toute sous-liste qui à ce stade ne comporterait qu'une seule chaîne ou uniquement des doublons, triplons éventuels, etc se trouve d'entrée de jeu classée quelle que soit sa longueur
     (donc inutile de boucler sur toute sa longueur).
     Sinon, on trie chaque sous-liste sur le 2ième caractère et on isole dans une sous-liste les chaînes qui commencent par la même SubString,
     ... puis on trie cette dernière sous-liste sur le 3ième caractère et on isole comme déjà dit,
     ... et ainsi de suite jusqu'à la fin de chaque chaîne,
     ... mais on peut aussi se contenter de fixer la profondeur-max du tri aux N premiers caractères des chaînes : gain de speed variable supplémentaire (voir résultats logés dans le code de la
         procedure TfrmTriK.bCreerListeChainesPuisTrierCasiersClick()),
     ... Et vérification faite lors de tests de tris de 1000000 chaînes de 250 caractères et profondeur-max de tri = 250 la profondeur réelle du tri n'a jamais dépassé 9.


     Comparatif des performances du Tri_Casiers par rapport à QuickSortRecursif :

     B.1) Tri_Casiers sur chaînes de 250 caractères et profondeur-max de tri = 250 :
          - pour  500000 chaînes, mis :  982 ms
          - pour 1000000 chaînes, mis : 2091 ms

     B.2) QuickSortRecursif sur chaînes de 250 caractères et profondeur de tri = 250 :
          - pour  500000 chaînes, mis : 26411 ms soit 26411/982  = 26,9 fois plus lent qu'avec Tri_Casiers
          - pour 1000000 chaînes, mis : 58173 ms soit 58173/2091 = 27,8 fois plus lent qu'avec Tri_Casiers
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math, StdCtrls, Buttons, ClipBrd, ComCtrls;

type
  TfrmTriK = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edNbValLongWord: TEdit;
    btnTriCasiers: TSpeedButton;
    btnQuickSortRecursif: TSpeedButton;
    Label3: TLabel;
    edValPlafond: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    bCreerTableauQuickSortIteratif: TSpeedButton;
    ckBoxAfficherTableaux: TCheckBox;
    GroupBox2: TGroupBox;
    bCreerListeChainesPuisTrierCasiers: TSpeedButton;
    bCreerListePuisQuickSortRecursif: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edNbChaines: TEdit;
    edLongueurChaine: TEdit;
    Label10: TLabel;
    edProfMaxTri: TEdit;
    Panel2: TPanel;
    Label1: TLabel;
    labCountNonTrie: TLabel;
    ListBox1: TListBox;
    Panel3: TPanel;
    Label2: TLabel;
    ckBoxDecroissant: TCheckBox;
    labCountTrie: TLabel;
    ListBox2: TListBox;
    Panel4: TPanel;
    edMemDispo: TEdit;
    Label11: TLabel;
    edChrono: TEdit;
    rbLongConstante: TRadioButton;
    rbLongVariable: TRadioButton;
    procedure edNbValLongWordChange(Sender: TObject);
    procedure btnTriCasiersClick(Sender: TObject);
    procedure btnQuickSortRecursifClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edValPlafondChange(Sender: TObject);
    procedure bCreerTableauQuickSortIteratifClick(Sender: TObject);
    procedure bCreerListeChainesPuisTrierCasiersClick(Sender: TObject);
    procedure edNbChainesChange(Sender: TObject);
    procedure edLongueurChaineChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure bCreerListePuisQuickSortRecursifClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmTriK: TfrmTriK;

implementation

{$R *.DFM}

// Divers :

procedure SMS(s: string); // Showmessage : 11 caractères à taper chaque fois !!!
begin Showmessage(s); end;

type TMemoryStatusEx = record
    dwLength: DWord;
    dwMemoryLoad: DWord;     // Pourcentage de mem utlisée
    ullTotalPhys: Int64;     // Mém-Phys Totale
    ullAvailPhys: Int64;     // Mém-Phys Dispo
    ullTotalPageFile: Int64; // Mém-Paginée Totale
    ullAvailPageFile: Int64; // Mém-Paginée Dispo
    ullTotalVirtual: Int64;  // Mém-Virtuelle Totale
    ullAvailVirtual: Int64;  // Mém-Virtuelle Dispo
    ullAvailExtendedVirtual: Int64;
  end;

procedure GlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx); stdcall; external kernel32 name 'GlobalMemoryStatusEx';

function fGoMoKo(mem: int64): string;
//       Renvoie chaîne courte
var e: integer; s: string; r: real;
begin e := 0; r := mem;
  if r >= 0 then
  begin while r > 1024 do begin r := r / 1024; inc(e); end;
    case e of
      0: s := 'oct';
      1: s := 'Ko';
      2: s := 'Mo';
      3: s := 'Go';
      4: s := 'To';
    end;
    fGoMoKo := FormatFloat('#.###', r) + ' ' + s;
  end;
end;

function memDispo: Int64; // renvoie mem vive dispo ***
var Mem: TMemoryStatusEx;
begin // Recherche des informations sur la mémoire
  Mem.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(Mem);
  memDispo := Mem.ullAvailPhys;
end;

// TRI de VALEURS ENTIERES : ====================================================

type TAOLW = array of LongWord;

var Table: TAOLW;
  nbValLW: LongWord;
  ValPlafond: integer;
  Start: LongWord;

procedure AfficherTable(T: TAOLW; Dans: TListBox; IgnorerIndiceZero: boolean);
//        IgnorerIndiceZero : utilisé pour tenir compte du fait que QuickSortIteratif
//        ne trie pas l'élément d'indice ZERO
var i, imin: longword;
begin with frmTriK do begin
    Dans.items.BeginUpdate;
    if IgnorerIndiceZero then imin := 1 else imin := 0;
    if ckBoxDecroissant.checked
      then for i := High(T) downto imin
      do Dans.items.add(intToStr(T[i]))
    else for i := imin to High(T)
      do Dans.items.add(intToStr(T[i]));
    Dans.items.EndUpdate;
  end;
end;

function CreerTableauRandomLongWord(nbVal, ValPlaf: LongWord; IgnorerIndiceZero: boolean): TAOLW;
//        IgnorerIndiceZero : utilisé pour tenir compte du fait que QuickSortIteratif
//        ne trie pas l'élément d'indice ZERO
var i, imin: longword;
begin with frmTriK do begin
    ListBox1.Clear; ListBox2.Clear;
    if IgnorerIndiceZero then begin imin := 1; inc(nbVal); end else imin := 0;
    SetLength(Result, nbVal);
    Randomize;
    for i := imin to High(Result) do Result[i] := Random(ValPlaf);
    if ckBoxAfficherTableaux.checked then begin
      AfficherTable(Result, ListBox1, IgnorerIndiceZero);
      labCountNonTrie.caption := IntToStr(ListBox1.items.count);
    end;
  end;
end;

//******************************************************************************
// Tri par casiers : pour tris de LongWord et restitution du tri en ordre croissant
// via le tableau VAL fourni en entrée
//******************************************************************************

function Tri_Casiers(var VAL: TAOLW; ValPlaf: LongWord): boolean;
//        VAL = tableau des valeurs à trier
//        ValPlaf = valeur-maxi ou valeur-plafond supérieure ou égale à la plus
//        grande des valeurs présentes dans le tableau VAL
//        - si valPlaf <> 0 alors gain de temps
//        - si valPlaf = 0 alors on recherche d'abord le maxi mais vitesse divisée par environ 2
//        On considère que leur valeur Plancher est égale à zéro.
var i, va, iv, j: LongWord; Occ: TAOLW; // Occ = Tableau de comptage des occurrences
begin Result := False;
  if valPlaf = 0 then for i := Low(VAL) to High(VAL) do valPlaf := max(valPlaf, VAL[i]);
  try SetLength(Occ, valPlaf + 1);
  except
    showMessage('Mem-vive-dispo : insuffisante pour ce tri');
    EXIT;
  end;
  try for i := Low(VAL) to High(VAL) do
    begin va := VAL[i]; // la valeur
      Occ[va] := Occ[va] + 1; // le nombre de ses occurrences
    end; // ici le tri est fini
  except
    showMessage('ValPlaf en entrée sous-évalué pour ce tri');
    Result := False;
    EXIT;
  end;
  //Restitution du tri dans l''ordre croissant via VAL
  iv := 0;
  for va := 0 to ValPlaf
    do if Occ[va] <> 0
    then for j := 1 to Occ[va] do begin VAL[iv] := va; inc(iv); end;
  Result := True;
end;

//******************************************************************************
// QuickSort Récursif : Version LongWord : pour comparaison des performances
//******************************************************************************

procedure QuicksortRecursifLW(var A: TAOLW);

  procedure Quicksort(l, r: LongWord);
  var pivot, b, i, j: LongWord;
  begin if l < r then begin
      pivot := A[random(r - l) + l + 1];
      i := l - 1;
      j := r + 1;
      repeat
        repeat i := i + 1 until pivot <= A[i];
        repeat j := j - 1 until pivot >= A[j];
        b := A[i]; A[i] := A[j]; A[j] := b
      until i >= j;

      A[j] := A[i]; A[i] := b;

      Quicksort(l, i - 1);
      Quicksort(i, r)
    end;
  end;
begin Quicksort(Low(A), High(A));
end;

//******************************************************************************
// QuickSort NON-Récursif : Version LongWord : pour comparaison des performances
//******************************************************************************

procedure QuickSortIteratifLW(var Table: TAOLW); // de J.FS
var
  s, sj, sl, sr, j, S1: LongWord; // Les compteurs intermediaires du tri
  Code: LongWord; // Clef de recherche
  Resa_Chiffre: LongWord; // Utilisé pour les permutations, doit etre du même type que les données à trier
  St: array[0..100, 0..1] of LongWord; // Table qui remplace la recursivité et améliore les performances
                                       // le dimensionnement à 100 correspond au nombre maximal d'appels en recursivité-itérative
                                       // normalement 10 devraient suffire mais avec 100 on doit pouvoir trier quelques milliards d'infos...
begin
  S := 1; // IMPORTANT on ne trie pas l'élément d'indice ZERO
  st[S, 0] := 1; // " "
  st[S, 1] := length(Table) - 1; // Nombre d'éléments à trier à partir de l'indice 1
  repeat
    sl := st[S, 0]; // Sauvegarde des offsets pour la recursivité-itérative
    sr := st[S, 1];
    S := pred(S);
    repeat
      j := sl; // Le quick sort trie le fichier par morceaux de plus en plus grands
      sj := sr;
      S1 := (sl + sr) div 2; // On divise le nombre d'elements choisi par deux
      Code := Table[S1];     // On mémorise le critère de tri de l'élément actif (plus de clarté dans les tests à suivre
      repeat
        while (Table[J] < Code) do   // Partant du debut de la portion selectionnée on, recherche le
          j := j + 1;                // premier element plus grand dans cet intervalle
        while (Code < Table[Sj]) do  // maintenant on recherche le plus petit partant de la fin
          SJ := Sj - 1;
        if j <= sj then              // Quand on a trouvé on permute avec resa_Chiffre
        begin                        // l'autre concept du quick sort est que plus la  permutation est
          Resa_Chiffre := Table[Sj]; // lointaine plus elle est efficace: il vaut mieux permuter le premier
          Table[Sj] := Table[j];     // avec le dernier que le premier avec le second
          Table[j] := Resa_Chiffre;  // il a plus de chance d'être à sa place
          j := Succ(J);
          sj := Pred(sj);            // On rétrecit la portion de recherche jusqu'a son arrivée à 0 éléments
        end;
      until j > sj;
      if j < sr then                 // Et c'est ici qu'on récurse-itérativement en se servant de la table
      begin
        S := Succ(S);
        St[S, 0] := j;
        St[S, 1] := sr;
      end;
      sr := sj;
    until sl >= sr;
  until S < 1;
end; // QuickSortIteratifLW

procedure TfrmTriK.edNbValLongWordChange(Sender: TObject);
var code: integer;
begin val(edNbValLongWord.text, nbValLW, code); end;

procedure TfrmTriK.edValPlafondChange(Sender: TObject);
begin if edValPlafond.text = '' then edValPlafond.text := '10';
  ValPlafond := StrToInt(edValPlafond.text);
end;

procedure TfrmTriK.btnTriCasiersClick(Sender: TObject);
var ok: boolean; i: LongWord;
begin // Génration tableau de valeurs :
  SetLength(Table, 0);
  edChrono.text := 'Création du tableau de valeurs aléatoires en cours ...';
  edChrono.Update;
  Table := CreerTableauRandomLongWord(nbValLW, ValPlafond, FALSE);
          // Tri :
  ListBox2.Clear;
  Start := GetTickCount;
  ok := Tri_Casiers(Table, ValPlafond);
  edChrono.text := 'Tri_Casiers mis : ' + intToStr(GetTickCount - Start) + ' ms';

  // Tri_Casiers avec valPlaf donné et transmis = 1000000 :
  // pour nbVal =  1000000 : mis  0 à 31 ms : moyenne = 15 ms
  // pour nbVal = 10000000 : mis 47 à 62 ms : moyenne = 55 ms

  // Tri_Casiers avec valPlaf donné NON transmis = 1000000 :
  // pour nbVal =  1000000 : mis 31 à  47 ms : moyenne =  39 ms
  // pour nbVal = 10000000 : mis 93 à 110 ms : moyenne = 102 ms : perf divisée par environ 2

  // Affichage résultat du tri
  if ok and ckBoxAfficherTableaux.checked then
  begin AfficherTable(Table, ListBox2, FALSE);
    labCountTrie.caption := IntToStr(ListBox2.items.count);
  end;
end;

procedure TfrmTriK.btnQuickSortRecursifClick(Sender: TObject);
var i: LongWord;
begin // Génration tableau de valeurs :
  SetLength(Table, 0);
  Table := CreerTableauRandomLongWord(nbValLW, ValPlafond, FALSE);
  // Tri :
  ListBox2.Clear;
  Start := GetTickCount;
  QuickSortRecursifLW(Table);
  edChrono.text := 'QuickSortRecursif mis : ' + intToStr(GetTickCount - Start) + ' ms';
  // QuickSortRecursif avec valPlaf donné = 1000000 :
  // pour nbVal =  1000000 : mis 109 à 125 ms : moyenne = 117 ms soit 117/15 =  7,8 fois plus lent que Tri-casiers
  // pour nbVal = 10000000 : mis 951 à 957 ms : moyenne = 954 ms soit 954/55 = 17,3 fois plus lent que Tri-casiers
  // Affichage résultat du tri
  if ckBoxAfficherTableaux.checked then
  begin AfficherTable(Table, ListBox2, FALSE);
    labCountTrie.caption := IntToStr(ListBox2.items.count);
  end;
end;

procedure TfrmTriK.bCreerTableauQuickSortIteratifClick(Sender: TObject);
var i: LongWord;
begin // Génration tableau de valeurs :
  SetLength(Table, 0);
  Table := CreerTableauRandomLongWord(nbValLW, ValPlafond, TRUE);
          // Tri :
  ListBox2.Clear;
  Start := GetTickCount;
  QuickSortIteratifLW(Table);

  edChrono.text := 'QuickSortIteratif mis : ' + intToStr(GetTickCount - Start) + ' ms';
  // QuickSortIteratif avec valPlaf donné = 1000000 :
  // pour nbVal =  1000000 : mis  78 à 110 ms : moyenne =  94 ms soit  94/15 =  6,2 fois plus lent que Tri-casiers
  // pour nbVal = 10000000 : mis 826 à 842 ms : moyenne = 834 ms soit 834/55 = 15,1 fois plus lent que Tri-casiers

  // Affichage résultat du tri :
  if ckBoxAfficherTableaux.checked then
  begin AfficherTable(Table, ListBox2, TRUE);
    labCountTrie.caption := IntToStr(ListBox2.items.count);
  end;
end;

// TRI de CHAINES de CARACTERES : ===============================================

var ListeStr: tStringList;
  nbStr: LongWord;
  lgStr: integer;

procedure AfficherListeChaines(Liste: tStringList; Dans: TListBox);
var i: longword;
begin with frmTriK do begin
    Dans.items.BeginUpdate;
    for i := 0 to Liste.count - 1 do Dans.items.add(Liste[i]);
    Dans.items.EndUpdate;
  end;
end;

function CreerListeRandomChaines1(nbVal: integer; LgChaines: integer): tStringList;
//        Renvoie Liste de chaînes aléatoires mais de même longueur
var i, imin: longword;

  function StrAleat: string;
  var j: integer;
  begin SetLength(Result, LgChaines);
    for j := 1 to LgChaines do Result[j] := char(97 + random(26));
  end;

begin with frmTriK do begin
    ListBox1.Clear; ListBox2.Clear;
    Result := tStringList.create;
    Result.Capacity := nbVal;
    Randomize;
    for i := 1 to nbVal do Result.Add(StrAleat);
    if ckBoxAfficherTableaux.checked then begin
      AfficherListeChaines(Result, ListBox1);
      labCountNonTrie.caption := IntToStr(ListBox1.items.count);
    end;
  end;
end;

function CreerListeRandomChaines2(nbVal: integer; LgMaxChaines: integer): tStringList;
//        Renvoie Liste de chaînes aléatoires et de longueur aléatoire variant de 1 à LgMaxChaines
var i, imin: longword;

  function StrAleat: string;
  var j, LgChaines: integer;
  begin LgChaines := 1 + Random(LgmaxChaines);
    SetLength(Result, LgChaines);
    for j := 1 to LgChaines do Result[j] := char(97 + random(26));
  end;

begin with frmTriK do begin
    ListBox1.Clear; ListBox2.Clear;
    Result := tStringList.create;
    Result.Capacity := nbVal;
    Randomize;
    for i := 1 to nbVal do Result.Add(StrAleat);
    if ckBoxAfficherTableaux.checked then begin
      AfficherListeChaines(Result, ListBox1);
      labCountNonTrie.caption := IntToStr(ListBox1.items.count);
    end;
  end;
end;

procedure TfrmTriK.edNbChainesChange(Sender: TObject);
begin if edNbChaines.text = '' then edNbChaines.text := '2';
  nbStr := StrToInt(edNbChaines.text);
end;

procedure TfrmTriK.edLongueurChaineChange(Sender: TObject);
begin if edLongueurChaine.text = '' then edLongueurChaine.text := '1';
  lgStr := StrToInt(edLongueurChaine.text);
end;

//******************************************************************************
// Tri_Casiers : Version StringList
//******************************************************************************

procedure Tri_CasiersStr(var DonneesTxt: tStringList; ProfMaxTri: integer; SensDeTri: boolean);
//        Renvoie DonneesTxt triée dans le sens croissant si SensDeTri = True, sinon décroissant.
//        Si ProfMaxTri inférieur à length(chaînes) alors les chaînes ne sont triées que sur les ProfMaxTri premiers caractères
var io, io1, io2: integer;
  CC: array of byte; // Table des valeurs de caractères courants
  CCcount: integer;  // Nombre max d'éléments dans la table CC
  TriPremCar: array[0..255] of tStringList; // Table de partitionnement
  ProfTri: integer;  // Profondeur courante du tri = indice de colonne

  procedure TrierSur1erCaract;
  //        Tri de partitionnement sur premier caractère
  var i, codeCar: integer;
  begin for i := 0 to 255 do TriPremCar[i] := tStringList.create;
    for i := 0 to donneesTxt.count - 1 do
    begin if length(donneesTxt[i]) > 0 then // ici les chaînes éventuellement vides sont ignorées
      begin codeCar := ord(donneesTxt[i][1]);
        TriPremCar[codeCar].Add(donneesTxt[i]);
      end;
    end;
  end;

  function ToutesIdem(SL: tStringList): boolean;
  //        Renvoie True si toutes les strings de la sous-liste SL sont identiques
  var i: integer;
  begin if SL.count = 1 then begin Result := True; EXIT; end;
    i := 0; while (i + 1 <= SL.count - 1) and (SL[i] = SL[i + 1]) do inc(i);
    Result := (i = SL.count - 1);
  end;

  procedure TriKsurCarSuivants(var donnees: tStringList); // Récursif
  //        Tri-Casiers pour tris sur caractères dans colonne ProfTri >= 2
  type ind = array of integer;
  var iini: array of ind;     // table des indices initiaux des strings ( iini[IndiceCaractère][nbOcc[IndiceCaractère]]:= indice ligne )
    nbOcc: array of integer;  // nombre d'occurences d'un même caractère
    i, j: integer;
    SL: tStringList;          // Sous-Liste temporaire de strings commençant par des SubStrings identiques
    lgMax: integer;           // length-max des chaînes de SL
    carMax, carMin: byte;     // Valeurs Max et Min des caractères dans la colonne ProfTri
    car1, car2: integer;      // Bornes de parcours selon SensDeTri (integer à cause de car1:=carMin-1 qui devient négatif si carMin=0)
    car, ic: byte;

  begin // Recherche des valeurs Min et Max des caractères dans colonne ProfTri :
    carMax := 0; carMin := 255;
    for i := 0 to donnees.count - 1 do
    begin if (ProfTri <= ProfMaxTri) and (ProfTri <= length(donnees[i]))
      then CC[i] := ord(donnees[i][ProfTri]) else CC[i] := 0;
      carMax := max(carMax, CC[i]); carMin := min(carMin, CC[i]);
    end;
    // Tri-casiers :
    SetLength(nbOcc, carMax - carMin + 1);
    SetLength(iini, carMax - carMin + 1);

    for i := 0 to donnees.count - 1 do
    begin ic := CC[i] - carMin;
      nbOcc[ic] := nbOcc[ic] + 1; // incrémentation du nombre d'occurrences
      SetLength(iini[ic], nbOcc[ic] + 1);
      iini[ic][nbOcc[ic]] := i;  // mémorisation de l'indice initial de la ligne correspondante
    end;
    if SensDeTri = True then begin car1 := carMin - 1; car2 := carMax; end
    else begin car1 := carMax + 1; car2 := carMin; end;
    car := car1;
    repeat if SensDeTri = True then inc(car) else dec(car);
      ic := car - carMin;
      if nbOcc[ic] <> 0 then
      begin if nbOcc[ic] = 1 // une seule occurrence donc récup illico des simplets :
        then donneesTxt.Add(donnees[iini[ic][1]])
        else begin // ici plusieurs occurrences :

          SL := tStringList.create; lgMax := 0;
          for j := 1 to nbOcc[ic] do
          begin SL.add(donnees[iini[ic][j]]);
            lgMax := max(length(donnees[iini[ic][j]]), lgMax);
          end;

          if (ProfTri < ProfMaxTri) and (ProfTri < lgMax) then // Tri sur caractères suivants :
          begin inc(ProfTri); TriKsurCarSuivants(SL); end // On Récurse
          else // Récup résidus du tri :
            if (ProfTri = ProfMaxTri) or (ProfTri = lgMax) or (ProfTri = length(SL[0]) + 1)
              then donneesTxt.AddStrings(SL); // doublons, triplets, etc ou profondeur de tri atteinte

          ProfTri := 2;
          SL.free;
        end; // if nbOcc[car-carMin]=1
      end; // if nbOcc[car-carMin]<>0
    until car = car2;
  end; //TriKsurCarSuivants

begin
  TrierSur1erCaract; // Pré-tri de partitionnement de donneesTxt sur premier caractère
  donneesTxt.clear;  // donneesTxt : ré-utilisée pour restituer le tri final

  // Recherche de CCcount pour dimensionner CC hors boucle de récursivité de TriKsurCarSuivants
  CCcount := 0;
  for io := 0 to 255 do CCcount := max(CCcount, TriPremCar[io].Count);
  SetLength(CC, CCcount);

  if SensDeTri = True then begin io1 := -1; io2 := 255; end
  else begin io1 := 256; io2 := 0; end;
  io := io1;
  repeat if SensDeTri = True then inc(io) else dec(io);
    if TriPremCar[io].count <> 0 then
    begin if ToutesIdem(TriPremCar[io]) or (ProfMaxTri = 1)
      then donneesTxt.AddStrings(TriPremCar[io]) // : récup directe d'un lot de doublons, simplets ... ou du tri sur 1er caractère si ProfMaxTri = 1
      else begin ProfTri := 2; TriKsurCarSuivants(TriPremCar[io]); end; // : tri sur caractères suivants
    end;
  until io = io2;

  for io := 0 to 255 do TriPremCar[io].free;
end; // Tri_CasiersStr

//******************************************************************************
// QuickSort Récursif : Version StringList : pour comparaison des performances
//******************************************************************************

procedure QuickSortSLRecursif(var SL: TStringList; ProfMaxTri: integer; SensDeTri: boolean);
//        Avec SensDeTri = True, SL est triée dans l'ordre croissant, sinon décroissant.
//        Si ProfMaxTri inférieur à length-max(chaînes) alors les chaînes ne sont triées que sur les ProfMaxTri premiers caractères.

  procedure QuickSortR(var SL: TStringList; lDeb, lFin: Integer);

    function CompareLigTxtMajMin(li1, li2: Integer): Integer;
    //       Compare deux lignes de chaînes de texte avec distinction Maj/min sur ProfMaxTri
    var s1, s2: string;
    begin s1 := Copy(SL[li1], 1, ProfMaxTri); s2 := Copy(SL[li2], 1, ProfMaxTri);
      case SensDeTri of
        true: result := AnsiCompareStr(s1, s2);
        false: result := AnsiCompareStr(s2, s1);
      else result := 0;
      end;
    end;

    procedure PermuterLignes(li1, li2: Integer);
    var s: string;
    begin s := SL[li1]; SL[li1] := SL[li2]; SL[li2] := s; end;

  var Lo, Hi, Mi: Integer;
  begin Lo := lDeb;
    Hi := lFin;
    Mi := (lDeb + lFin) shr 1;
    repeat
      while CompareLigTxtMajMin(Lo, Mi) < 0 do Inc(Lo);
      while CompareLigTxtMajMin(Hi, Mi) > 0 do Dec(Hi);
      if Lo <= Hi then
      begin
        PermuterLignes(Lo, Hi);
        if Mi = Lo then Mi := Hi
        else if Mi = Hi then Mi := Lo;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > lDeb then QuickSortR(SL, lDeb, Hi);
    if Lo < lFin then QuickSortR(SL, Lo, lFin);
  end;
begin
  QuickSortR(SL, 0, SL.count - 1);
end; // QuickSortSLRecursif

procedure TfrmTriK.bCreerListeChainesPuisTrierCasiersClick(Sender: TObject);
var profMaxTri: integer; SensDeTri: boolean;
begin edChrono.text := 'Création de la liste de chaînes aléatoires en cours ...';
  edChrono.Update;
  if rbLongConstante.checked then ListeStr := CreerListeRandomChaines1(nbStr, LgStr)
  else ListeStr := CreerListeRandomChaines2(nbStr, LgStr);
  edMemDispo.Text := 'Mem Dispo : ' + fGoMoKo(memDispo); edMemDispo.Update;
  profMaxTri := StrToInt(edProfMaxTri.text);

  Start := GetTickCount;
  edChrono.text := 'Tri_CasiersStr en cours ...';
  edChrono.Update;
  SensDeTri := not ckBoxDecroissant.checked;
  Tri_CasiersStr(ListeStr, ProfMaxTri, SensDeTri);
  edChrono.text := 'Tri_Casiers mis : ' + intToStr(GetTickCount - Start) + ' ms';
  edChrono.Update;

  // Pour  500000 de chaînes de 250 caractères et profondeur-max de tri = 250  : Tri_Casiers mis :  982 ms
  // Pour 1000000 de chaînes de 250 caractères et profondeur-max de tri = 250  : Tri_Casiers mis : 2091 ms

  // Pour 500000 de chaînes de 250 caractères et profodeurs de tri variables : gains de vitesse variables :
  // - avec profondeur de tri =   1   : Tri_Casiers mis : 141 ms
  // - avec profondeur de tri =   2   : Tri_Casiers mis : 265 ms
  // - avec profondeur de tri =   3   : Tri_Casiers mis : 499 ms
  // - avec profondeur de tri =   4   : Tri_Casiers mis : 905 ms
  // - avec profondeur de tri =   5   : Tri_Casiers mis : 967 ms
  // - avec profondeur de tri =  10   : Tri_Casiers mis : 998 ms
  // - avec profondeur de tri =  20   : Tri_Casiers mis : 999 ms
  // - avec profondeur de tri = 250   : Tri_Casiers mis : 982 ms

  // Affichage résultat du tri
  if ckBoxAfficherTableaux.checked then
  begin AfficherListeChaines(ListeStr, ListBox2);
    labCountTrie.caption := IntToStr(ListBox2.items.count);
  end;
  ListeStr.free;
end;

procedure TfrmTriK.bCreerListePuisQuickSortRecursifClick(Sender: TObject);
var profMaxTri: integer; SensDeTri: boolean;
begin edChrono.text := 'Création de la liste de chaînes aléatoires en cours ...';
  edChrono.Update;
  if rbLongConstante.checked then ListeStr := CreerListeRandomChaines1(nbStr, LgStr)
  else ListeStr := CreerListeRandomChaines2(nbStr, LgStr);

  edMemDispo.Text := 'Mem Dispo : ' + fGoMoKo(memDispo); edMemDispo.Update;

  Start := GetTickCount;
  edChrono.text := 'Tri QuickSortRecursif en cours ...'; edChrono.Update;
  SensDeTri := not ckBoxDecroissant.checked;
  profMaxTri := StrToInt(edProfMaxTri.text);
  QuickSortSLRecursif(ListeStr, profMaxTri, SensDeTri);
  edChrono.text := 'QuickSortRecursif mis : ' + intToStr(GetTickCount - Start) + ' ms';
  edChrono.Update;

  // Pour  500000 de chaînes de 250 caractères et profondeur-max de tri = 250 : QuickSortRecursif mis : 26411 ms soit 26411/982  = 26,9 fois plus lent qu'avec Tri_Casiers
  // Pour 1000000 de chaînes de 250 caractères et profondeur-max de tri = 250 : QuickSortRecursif mis : 58173 ms soit 58173/2091 = 27,8 fois plus lent qu'avec Tri_Casiers

  // Affichage résultat du tri
  if ckBoxAfficherTableaux.checked then
  begin AfficherListeChaines(ListeStr, ListBox2);
    labCountTrie.caption := IntToStr(ListBox2.items.count);
  end;
  ListeStr.free;
end;

procedure TfrmTriK.FormShow(Sender: TObject);
begin
  // Pour tris de valeurs numériques
  nbValLW := 20;
  edNbValLongWord.text := intToStr(nbValLW);
  ValPlafond := StrToInt(edValPlafond.text);
  // Pour tris de chaines
  nbStr := StrToInt(edNbChaines.text);
  lgStr := StrToInt(edLongueurChaine.text);
  // Mem-vive dispo :
  edMemDispo.Text := 'Mem Dispo : ' + fGoMoKo(memDispo);
  edChrono.text := '-';
  Application.HintHidePause := 10000;
end;

procedure TfrmTriK.FormResize(Sender: TObject);
var la: integer;
begin la := ClientWidth - panel2.left - 10;
  panel2.width := (la shr 1) - 4;
  panel3.left := panel2.left + panel2.width + 8;
  panel3.width := panel2.width;
  panel2.height := ClientHeight - panel4.height - panel2.top;
  panel3.height := panel2.height;
end;

end.

