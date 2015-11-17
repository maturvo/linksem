(* Generated by Lem from abis/abis.lem. *)

Require Import Arith.
Require Import Bool.
Require Import List.
Require Import String.
Require Import Program.Wf.

Require Import coqharness.

Open Scope nat_scope.
Open Scope string_scope.

(** The [abis] module is the top-level module for all ABI related code, including
  * some generic functionality that works across all ABIs, and a primitive attempt
  * at abstracting over ABIs for purposes of linking.
  *)

Require Import lem_basic_classes.
Require Export lem_basic_classes.

Require Import lem_bool.
Require Export lem_bool.

Require Import lem_num.
Require Export lem_num.

Require Import lem_maybe.
Require Export lem_maybe.

Require Import lem_list.
Require Export lem_list.

Require Import lem_set.
Require Export lem_set.

Require Import lem_map.
Require Export lem_map.

Require Import lem_string.
Require Export lem_string.

Require Import show.
Require Export show.

Require Import lem_assert_extra.
Require Export lem_assert_extra.

Require Import error.
Require Export error.

Require Import missing_pervasives.
Require Export missing_pervasives.


Require Import elf_file.
Require Export elf_file.

Require Import elf_header.
Require Export elf_header.

Require Import elf_interpreted_section.
Require Export elf_interpreted_section.

Require Import elf_relocation.
Require Export elf_relocation.

Require Import elf_symbol_table.
Require Export elf_symbol_table.

Require Import elf_program_header_table.
Require Export elf_program_header_table.

Require Import elf_section_header_table.
Require Export elf_section_header_table.

Require Import memory_image.
Require Export memory_image.


Require Import abi_amd64.
Require Export abi_amd64.

Require Import abi_amd64_relocation.
Require Export abi_amd64_relocation.


Require Import abi_aarch64_le.
Require Export abi_aarch64_le.

Require Import abi_aarch64_relocation.
Require Export abi_aarch64_relocation.


Require Import abi_power64.
Require Export abi_power64.

Require Import abi_power64_relocation.
Require Export abi_power64_relocation.


Require Import abi_classes.
Require Export abi_classes.

Require Import abi_utilities.
Require Export abi_utilities.

Require Import elf_types_native_uint.
Require Export elf_types_native_uint.

(* [?]: removed value specification. *)

Definition is_valid_abi_aarch64_relocation_operator  (op : relocation_operator )  : bool := 
  match ( op) with 
    | Page => true
    | G => true
    | GDat => true
    | GLDM => true
    | DTPRel => true
    | GTPRel => true
    | TPRel => true
    | GTLSDesc => true
    | Delta => true
    | LDM => true
    | TLSDesc => true
    | Indirect => true
    | _ => false
  end.
(* [?]: removed value specification. *)

Definition is_valid_abi_aarch64_relocation_operator2  (op : relocation_operator2 )  : bool := 
  match ( op) with 
    | GTLSIdx => true
  end.
(* [?]: removed value specification. *)

Definition is_valid_abi_amd64_relocation_operator  (op : relocation_operator )  : bool := 
  match ( op) with 
    | Indirect => true
    | _ => false (* XXX: not sure about this? *)
  end.
(* [?]: removed value specification. *)

Definition is_valid_abi_amd64_relocation_operator2  (op : relocation_operator2 )  : bool := 
  match ( op) with 
    | _ => false
  end.
(* [?]: removed value specification. *)

Definition is_valid_abi_power64_relocation_operator  (op : relocation_operator )  : bool :=  false.
(* [?]: removed value specification. *)

Definition is_valid_abi_power64_relocation_operator2  (op : relocation_operator2 )  : bool := 
  match ( op) with 
    | _ => false
  end.

(** Misc. ABI related stuff *)

Inductive any_abi_feature : Type :=  Amd64AbiFeature:  amd64_abi_feature  -> any_abi_feature 
                     | Aarch64LeAbiFeature:  aarch64_le_abi_feature  -> any_abi_feature .
Definition any_abi_feature_default: any_abi_feature  := Amd64AbiFeature amd64_abi_feature_default.
(* [?]: removed value specification. *)

Definition anyAbiFeatureCompare  (f1 : any_abi_feature ) (f2 : any_abi_feature )  : ordering :=  
    match ( (f1, f2)) with 
        (Amd64AbiFeature(af1),  Amd64AbiFeature(af2)) => abi_amd64.abiFeatureCompare0 af1 af2
       |(Amd64AbiFeature(_),  _) => LT
       |(Aarch64LeAbiFeature(af1),  Amd64AbiFeature(af2)) => GT
       |(Aarch64LeAbiFeature(af1),  Aarch64LeAbiFeature(af2)) => abiFeatureCompare af1 af2
    end.
