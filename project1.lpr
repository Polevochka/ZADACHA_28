{
 если просто копируете, то УДАЛЯЙТЕ КОММЕНТАРИИ
 пишите только маленькие поправочные
 ПО МОЕМУ ОБЪЁМУ комментариев он вычисляет что это скорее всего писал я
 он меня ска ЗАПОМНИЛ с прошлого года
 И даёт какую-нибудь невъебенную задачу посложнее, дополняя эту
}
program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

type
   {тип записи для студента}
   // T перед Stud значит ТИП - просто правило приличия, можно и без него
   TStud = record
     name: string;    // фамилия
     o1, o2: integer; // оценки
   end;
   {тип массива студентов для передачи в функции}
   TMasStuds = array[1..10] of TStud;

 {логическая функция: прилежный студент или нет}
 // возвращает 'истина' если сума оценок студента < 10
 // или студент имеет хотябы одну 0 оценку
 // иначе - ложь
function IsBadStud(s: TStud): boolean;
begin
  if ((s.o1 + s.o2 < 10) or ((s.o1 = 0) or (s.o2 = 0))) then
     IsBadStud:= True
  else
     IsBadStud:= False;
end;

// Удаляем нерадивых студентов из массива
// var перед параметрами т.к. мы должны измеить И массив И чесло элемнтов в нем
procedure DeleteBads(var M: TMasStuds; var n: integer);
var i, j: integer;
begin
  i:= 0;
  // перебираем всех студентов
  while (i < n) do
  begin
    i:= i + 1;
    // если попался плохой студент то
    if (isBadStud(M[i])) then
       begin
         // затираем его другими элементами
         {
           то есть
         было  : s1 s2 s3 bad s4 s5
         cтанет: s1 s2 s3 s4  s5 s5

         и последний элемент надо удалить т.к. он повторяет предыдущий
         }
         // затёрли его другими элементами
         for j:=i+1 to n do
           M[j-1]:= M[j];
         // теперь удоляем последний элемнт
         n:= n-1; // тупо укорачивая общее количество элементов
         // теперь s1 s2 s3 s4  s5
       end;
  end;
end;

{Заполнение массива}
// var перед параметрами т.к. мы должны измеить И массив И чесло элемнтов в нем
procedure InputMas(var M: TMasStuds; var n: integer);
var i: integer;
    s: TStud; // вспомогательная переменная чтобы записывать студентов в массив
begin
  write('Введите число элементов: ');
  readln(n);
  // вводим каждого студента
  for i:=1 to n do
  begin
    Write('Фамилия студента: ');
    readln(s.name);
    write('Введите оценки студента(через пробел): ');
    readln(s.o1, s.o2);

    // заполнили студента теперь записываем его в массив
    M[i]:= s;
    writeln; // переход на другую строку для красоты
  end;
end;

{вывод массива на экран}
// здесь var перед параметрами не нужен
// так как мы не изменяем их а только выводим
procedure WriteMas(M: TMasStuds; n: integer);
var i: integer;
begin
  for i:=1 to n do
  begin
    write(m[i].name); // write чтобы не переходить со строки
    // m[i].o1:3 - для отступов чтобы оценки не слиплись
    writeln(m[i].o1:3, m[i].o2:3); // writeln - перейти на след строчку
  end;
end;

{основная программа}
var n: integer;    // КОЛИЧЕСТВО студентов в массиве
    M: TMasStuds;  // Массив студентов
begin
  InputMas(M, n);
  writeln('Наши студенты сейчас: ');
  WriteMas(M, n);
  DeleteBads(M, n);
  writeln; // для красоты
  writeln('Теперь без отчисленных студентов: ');
  WriteMas(M, n);

  readln; // задержка перед выходом
end.

