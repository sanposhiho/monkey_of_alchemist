defmodule Token do
  defstruct [:type, :literal]

  defmacro tokentype do
    %{
      illegal: "illegal",
      eof: "eof",

      #識別子 + リテラル
      ident: "ident",
      int: "int",

      #演算子
      assign: "=",
      plus: "+",

      #デリミタ
      comma: ",",
      semicolon: ";",

      lparen: "(",
      rparen: ")",
      lbrace: "{",
      rbrace: "}",

      #キーワード
      function: "function",
      let: "let",
    }
  end
end
