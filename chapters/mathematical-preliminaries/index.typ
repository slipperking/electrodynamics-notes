#import "/lib.typ": *
#show: docs-chapter.with(
  title: [Mathematical Preliminaries],
  route: "mathematical-preliminaries",
  children: {
    include "vectors/index.typ"
    include "calculus/index.typ"
  },
)

The following sections will outline the mathematical preliminaries necessary in the continuation of the proceeding chapters. It will transpire that the mathematical notions we will entertain will not hence require the same sense of rigorous definition in a mathematical case. Much thereof will be based more principally on heuristics and intuition, and more of the nuanced details will be glossed over. For instance, in settings which place a more distinct emphasis upon analytical rigor, many operations are only possible under precursory conditions---such as continuity---to be justified. The very definition of a "function" will necessarily be bent in a way to allow for more information to be encoded. Most notably, the Dirac delta function (see @todo), which by the strict interpretation of a function, cannot be satisfactorily described, without the generalized notion of a function with distributions; here we will make no such distinction.

