" HIGHLIGHT ALL MATH OPERATOR
syn match cMathOperator display "[-+\*/%=]"
syn match cPointerOperator display "->\|\."
syn match cLogicalOperator display "[!<>]=\="
syn match cLogicalOperator display "=="
syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\="
syn match cBinaryOperator display "\~"
syn match cBinaryOperatorError display "\~="
syn match cLogicalOperator  display "&&\|||"
syn match cLogicalOperatorError display "\(&&\|||\)="
syn match cInterpunction display "[,;]"
hi cMathOperator ctermfg=white
hi cPointerOperator ctermfg=white
hi cLogicalOperator ctermfg=white
hi cBinaryOperator ctermfg=white
hi cBinaryOperatorError ctermfg=white
hi cLogicalOperator ctermfg=white
hi cLogicalOperatorError ctermfg=white
hi cInterpunction ctermfg=white
