chapter {* Generated by Lem from missing_pervasives.lem. *}

theory "Missing_pervasivesAuxiliary" 

imports 
 	 Main "~~/src/HOL/Library/Code_Target_Numeral"
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_maybe" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_assert_extra" 
	 "Show" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_sorting" 
	 "$ISABELLE_HOME/src/HOL/Word/Word" 
	 "Elf_Types_Local" 
	 "Missing_pervasives" 

begin 


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

termination natural_of_decimal_string_helper by lexicographic_order

termination hex_string_of_natural by lexicographic_order

termination merge_by by lexicographic_order

termination mapMaybei' by lexicographic_order

termination partitionii' by lexicographic_order

termination zip3 by lexicographic_order

termination intercalate' by lexicographic_order

termination takeRevAcc by lexicographic_order

termination drop by lexicographic_order

termination string_index_of' by lexicographic_order

termination find_index_helper by lexicographic_order

termination replicate_revacc by lexicographic_order

termination list_reverse_concat_map_helper by lexicographic_order

termination list_take_with_accum by lexicographic_order


(****************************************************)
(*                                                  *)
(* Lemmata                                          *)
(*                                                  *)
(****************************************************)

lemma sort_by_def_lemma:
" ((\<forall> comp0. \<forall> xs.
   (case  xs of
         [] => []
     | [x] => [x]
     | xs =>
   (let ls = (List.take (List.length xs div ( 2 :: nat)) xs) in
   (let rs = (List.drop (List.length xs div ( 2 :: nat)) xs) in
   merge_by comp0 (Elf_Types_Local.merge_sort comp0 ls)
     (Elf_Types_Local.merge_sort comp0 rs)))
   ) = Elf_Types_Local.merge_sort comp0 xs)) "
(* Theorem: sort_by_def_lemma*)(* try *) by auto

lemma length_def_lemma:
" ((\<forall> xs.
   List.foldl (\<lambda> y _ . ( 1 :: nat) + y) (( 0 :: nat)) xs =
     List.length xs)) "
(* Theorem: length_def_lemma*)(* try *) by auto

lemma index_def_lemma:
" ((\<forall> xs. \<forall> m.
   (case  xs of
         [] => None
     | x # xs =>
   if m = ( 0 :: nat) then Some x else
     Elf_Types_Local.index xs (m - ( 1 :: nat))
   ) = Elf_Types_Local.index xs m)) "
(* Theorem: index_def_lemma*)(* try *) by auto

lemma replicate_def_lemma:
" ((\<forall> len. \<forall> e.
   replicate_revacc [] len e = List.replicate len e)) "
(* Theorem: replicate_def_lemma*)(* try *) by auto



end