(* [?]: removed value specification. *)

Definition anyAbiFeatureTagEquiv  (f1 : any_abi_feature ) (f2 : any_abi_feature )  : bool :=  
    match ( (f1, f2)) with 
        (Amd64AbiFeature(af1),  Amd64AbiFeature(af2)) => abi_amd64.abiFeatureTagEq0 af1 af2
       |(Amd64AbiFeature(_),  _) => false
       |(Aarch64LeAbiFeature(af1),  Amd64AbiFeature(af2)) => false
       |(Aarch64LeAbiFeature(af1),  Aarch64LeAbiFeature(af2)) => abiFeatureTagEq af1 af2
    end.

Instance x116_Ord : Ord any_abi_feature := {
     compare  :=  anyAbiFeatureCompare;
     isLess  :=  fun  f1 => (fun  f2 => ( (ordering_equal (anyAbiFeatureCompare f1 f2) LT)));
     isLessEqual  :=  fun  f1 => (fun  f2 => (set_member_by (fun  x  y=>EQ) (anyAbiFeatureCompare f1 f2) [LT;  EQ]));
     isGreater  :=  fun  f1 => (fun  f2 => ( (ordering_equal (anyAbiFeatureCompare f1 f2) GT)));
     isGreaterEqual  :=  fun  f1 => (fun  f2 => (set_member_by (fun  x  y=>EQ) (anyAbiFeatureCompare f1 f2) [GT;  EQ]))
}.


Instance x115_AbiFeatureTagEquiv : AbiFeatureTagEquiv any_abi_feature := {
     abiFeatureTagEquiv  :=  anyAbiFeatureTagEquiv
}.


Definition make_elf64_header  (data : nat ) (osabi : nat ) (abiv : nat ) (ma : nat ) (t : nat ) (entry : nat ) (shoff : nat ) (phoff : nat ) (phnum : nat ) (shnum : nat ) (shstrndx : nat )  : elf64_header := 
      {|elf64_ident    := [elf_mn_mag0; elf_mn_mag1; elf_mn_mag2; elf_mn_mag3; 
                           unsigned_char_of_nat elf_class_64; 
                           unsigned_char_of_nat data;
                           unsigned_char_of_nat elf_ev_current;
                           unsigned_char_of_nat osabi;
                           unsigned_char_of_nat abiv;
                           unsigned_char_of_nat( 0);
                           unsigned_char_of_nat( 0);
                           unsigned_char_of_nat( 0);
                           unsigned_char_of_nat( 0);
                           unsigned_char_of_nat( 0);
                           unsigned_char_of_nat( 0);
                           unsigned_char_of_nat( 0)]
       ;elf64_type     := (elf64_half_of_nat t)
       ;elf64_machine  := (elf64_half_of_nat ma)
       ;elf64_version  := (elf64_word_of_nat elf_ev_current)
       ;elf64_entry    := (elf64_addr_of_nat entry)
       ;elf64_phoff    := (elf64_off_of_nat phoff)
       ;elf64_shoff    := (elf64_off_of_nat shoff)
       ;elf64_flags    := (elf64_word_of_nat( 0))
       ;elf64_ehsize   := (elf64_half_of_nat( 64))
       ;elf64_phentsize:= (elf64_half_of_nat( 56))
       ;elf64_phnum    := (elf64_half_of_nat phnum)
       ;elf64_shentsize:= (elf64_half_of_nat( 64))
       ;elf64_shnum    := (elf64_half_of_nat shnum)
       ;elf64_shstrndx := (elf64_half_of_nat shstrndx)
       |}.
(* [?]: removed value specification. *)

