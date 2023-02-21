(* adapted from https://github.com/lpw25/girards-paradox/blob/17ccd5d/girard.ml *)
(* un-comment line 42 for the code to compile *)
module type Type = sig module type T end

module Pred (A : Type) = struct
  module type T =
    functor (_ : A.T) -> Type
end
module Eq (A : Type) (X : A.T) (Y : A.T) = struct
  module type T =
    functor (P : Pred(A).T) (_ : P(X).T) -> P(Y).T
end

module Rel (A : Type) (B : Type) = struct
  module type T = functor (_ : A.T) (_ : B.T) -> Type
end

module IsUnique (A : Type) (B : Type) (R : Rel(A)(B).T) = struct
  module type T =
    functor (X : A.T)
            (Y1 : B.T) (XtoY1 : R(X)(Y1).T)
            (Y2 : B.T) (XtoY2 : R(X)(Y2).T)
       -> Eq(B)(Y1)(Y2).T

end

module Func (A : Type) (B : Type) = struct
  module type T = sig
    module Maps : Rel(A)(B).T
    module Unique : IsUnique(A)(B)(Maps).T
  end
end

module Comp (A : Type) (B : Type) (C : Type)
            (F1 : Func(A)(B).T) (F2 : Func(B)(C).T) = struct

  module Maps (X : A.T) (Z : C.T) = struct
    module type T =
      functor (K : Type)
              (_ : functor (Y : B.T)
                            (* the code compiles if the next line is un-commented *)
                           (* (XToY : F1.Maps(X)(Y).T) *) 
                           (YtoZ : F2.Maps(Y)(Z).T)
                   -> K.T)
        -> K.T
  end

  module Unique (X : A.T)
                (Z1 : C.T) (XtoZ1 : Maps(X)(Z1).T)
                (Z2 : C.T) (XtoZ2 : Maps(X)(Z2).T) =
      XtoZ1(Eq(C)(Z1)(Z2))(functor
          (Y1 : B.T)
          (XtoY1 : F1.Maps(X)(Y1).T)
          (Y1toZ1 : F2.Maps(Y1)(Z1).T) ->
            XtoZ2(Eq(C)(Z1)(Z2))(functor
              (Y2 : B.T)
              (XtoY2 : F1.Maps(X)(Y2).T)
              (Y2toZ2 : F2.Maps(Y2)(Z2).T) ->
                 F2.Unique
                   (Y2)
                   (Z1)(F1.Unique(X)(Y1)(XtoY1)(Y2)(XtoY2)
                          (functor (E : B.T) -> F2.Maps(E)(Z1))(Y1toZ1))
                   (Z2)(Y2toZ2)))

end

module TypeCheck(A : Type)(B : Type)(C : Type)
            (F1 : Func(A)(B).T) (F2 : Func(B)(C).T) 
            : Func(A)(C).T = Comp(A)(B)(C)(F1)(F2)
