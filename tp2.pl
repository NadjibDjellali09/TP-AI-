%qst1

member(x,[x,_]).
member(x,[_|tail]):- member(x,tail).

%qst2

first(E,[E|_]).

%qst3


last([X], X).                  
last([_|Tail], X) :-          
    last(Tail, X).

%qst4

penultimate(X, [X, _]).
penultimate(X, [_|T]):- penultimate(X, T).

%qst5

delete_me(X, [X|T], 1, T).
delete_me(X, [H|T], K, [H|R]) :-
    K > 1,
    k = K - 1,
    K1 is k,
    delete_me(X, T, K1, R).


%qst6

list_length([], 0).
list_length([_|T], N):-
    list_length(T, N1),
    N is N1 + 1.

%qst7

even([]).
even([_,_|T]):- even(T).


%qst8
concat([], L, L).
concat([H|T], L, [H|R]):- concat(T, L, R).

%qst9

palindrome(L) :- reverse(L, L).
reverse([], []).
reverse([H|T], R) :-
    reverse(T, RT),
    concat(RT, [H], R).


