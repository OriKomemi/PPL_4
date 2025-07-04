:- module('ex4',
        [author/2,
         genre/2,
         book/4,
         max_list/2,
         author_of_genre/2,
         longest_book/2
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(a, asimov).
author(h, herbert).
author(m, morris).
author(t, tolkien).

genre(s, science).
genre(l, literature).
genre(sf, science_fiction).
genre(f, fantasy).

book(inside_the_atom, a, s, s(s(s(s(s(zero)))))).
book(asimov_guide_to_shakespeare, a, l, s(s(s(s(zero))))).
book(i_robot, a, sf, s(s(s(zero)))).
book(dune, h, sf, s(s(s(s(s(zero)))))).
book(the_well_at_the_worlds_end, m, f, s(s(s(s(zero))))).
book(the_hobbit, t, f, s(s(s(zero)))).
book(the_lord_of_the_rings, t, f, s(s(s(s(s(s(zero))))))).

% You can add more facts.


% Signature: max_list(Lst, Max)/2
% Purpose: true if Max is the maximum church number in Lst, false if Lst is empty.
church_to_int(zero, 0).
church_to_int(s(N), I) :-
    church_to_int(N, I0),
    I is I0 + 1.

max_list([], _) :-
    fail.
max_list([H|T], Max) :-
    max_list(T, H, Max).

max_list([], Max, Max).
max_list([H|T], Cur, Max) :-
    church_to_int(H, Hi),
    church_to_int(Cur, Ci),
    (Hi >= Ci ->
        max_list(T, H, Max)
    ;
        max_list(T, Cur, Max)
    ).








% Signature: author_of_genre(GenreName, AuthorName)/2
% Purpose: true if an author by the name AuthorName has written a book belonging to the genre named GenreName.

author_of_genre(GenreName, AuthorName) :-
    genre(GenreId, GenreName),
    book(_, AuthorId, GenreId, _),
    author(AuthorId, AuthorName).








% Signature: longest_book(AuthorName, BookName)/2
% Purpose: true if the longest book that an author by the name AuthorName has written is titled BookName.

longest_book(AuthorName, BookName) :-
    author(AuthorId, AuthorName),
    findall((Len,Title), book(Title, AuthorId, _, Len), Books),
    Books \= [],
    max_book(Books, (MaxLen, BookName)).

max_book([P], P).
max_book([(L1,T1)|Rest], (MaxL, MaxT)) :-
    max_book(Rest, (L2,T2)),
    (greater_eq_church(L1,L2) ->
        MaxL = L1, MaxT = T1
    ;
        MaxL = L2, MaxT = T2
    ).

greater_eq_church(A,B) :-
    church_to_int(A, IA),
    church_to_int(B, IB),
    IA >= IB.