Definition make_load_phdrs {abifeature : Type}  (max_page_sz : nat ) (common_page_sz : nat ) (img3 : annotated_memory_image abifeature) (section_pairs_bare_sorted_by_address : list (elf64_interpreted_section ))  : list (elf64_program_header_table_entry ):=  
    let phdr_flags_from_section_flags := fun (section_flags : nat ) => fun (sec_name : string ) =>
        let flags := nat_lor elf_pf_r (nat_lor 
            (if flag_is_set shf_write section_flags then elf_pf_w else 0)
            (if flag_is_set shf_execinstr section_flags then elf_pf_x else 0))
        in
        (*let _ = errln ("Phdr flags of section " ^ sec_name ^ "(ELF section flags 0x " ^ 
            (hex_string_of_natural section_flags) ^ ") are 0x" ^ (hex_string_of_natural flags))
        in*)
        flags
    in
    let maybe_extend_phdr := fun (phdr : elf64_program_header_table_entry ) => fun (isec1 : elf64_interpreted_section ) => ( 
        let new_p_type := nat_of_elf64_word(elf64_p_type phdr)
        in
        let this_section_phdr_flags := phdr_flags_from_section_flags(elf64_section_flags isec1)(elf64_section_name_as_string isec1)
        in
        let can_combine_flags := fun (flagsets : set (nat )) => 
            (* The GNU linker happily adds a .rodata section to a RX segment,
             * but not to a RW segment. So the only clear rule is: if any is writable,
             * all must be writable. *)
            let is_writable := fun (flags : nat ) => beq_nat (nat_land flags elf_pf_w) elf_pf_w
            in
            let flagslist := set_to_list flagsets
            in
            let union_flags := List.fold_left nat_lor flagslist ( 0)
            in
            if List.existsb is_writable flagslist
            then
                if List.forallb is_writable flagslist then Some union_flags
                else None
            else
                Some union_flags
        in
        let maybe_extended_flags := can_combine_flags [ this_section_phdr_flags;  nat_of_elf64_word(elf64_p_flags phdr) ]
        in
        if (maybeEqualBy beq_nat maybe_extended_flags None) then (*let _ = errln "flag mismatch" in*) None
        else let new_p_flags := match ( maybe_extended_flags) with  Some flags => flags | _ => DAEMON end
        in
        (* The new filesz is the file end offset of this section,
         * minus the existing file start offset of the phdr. 
         * Check that the new section begins after the old offset+filesz. *)
        if nat_ltb(elf64_section_offset isec1) (Coq.Init.Peano.plus (nat_of_elf64_off(elf64_p_offset phdr)) (nat_of_elf64_xword(elf64_p_filesz phdr)))
        then (*let _ = errln "offset went backwards" in*) None
        else 
        let new_p_filesz := Coq.Init.Peano.plus (nat_of_elf64_xword(elf64_p_filesz phdr)) (if beq_nat(elf64_section_type isec1) sht_progbits then(elf64_section_size isec1) else 0)
        in 
        (* The new memsz is the virtual address end address of this section,
         * minus the existing start vaddr of the phdr. 
         * Check that the new section begins after the old vaddr+memsz. *)
        if nat_ltb(elf64_section_addr isec1) (Coq.Init.Peano.plus (nat_of_elf64_addr(elf64_p_vaddr phdr)) (nat_of_elf64_xword(elf64_p_memsz phdr)))
        then (*let _ = errln "vaddr went backwards" in*) None
        else 
        let new_p_memsz := Coq.Init.Peano.plus (nat_of_elf64_xword(elf64_p_memsz phdr))(elf64_section_size isec1)
        in
        let one_if_zero := fun (n : nat ) => if beq_nat n( 0) then 1 else n
        in
        let new_p_align :=  lcm (one_if_zero (nat_of_elf64_xword(elf64_p_align phdr))) (one_if_zero(elf64_section_align isec1))
        in
        Some
          {|elf64_p_type   := (elf64_word_of_nat new_p_type)
           ;elf64_p_flags  := (elf64_word_of_nat new_p_flags)
           ;elf64_p_offset :=(elf64_p_offset phdr)
           ;elf64_p_vaddr  :=(elf64_p_vaddr phdr)
           ;elf64_p_paddr  :=(elf64_p_paddr phdr)
           ;elf64_p_filesz := (elf64_xword_of_nat new_p_filesz)
           ;elf64_p_memsz  := (elf64_xword_of_nat new_p_memsz)
           ;elf64_p_align  := (elf64_xword_of_nat new_p_align)
           |}
    )
    in
    let rounded_down_offset := fun (isec1 : elf64_interpreted_section ) => round_down_to common_page_sz(elf64_section_offset isec1)
    in
    let offset_round_down_amount := fun (isec1 : elf64_interpreted_section ) => Coq.Init.Peano.minus(elf64_section_offset isec1) (rounded_down_offset isec1)
    in
    let rounded_down_vaddr := fun (isec1 : elf64_interpreted_section ) => round_down_to common_page_sz(elf64_section_addr isec1)
    in
    let vaddr_round_down_amount := fun (isec1 : elf64_interpreted_section ) => Coq.Init.Peano.minus(elf64_section_addr isec1) (rounded_down_vaddr isec1)
    in
    let new_phdr := fun (isec1 : elf64_interpreted_section ) => 
      {|elf64_p_type   := (elf64_word_of_nat elf_pt_load) (** Type of the segment *)
       ;elf64_p_flags  := (elf64_word_of_nat (phdr_flags_from_section_flags(elf64_section_flags isec1)(elf64_section_name_as_string isec1))) (** Segment flags *)
       ;elf64_p_offset := (elf64_off_of_nat (rounded_down_offset isec1)) (** Offset from beginning of file for segment *)
       ;elf64_p_vaddr  := (elf64_addr_of_nat (rounded_down_vaddr isec1)) (** Virtual address for segment in memory *)
       ;elf64_p_paddr  := (elf64_addr_of_nat( 0)) (** Physical address for segment *)
       ;elf64_p_filesz := (elf64_xword_of_nat (if beq_nat(elf64_section_type isec1) sht_nobits then 0 else Coq.Init.Peano.plus(elf64_section_size isec1) (offset_round_down_amount isec1))) (** Size of segment in file, in bytes *)
       ;elf64_p_memsz  := (elf64_xword_of_nat ( Coq.Init.Peano.plus(elf64_section_sizeisec1) (vaddr_round_down_amount isec1))) (** Size of segment in memory image, in bytes *)
       ;elf64_p_align  := (elf64_xword_of_nat (* isec.elf64_section_align *) max_page_sz) (** Segment alignment memory for memory and file *)
       |}
    in
    (* accumulate sections into the phdr *)
    let rev_list := List.fold_left (fun (accum_phdr_list : list (elf64_program_header_table_entry )) => (fun (isec1 : elf64_interpreted_section ) => (
        (* Do we have a current phdr? *)
        match ( accum_phdr_list) with 
            [] => (* no, so make one *)
                (*let _ = errln ("Starting the first LOAD phdr for section " ^ isec.elf64_section_name_as_string)
                in*)
                [new_phdr isec1]
            | current_phdr :: more => 
                (* can we extend it with the current section? *)
                match ( maybe_extend_phdr current_phdr isec1) with 
                    None => 
                        (*let _ = errln ("Starting new LOAD phdr for section " ^ isec.elf64_section_name_as_string)
                        in*)
                        (new_phdr isec1) :: (current_phdr :: more)
                    | Some phdr => phdr :: more
                end
        end
    ))) (List.filter (fun (isec1 : elf64_interpreted_section ) => flag_is_set shf_alloc(elf64_section_flags isec1)
        && negb (flag_is_set shf_tls(elf64_section_flags isec1))) section_pairs_bare_sorted_by_address) []
    in
    (*let _ = errln "Successfully made phdrs"
    in*)
    List.rev rev_list.
