# Internal error in`ocamlc` on extreme code: `Ctype.Nondep_cannot_erase`

https://github.com/ocaml/ocaml/issues/12014

## Steps to Repro

using ocaml 5.0.0, tested on Mac 13.1 (22C65) with M1

`ocamlc girard.ml`

girard.ml is in this repo and is the same as the `girard.ml` in github.com/lpw25/girards-paradox, with the following line appended:

```
module M = Paradox(struct let one = 1 end)
```

## Actual Behavior

Fatal error

```
Fatal error: exception Ctype.Nondep_cannot_erase(_)
Raised at Mtype.nondep_mty_with_presence in file "typing/mtype.ml", line 190, characters 14-50
Called from Mtype.nondep_mty in file "typing/mtype.ml" (inlined), line 226, characters 6-58
Called from Mtype.nondep_supertype in file "typing/mtype.ml", line 262, characters 31-52
Called from Stdlib__Option.map in file "option.ml", line 24, characters 57-62
Called from Includemod.Functor_app_diff.update in file "typing/includemod.ml", line 1151, characters 14-68
Called from Diffing.Define.Right_variadic.Internal.update in file "utils/diffing.ml", line 437, characters 25-42
Called from Diffing.Define.Generic.compute_inner_cell in file "utils/diffing.ml", line 351, characters 14-36
Called from Diffing.Define.Generic.compute_matrix.loop in file "utils/diffing.ml", line 379, characters 10-28
Called from Diffing.Define.Right_variadic.diff in file "utils/diffing.ml", line 443, characters 6-39
Called from Includemod_errorprinter.Functor_suberror.App.patch in file "typing/includemod_errorprinter.ml" (inlined), line 460, characters 6-51
Called from Includemod_errorprinter.report_apply_error in file "typing/includemod_errorprinter.ml", line 899, characters 10-55
Called from Misc.try_finally in file "utils/misc.ml", line 31, characters 8-15
Re-raised at Misc.try_finally in file "utils/misc.ml", line 45, characters 10-56
Called from Stdlib__Fun.protect in file "fun.ml", line 33, characters 8-15
Re-raised at Stdlib__Fun.protect in file "fun.ml", line 38, characters 6-52
Called from Persistent_env.without_cmis in file "typing/persistent_env.ml", line 142, characters 10-109
Called from Includemod_errorprinter.register.(fun) in file "typing/includemod_errorprinter.ml", line 931, characters 15-149
Called from Location.error_of_exn.loop in file "parsing/location.ml", line 940, characters 16-21
Called from Location.report_exception.loop in file "parsing/location.ml", line 958, characters 10-26
Re-raised at Location.report_exception.loop in file "parsing/location.ml", line 959, characters 14-25
Called from Maindriver.main in file "driver/maindriver.ml", line 110, characters 4-35
Called from Main in file "driver/main.ml", line 2, characters 7-54
```

# Expected Behavior, Related, etc.

https://github.com/ocaml/ocaml/issues/12014
