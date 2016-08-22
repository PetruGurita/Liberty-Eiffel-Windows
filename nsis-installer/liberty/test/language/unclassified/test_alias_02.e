class TEST_ALIAS_02

insert
   EIFFELTEST_TOOLS

create {}
   make

feature {}
   make
      local
         f: like sq
         g: like u
      do
         f := sq
         assert(f(2) = 4)
         assert(f(4) = 16)

         g := u
         assert(g /= Void)
         assert(g() = 42)

         assert(u /= Void)
         assert(u() = 42)

         assert(universal = 42)

         -- not-syntactic case (needs semantic analysis)
         assert(sq(2) = 4)
         assert(sq(4) = 16)
      end

   sq: FUNCTION[TUPLE[INTEGER], INTEGER]
      do
         Result := agent square(?)
      end

   square (i: INTEGER): INTEGER
      do
         Result := i*i
      end

   u: FUNCTION[TUPLE, INTEGER]
      do
         Result := agent universal
      end

   universal: INTEGER 42

end