(* [?]: removed value specification. *)

Definition make_default_phdrs {abifeature : Type}  (maxpagesize1 : nat ) (commonpagesize1 : nat ) (t : nat ) (img3 : annotated_memory_image abifeature) (section_pairs_bare_sorted_by_address : list (elf64_interpreted_section ))  : list (elf64_program_header_table_entry ):=  
    (* FIXME: do the shared object and dyn. exec. stuff too *)
    make_load_phdrs maxpagesize1 commonpagesize1 img3 section_pairs_bare_sorted_by_address.
(* [?]: removed value specification. *)

Definition find_start_symbol_address {abifeature : Type} `{Ord abifeature} `{AbiFeatureTagEquiv abifeature}  (img3 : annotated_memory_image abifeature)  : option (nat ) :=  
    (* Do we have a symbol called "_start"? *)
    let all_defs := memory_image_orderings.defined_symbols_and_ranges img3
    in
    let get_entry_point := (
  fun (p : (option (element_range ) *symbol_definition ) % type) =>
    match ( (p) ) with ( (maybe_range,  symbol_def)) =>
      if (string_equal (def_symname symbol_def) "_start") then
        Some (maybe_range, symbol_def) else None end
    )
    in
    let all_entry_points := lem_list.mapMaybe get_entry_point all_defs
    in
    match ( all_entry_points) with 
        [(maybe_range,  symbol_def)] =>
            match ( maybe_range) with 
                Some (el_name,  (el_off,  len)) => 
                    match ( (fmap_lookup_by (fun (x : string ) (y : string )=>EQ) el_name(elements img3))) with 
                        None => DAEMON
                        | Some el_rec => 
                            match ((startpos el_rec)) with 
                                None => (*let _ = Missing_pervasives.errln "warning: saw `_start' in element with no assigned address" in *)None
                                | Some x => (* success! *) Some ( Coq.Init.Peano.plus x el_off)
                            end
                    end
                | _ => (*let _ = Missing_pervasives.errln "warning: `_start' symbol with no range" in*) None
            end
        | [] => (* no _start symbol *) None
        | _ => (*let _ = Missing_pervasives.errln ("warning: saw multiple `_start' symbols: " ^
            (let (ranges, defs) = unzip all_entry_points in show ranges)) in *)None
    end.
