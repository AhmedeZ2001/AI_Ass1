%Functions Used in more than 1 task
append([],L,L).
append([H|T],L2,[H|B]):-
append(T,L2,B).
%
memberof(X,[A|B]):-
X=A;
memberof(X,B).
 

%Task 1
studentsInCourse(X,List):-
studentsInCourse(X,[],List).


studentsInCourse(X,Tmp,List):-
student(A,X,B),
not(memberof([A,B],Tmp)), !,
append([[A,B]],Tmp,Newtmp),
studentsInCourse(X,Newtmp,List).


studentsInCourse(_,List,List).


%Task 2
len([],0).
len([_|T],N):-
len(T,N1),
N is N1+1.


numStudents(X,Y):-
studentsInCourse(X,List),
len(List,Y).


%Task 3


getgrad(A,List):-
getgrad(A,[],List).



getgrad(A,Tmp,List):-
student(A,_,M),
not(memberof(M,Tmp)),
append([M],Tmp,Newl),
getgrad(A,Newl,List).

getgrad(_,List,List).


maxnum([X],X).

maxnum([X|T],M):-
maxnum(T,M),
M >= X.

maxnum([X|T],X):-
maxnum(T,M),
X > M.


maxStudentGrade(X,Y):-
getgrad(X,Z),!,
maxnum(Z,Y),!.


%Task 4

numericValue(zero,0).
numericValue(one, 1).
numericValue(two, 2).
numericValue(three, 3).
numericValue(four, 4).
numericValue(five, 5).
numericValue(six, 6).
numericValue(seven, 7).
numericValue(eight, 8).
numericValue(nine, 9).


split(0,[]).
split(N,[A|As]) :- 
N1 is floor(N/10),
A is N mod 10,
split(N1,As).

getsec([H|_],H).
getfirst([_,S|_],S).

gradeInWords(X,Y,A):-
student(X,Y,Z),
split(Z,L),
getfirst(L,R),
getsec(L,J),
numericValue(Q,R),
numericValue(W,J),
A=[Q,W],!.


%Task 5

roadmap(X,List):-
roadmap(X,[],List).

roadmap(X,Tmp,List):-
prerequisite(Z,X),
not(memberof(Z,Tmp)), !,
append([Z],Tmp,NewList),
roadmap(Z,NewList,List).

roadmap(_,List,List).

donecourse(A,List):-
donecourse(A,[],List).

donecourse(A,Tmp,List):-
student(A,M,N),
N >= 50,
not(memberof(M,Tmp)),!,
append([M],Tmp,Newl),
donecourse(A,Newl,List).

donecourse(_,List,List).

commonSubject([X],[X]).
commonSubject([X|_],Y):- 
memberof(X,Y).
commonSubject([_|Tail],Y):- 
commonSubject(Tail,Y).

isnotexist(_, []).
isnotexist(X, [Y|Z]) :- 
X \= Y,  
isnotexist(X,Z).

delete(_, [], []).
delete(Y, [X|W], Z)     :- memberof(X, Y), delete(Y, W, Z).
delete(Y, [X|W], [X|Z]) :- isnotexist(X, Y), delete(Y, W, Z).

remainingCourses(X,Y,List):-
roadmap(Y,List1),
donecourse(X,List2),
commonSubject(List2,List1),
delete(List2,List1 ,List),!.