(* [?]: removed value specification. *)

Definition pad_zeroes  (n : nat )  : list (byte ):=  replicate0 n (byte_of_nat( 0)).
(* [?]: removed value specification. *)

Definition pad_0x90  (n : nat )  : list (byte ):=  replicate0 n (byte_of_nat ( Coq.Init.Peano.mult( 9)( 16))).
(* [?]: removed value specification. *)
 
Definitionnull_abi   : abi (any_abi_feature ):=  {|is_valid_elf_header := is_valid_elf64_header
    ;make_elf_header := (make_elf64_header elf_data_2lsb elf_osabi_none( 0) elf_ma_none)
    ;reloc := noop_reloc
    ;section_is_special := elf_section_is_special
    ;section_is_large := (fun (s : elf64_interpreted_section ) => (fun (f : annotated_memory_image (any_abi_feature )) => false))
    ;maxpagesize := (Coq.Init.Peano.mult (Coq.Init.Peano.mult( 2)( 256))( 4096)) (* 2MB; bit of a guess, based on gdb and prelink code *)
    ;minpagesize :=( 1024) (* bit of a guess again *)
    ;commonpagesize :=( 4096)
    ;symbol_is_generated_by_linker := (fun (symname : string ) => (string_equal symname "_GLOBAL_OFFSET_TABLE_"))
    ;make_phdrs := make_default_phdrs
    ;max_phnum :=( 2)
    ;guess_entry_point := find_start_symbol_address
    ;pad_data := pad_zeroes
    ;pad_code := pad_zeroes
    ;generate_support := ( (* fun _ -> *)fun  _ : list ((string *annotated_memory_image (any_abi_feature )) % type) => get_empty_memory_image tt)
    ;concretise_support := (fun (img3 : annotated_memory_image (any_abi_feature )) => img3)
    |}.
(* [?]: removed value specification. *)

Definition got_entry_ordering  (p : (string *option (symbol_definition ) ) % type) (p0 : (string *option (symbol_definition ) ) % type)  : ordering := 
  match ( (p,p0)) with ( (s1,  md1),  (s2,  md2)) => EQ end.
(* [?]: removed value specification. *)

Definition amd64_generate_support  (input_fnames_and_imgs : list ((string *annotated_memory_image (any_abi_feature )) % type))  : annotated_memory_image (any_abi_feature ):=  
  (* We generate a basic GOT. At the moment we can only describe the GOT
     * contents abstractly, not as its binary content, because addresses
     * have not yet been fixed. 
     * 
     * To do this, we create a set of Abi_amd64.GOTEntry records, one for
     * each distinct symbol that is referenced by one or more GOT-based relocations.
     * To enumerate these, we look at all the symbol refs in the image.
     *)
  match ( unzip input_fnames_and_imgs) with (fnames,  input_imgs) =>
    let tags_and_ranges_by_image := lem_list.mapi
                                      (fun (i : nat ) =>
                                         fun (p : (string *annotated_memory_image (any_abi_feature )) % type) =>
                                           match ( (p) ) with
                                               ( (fname1,  img3)) =>
                                             (i, fname1, multimap.lookupBy0
                                                           memory_image_orderings.tagEquiv
                                                           (SymbolRef
                                                              (null_symbol_reference_and_reloc_site))
                                                           (by_tag img3)) end
                                      ) input_fnames_and_imgs in
  let refs_via_got := list_concat_map
                        (fun (p : (nat *string *list ((range_tag (any_abi_feature )*option (element_range ) ) % type)) % type) =>
                           match ( (p) ) with
                               ( (i,  fname1,  tags_and_ranges)) =>
                             lem_list.mapMaybe
                               (fun (p : (range_tag (any_abi_feature )*option (element_range ) ) % type) =>
                                  match ( (p) ) with
                                      ( (tag,  maybe_range)) =>
                                    match ( tag) with SymbolRef(rr) =>
                                      (* Is this ref a relocation we're going to apply, and does it reference the GOT? *)
                                      match ( ((maybe_relocrr),(maybe_def_bound_to rr))) with
                                          (None,  _) => None
                                        | (Some r,  Some(ApplyReloc,  maybe_def)) =>
                                        if ( (set_member_by
                                                (genericCompare nat_ltb
                                                   beq_nat)
                                                (get_elf64_relocation_a_type
                                                   (ref_relent r))
                                                [
                                                r_x86_64_got32;  r_x86_64_gotpcrel;  (* r_x86_64_gottpoff; *) r_x86_64_gotoff64;  r_x86_64_gotpc32 (* ; r_x86_64_gotpc32_tlsdesc *)
                                                ])) then
                                          (*let _ = errln ("Saw a via-GOT symbol reference: " ^ rr.ref.ref_symname ^ " coming from linkable " ^ (show i) ^ " (" ^ 
                            fname ^ "), logically from section " ^ (show r.ref_src_scn)) in *)
                                          Some
                                            ((ref_symname(refrr)), maybe_def)
                                        else None
                                        | (Some r,  Some(MakePIC,  maybe_def)) =>
                                        DAEMON | (Some _, None) =>
                                        DAEMON (* Incomplete Pattern at File \"abis/abis.lem\", line 356, character 13 to line 366, character 15 *)
                                        | (Some _, Some(LeaveReloc,  _)) =>
                                        DAEMON (* Incomplete Pattern at File \"abis/abis.lem\", line 356, character 13 to line 366, character 15 *)
                                      end | _ => DAEMON end end)
                               tags_and_ranges end) tags_and_ranges_by_image
  in
  match ( unzip refs_via_got) with (symnames,  maybe_defs) =>
    (*let _ = errln ("GOT includes defs with names: " ^ (show (Set_extra.toList (Set.fromList symnames))))
    in*)
  let pairs_set := (set_from_list_by
                      (pairCompare (fun (x : string ) (y : string )=> EQ)
                         (maybeCompare
                            (fun (x : symbol_definition ) (y : symbol_definition )=>
                               EQ))) refs_via_got) in
  let defs_set := (set_from_list_by
                     (maybeCompare
                        (fun (x : symbol_definition ) (y : symbol_definition )=>
                           EQ)) maybe_defs) in
  (* Quirk: what if we have the same def appearing under two different symnames?
     * This shouldn't happen, at present. 
     * What if we have the same symname related to two different defs? This also 
     * shouldn't happen, because only global symbols go in the GOT, so we don't have
     * to worry about local symbols with the same name as another symbol. But still, it 
     * could plausibly happen in some situations with weird symbol visibilities or binding. *)
  (* if Set.size pairs_set <> Set.size defs_set then
        failwith "something quirky going on with GOT symbol defs and their names"
    else *)
  (*    let name_def_pairs = List.foldl (fun acc -> fun (idx, symname, (maybe_range, rr)) -> 
        Set.insert (
        
                symname, (match rr.maybe_def_bound_to with
        Map.lookup symname acc with 
            Nothing -> [item]
            | Just l -> item :: l
        end) acc) {} refs_via_got
    in *)
  let nentries :=  (set_cardinal pairs_set) in let entrysize := 8 in
  let new_by_range := [
                      (Some
                         (".got", ( 0, Coq.Init.Peano.mult nentries entrysize)), 
                      AbiFeature
                        (Amd64AbiFeature (abi_amd64.GOT0 (refs_via_got))))
                      ;  (Some
                            (".got", ( 0, Coq.Init.Peano.mult nentries
                                            entrysize)), FileFeature
                                                           (ElfSection
                                                              ( 1,
                                                              {|elf64_section_name :=(
                                                               0) (* ignored *)
                                                              ;elf64_section_type := sht_progbits
                                                              ;elf64_section_flags := (
                                                              nat_lor
                                                                shf_write
                                                                shf_alloc)
                                                              ;elf64_section_addr :=(
                                                               0) (* ignored -- covered by element *)
                                                              ;elf64_section_offset :=(
                                                               0) (* ignored -- will be replaced when file offsets are assigned *)
                                                              ;elf64_section_size := (
                                                              Coq.Init.Peano.mult
                                                                nentries
                                                                entrysize) (* ignored *)
                                                              ;elf64_section_link :=(
                                                               0)
                                                              ;elf64_section_info :=(
                                                               0)
                                                              ;elf64_section_align :=(
                                                               8)
                                                              ;elf64_section_entsize :=(
                                                               8)
                                                              ;elf64_section_body := byte_sequence.empty (* ignored *)
                                                              ;elf64_section_name_as_string := ".got"
                                                              |}) ))
                      ;  (* FIXME: _GLOBAL_OFFSET_TABLE_ generally doesn't mark the *start* of the GOT; 
         * it's some distance in. What about .got.plt? *)
                      (Some
                         (".got", ( 0, Coq.Init.Peano.mult nentries entrysize)), 
                      SymbolDef
                        ({|def_symname := "_GLOBAL_OFFSET_TABLE_"
                        ;def_syment := {|elf64_st_name := (elf64_word_of_nat
                                                             ( 0)) (* ignored *)
                        ;elf64_st_info := (unsigned_char_of_nat ( 0)) (* FIXME *)
                        ;elf64_st_other := (unsigned_char_of_nat ( 0)) (* FIXME *)
                        ;elf64_st_shndx := (elf64_half_of_nat ( 1))
                        ;elf64_st_value := (elf64_addr_of_nat ( 0)) (* ignored *)
                        ;elf64_st_size := (elf64_xword_of_nat
                                             ( Coq.Init.Peano.mult nentries
                                                 entrysize)) (* FIXME: start later, smaller size? zero size? *)
                        |} ;def_sym_scn :=( 1) ;def_sym_idx :=( 1)
                        ;def_linkable_idx :=( 0) |})) ] in
  {|elements := (fmap_add ".got"
                   {|startpos := None
                   ;length1 := (Some
                                  ( Coq.Init.Peano.mult nentries entrysize))
                   ;contents := [] |} fmap_empty)
  ;by_tag := (by_tag_from_by_range new_by_range) ;by_range := new_by_range |}
  end end.
(* [?]: removed value specification. *)

Definition amd64_concretise_support  (img3 : annotated_memory_image (any_abi_feature ))  : annotated_memory_image (any_abi_feature ):=  
    (* Fill in the GOT contents. *)
    match ( (fmap_lookup_by (fun (x : string ) (y : string )=>EQ) ".got"(elements img3))) with 
        None => (* got no GOT? okay... *) img3
        | Some got_el => 
            (* Find the GOT tag. *)
            let tags_and_ranges := multimap.lookupBy0 memory_image_orderings.tagEquiv (AbiFeature(Amd64AbiFeature(abi_amd64.GOT0([]))))(by_tag img3)
            in
            match ( tags_and_ranges) with 
                [] => DAEMON
                | [(AbiFeature(Amd64AbiFeature(abi_amd64.GOT0(l))),  Some(got_el_name,  (got_start_off,  got_len)))] => 
                    (* We replace the GOT element's contents with the concrete addresses
                     * of the symbols it should contain. We leave the metadata label in there,
                     * for the relocation logic to find. If we change the order of entries, 
                     * change it there too. *)
                    let content := list_concat_map (
  fun (p : (string *option (symbol_definition ) ) % type) =>
    match ( (p) ) with ( (symname,  maybe_def)) =>
      let addr := match ( maybe_def) with None =>  0 | Some sd =>
                    match ( memory_image_orderings.find_defs_matching sd img3) with
                        [] => DAEMON
                      | [((def_el_name,  (def_start,  def_len)),  d)] =>
                      match ( element_and_offset_to_address
                                (def_el_name, def_start) img3) with None =>
                        DAEMON | Some addr =>
                        (*let _ = errln ("GOT slot for symbol `" ^ symname ^ 
                                                "' created pointing to address 0x" ^ (hex_string_of_natural addr) ^ 
                                                " (offset 0x" ^ (hex_string_of_natural def_start) ^ " in element " ^ def_el_name ^ ")")
                                            in*)
                      addr end | _ => DAEMON end end in
    let addr_bytes := natural_to_le_byte_list addr in
    (@ List.app _) (List.map (fun (b : byte ) => Some b) addr_bytes)
      (replicate0 ( Coq.Init.Peano.minus ( 8) (length addr_bytes))
         (Some (byte_of_nat ( 0)))) end
                    ) l
                    in
                    let new_el := 
                        {|contents := content
                         ;startpos :=(startpos got_el)
                         ;length1   :=(length1 got_el)
                         |}
                    in
                    let new_tag := AbiFeature(Amd64AbiFeature(abi_amd64.GOT0(l)))
                    in
                    let range1 := Some(got_el_name, (got_start_off, got_len))
                    in
                    let new_by_tag :=                        
(set_union_by (pairCompare (fun (x : range_tag (any_abi_feature )) (y : range_tag (any_abi_feature ))=>EQ) (maybeCompare (pairCompare (fun (x : string ) (y : string )=>EQ) (pairCompare (genericCompare nat_ltb beq_nat) (genericCompare nat_ltb beq_nat))))) ( (set_diff_by (pairCompare (fun (x : range_tag (any_abi_feature )) (y : range_tag (any_abi_feature ))=>EQ) (maybeCompare (pairCompare (fun (x : string ) (y : string )=>EQ) (pairCompare (genericCompare nat_ltb beq_nat) (genericCompare nat_ltb beq_nat)))))((by_tagimg3) :  set  (((range_tag  any_abi_feature ) * (option  element_range  )) % type))
                        [(AbiFeature(Amd64AbiFeature(abi_amd64.GOT0(l))), range1)])) [(new_tag, range1)])
                    in
                    {|elements := (fmap_add ".got" new_el ((fmap_delete_by (fun (x : string ) (y : string )=>EQ) ".got"(elements img3))))
                     ;by_tag   := new_by_tag
                     ;by_range := (by_range_from_by_tag new_by_tag)
                     |}
                    
                | _ => DAEMON
            end
    end.
(* [?]: removed value specification. *)

Definition sysv_amd64_std_abi   : abi (any_abi_feature ):=  
   {|is_valid_elf_header := header_is_amd64
    ;make_elf_header := (make_elf64_header elf_data_2lsb elf_osabi_none( 0) elf_ma_x86_64)
    ;reloc := amd64_reloc
    ;section_is_special := section_is_special0
    ;section_is_large := (fun (s : elf64_interpreted_section ) => (fun (f : annotated_memory_image (any_abi_feature )) => flag_is_set shf_x86_64_large(elf64_section_flags s)))
    ;maxpagesize :=( 65536)
    ;minpagesize :=( 4096)
    ;commonpagesize :=( 4096)
      (* XXX: DPM, changed from explicit reference to null_abi field due to problems in HOL4. *)
    ;symbol_is_generated_by_linker := (fun (symname : string ) => (string_equal symname "_GLOBAL_OFFSET_TABLE_"))
    ;make_phdrs := make_default_phdrs
    ;max_phnum :=( 4)
    ;guess_entry_point := find_start_symbol_address
    ;pad_data := pad_zeroes
    ;pad_code := pad_0x90
    ;generate_support := amd64_generate_support
    ;concretise_support := amd64_concretise_support
    |}.
(* [?]: removed value specification. *)

Definition sysv_aarch64_le_std_abi   : abi (any_abi_feature ):=  
   {|is_valid_elf_header := header_is_aarch64_le
    ;make_elf_header := (make_elf64_header elf_data_2lsb elf_osabi_none( 0) elf_ma_aarch64)
    ;reloc := aarch64_le_reloc
    ;section_is_special := section_is_special0
    ;section_is_large := (fun  _ : elf64_interpreted_section  => (fun  _ : annotated_memory_image (any_abi_feature ) => false))
    ;maxpagesize := (Coq.Init.Peano.mult (Coq.Init.Peano.mult( 2)( 256))( 4096)) (* 2MB; bit of a guess, based on gdb and prelink code *)
    ;minpagesize :=( 1024) (* bit of a guess again *)
    ;commonpagesize :=( 4096)
    ;symbol_is_generated_by_linker := (fun (symname : string ) => (string_equal symname "_GLOBAL_OFFSET_TABLE_"))
    ;make_phdrs := make_default_phdrs
    ;max_phnum :=( 5)
    ;guess_entry_point := find_start_symbol_address
    ;pad_data := pad_zeroes
    ;pad_code := pad_zeroes
    ;generate_support := ( (* fun _ -> *)fun  _ : list ((string *annotated_memory_image (any_abi_feature )) % type) => get_empty_memory_image tt)
    ;concretise_support := (fun (img3 : annotated_memory_image (any_abi_feature )) => img3)
    |}.
(* [?]: removed value specification. *)

Definition all_abis   : list (abi (any_abi_feature )):=  [sysv_amd64_std_abi; sysv_aarch64_le_std_abi; null_abi].
